package com.rutkoski.net
{
  import flash.net.NetConnection;
  import flash.net.Responder;

/**
 *
 */
public class AMFCommand
{

  public static var DEBUG:Boolean = false;

  protected var _callback:Function;
  protected var command:String;
  protected var conn:NetConnection;
  protected var _data:*;
  protected var resp:Responder;
  protected var _status:Object;

  public function get status():Object { return _status; }

  public function get data():* { return _data; }

  public function AMFCommand(command:String)
  {
    this.command = command;

    resp = new Responder(amf_result, amf_status);
  }

  public function execute(callback:Function = null, ... args):void
  {
    _callback = callback;

		args.unshift(command, resp);

		if (DEBUG) {
			trace(this, args);
		}

		conn = AMFConnection.getConnection();
		conn.call.apply(this, args);
  }

  public function executeArray(callback:Function = null, props:Array = null, thisArg:* = null):void
  {
    var args:Array = [callback];

    if (thisArg != null && props) {
      for each (var prop:String in props) {
        args.push(thisArg[prop]);
      }
    } else {
      args = args.concat(props);
    }

    execute.apply(this, args);
  }

  protected function amf_status(status:Object):void
  {
    _status = status;

    if (DEBUG) {
      trace(this, status);
    }

		for (var i:String in status) 
			trace(i + ': ' + status[i]);
    /*throw new Error(status.description + "\nin "
      + status.details + ':' + status.line,
      status.code);*/
  }

  protected function amf_result(data:*):void
  {
    _data = data;

    if (DEBUG) {
      trace(this, data);
    }

    if (_callback != null) {
      _callback(data);
    }
  }

}

}