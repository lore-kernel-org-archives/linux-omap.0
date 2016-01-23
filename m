From: Pavel Machek <pavel@ucw.cz>
Subject: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Sat, 23 Jan 2016 13:10:22 +0100
Message-ID: <20160123121022.GB12497@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

I enabled the sleep leds, and am using following script to set the
machine up for power management:

#!/bin/bash
uarts=$(find /sys/class/tty/ttyO*/device/power/ -type d)
for uart in $uarts; do
    echo 3000 > $uart/autosuspend_delay_ms
    done
    uarts=$(find /sys/class/tty/ttyO*/power/ -type d)
for uart in $uarts; do
        echo enabled > $uart/wakeup
	    echo auto > $uart/control
	    done
sudo mount /dev/zero -t debugfs /sys/kernel/debug/
echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode

So far, the LEDs stubbornly stay on :-(. Machine is booted off
sd-card, and I'm connected to it over wifi. GSM is active, X is
running.

Normally, ping looks like this:

64 bytes from 192.168.43.15: icmp_seq=371 ttl=64 time=2.18 ms
64 bytes from 192.168.43.15: icmp_seq=372 ttl=64 time=2.21 ms
64 bytes from 192.168.43.15: icmp_seq=373 ttl=64 time=2.94 ms

When I enable the off mode:
echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode

Wifi is no longer happy:

64 bytes from 192.168.43.15: icmp_seq=426 ttl=64 time=351 ms
64 bytes from 192.168.43.15: icmp_seq=427 ttl=64 time=178 ms
64 bytes from 192.168.43.15: icmp_seq=428 ttl=64 time=2.36 ms

and touchscreen stops working:

[99480.564910] tsc2005 spi1.0: TSC200X not responding - resetting
[99486.995758] bq27xxx-battery 2-0055: battery is not calibrated!
ignoring capacity values
[99488.564147] tsc2005 spi1.0: TSC200X not responding - resetting
[99495.550018] bq27xxx-battery 2-0055: battery is not calibrated!
ignoring capacity values
[99496.564208] tsc2005 spi1.0: TSC200X not responding - resetting
[99504.129852] bq27xxx-battery 2-0055: battery is not calibrated!
ignoring capacity values
[99504.564208] tsc2005 spi1.0: TSC200X not responding - resetting

echo 0 > /sys/kernel/debug/pm_debug/enable_off_mode

Fixes both wifi and touchscreen. Is off_mode expected to break
touchscreen? Any ideas what needs to be shut down so that the sleep
leds go off?

Power consumption seems to be in 500mA range, regardless of
off_mode. That would mean about 2 hours of battery life, AFAICT.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
