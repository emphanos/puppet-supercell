#!/bin/bash
# blatantly lifted from http://robfan.com/post/122618829/continuous-integration-selenium-firefox-flash
SELENIUMSERVER="/usr/local/selenium/selenium-server-standalone.jar"
#JAVABIN="/usr/lib/jvm/java-6-sun-1.6.0.26/jre/bin/java"
JAVABIN="/usr/lib/jvm/java-6-sun/jre/bin/java"
case "${1:-''}" in
        'start')
                if test -f /tmp/selenium.pid
                then
                        echo "Selenium is already running."
                else
                        DISPLAY=:1 $JAVABIN -jar $SELENIUMSERVER > /tmp/selenium.log & echo $! > /tmp/selenium.pid
                        echo "Starting Selenium..."

                        error=$?
                        if test $error -gt 0
                        then
                                echo "${bon}Error $error! Couldn't start Selenium!${boff}"
                        fi 
		fi 
		;;
        'stop')
                if test -f /tmp/selenium.pid
                then
                        echo "Stopping Selenium..."
                        PID=`cat /tmp/selenium.pid`
                        kill -3 $PID
                        if kill -9 $PID ;
                                then
                                        sleep 2
                                        test -f /tmp/selenium.pid && rm -f /tmp/selenium.pid                                else                                        echo "Selenium could not be stopped..."
                                fi
                else
                        echo "Selenium is not running."
                fi
                ;;
        'restart')
                if test -f /tmp/selenium.pid
                then
                        kill -HUP `cat /tmp/selenium.pid`
                        test -f /tmp/selenium.pid && rm -f /tmp/selenium.pid
                        sleep 1
                        DISPLAY=:1 $JAVABIN -jar $SELENIUMSERVER > /tmp/selenium.log & echo $! > /tmp/selenium.pid
                        echo "Reload Selenium..."
                else
                        echo "Selenium isn't running..."
                fi
                ;;
        *)      # no parameter specified
                echo "Usage: $SELF start|stop|restart|reload|force-reload|status"
                exit 1
        ;;
esac
