package com.rutkoski.net
{
  import flash.events.NetStatusEvent;
  import flash.net.NetConnection;
  import flash.net.ObjectEncoding;

/**
 *
 */
public class AMFConnection
{

  public static var gateway:String;

  private static var conn:NetConnection;

  public static function getConnection():NetConnection
  {
    if (!conn) {
      conn = new NetConnection();
      conn.objectEncoding = ObjectEncoding.AMF3;
    }

    if (!conn.connected) {
      conn.connect(gateway);
    }

    return conn;
  }

}

}