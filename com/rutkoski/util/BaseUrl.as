/**
 * BaseUrl
 *
 * @author Rodrigo Rutkoski Rodrigues <rutkoski@gmail.com>
 *
 * This is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.rutkoski.util 
{
        import flash.display.DisplayObjectContainer;
        import flash.display.Sprite;
        import flash.events.Event;
        import flash.system.Capabilities;
        
        /**
         * Classe de configuração do caminho base para o swf (root path).
         * 
         * Utilização:
         * 
         * - no primeiro frame inserir o comando:
         *   import com.rutkoski.util.BaseUrl;
         *   BaseUrl.setup(this, 'http://localhost/projeto/');
         * 
         * - o primeiro parâmetro deve ser um movieclip (quase sempre será this);
         * - o segundo parâmetro é o valor padrão para ser usado quando o filme não estiver rodando no browser;
         * - o terceiro parâmetro é o nome do parâmetro do flash vars;
         * 
         * - sempre que necessário usar o root path:
         *   loader.load(new URLRequest(BaseUrl.value + 'file.swf'));
         * 
         * @author Rodrigo Rutkoski Rodrigues <rutkoski@gmail.com>
         */
        public class BaseUrl extends Sprite
        {
                
                public static var paramName:String = 'root_path';
                
                public static var defaultValue:String;
                
                protected static var _browserValue:String;
                
                public function BaseUrl() 
                {
                        if (stage) {
                                init();
                        }
                        else {
                                addEventListener(Event.ADDED_TO_STAGE, init);
                        }
                }
                
                public static function setup(container:DisplayObjectContainer, defaultValue:String, paramName:String = null):String
                {
                        BaseUrl.defaultValue = defaultValue;
                        
                        if (paramName) {
                                BaseUrl.paramName = paramName;
                        }
                        
                        var baseUrl:BaseUrl = new BaseUrl();
                        container.addChild(baseUrl);
                        container.removeChild(baseUrl);
                        
                        baseUrl = null;
                        
                        return BaseUrl.value;
                }
                
                public static function get value():String
                {
                        if (isBrowser && ! browserValue) {
                                throw new Error('O parâmetro ' + paramName + ' não foi definido no flash vars');
                        }
                        
                        return isBrowser ? browserValue : defaultValue;
                }
                
                public static function get browserValue():String
                {
                        return _browserValue;
                }
                
                protected static function get isBrowser():Boolean
                {
                        var type:String = Capabilities.playerType;
                        return (type == 'ActiveX' || type == 'PlugIn');
                }
                
                protected function init(e:Event = null):void 
                {
                        removeEventListener(Event.ADDED_TO_STAGE, init);
                        
                        _browserValue = stage.loaderInfo.parameters[paramName];
                }
                
        }

}