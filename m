From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Tue, 26 Jan 2016 15:00:10 +0100
Message-ID: <20160126140010.GA29723@amd>
References: <20160123121022.GB12497@amd>
 <20160125163332.GT19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160125163332.GT19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > Power consumption seems to be in 500mA range, regardless of
> > off_mode. That would mean about 2 hours of battery life, AFAICT.
> 
> Sounds like you have USB connected and charging? You can
> get into just few mW range with the mainline kernel for sure
> on omap3. It's just a quetion of fixing whatever few drivers
> that are still causing issues on n900.
> 
> Typically you need at least USB disconnected and LCD blanked
> to start hitting the deeper idle states :)

Ok, no 4.4 kernel + your patch this time, USB disconnected, LCD
blanked, but wifi connected and X session running on inactive vt. GSM
connected to network.

It seems like I have rather lot of blocking bits:

usbhost_pwrdm
(ON),OFF:3321,RET:37501,INA:0,ON:40823,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm
(OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm
(ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm
(ON),OFF:3321,RET:33,INA:0,ON:3355,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm
(ON),OFF:3321,RET:19014,INA:0,ON:22336,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm
(ON),OFF:3321,RET:37500,INA:2,ON:40824,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:3321,RET:37501,INA:0,ON:40823,RET-LOGIC-OFF:0
mpu_pwrdm
(ON),OFF:3321,RET:37501,INA:0,ON:40823,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm
(OFF),OFF:1,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RE
T-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (1)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (20)
core_l3_clkdm->core_pwrdm (2)
neon_clkdm->neon_pwrdm (0)
00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
ffdffe8d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200072
0000000d 48004a28 (fa004a28) cm_idlest3_core

cm_idlest1_core changes periodicall often, to 00218072. The rest seems
constant.

I'm using script below:

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

sudo cat /sys/kernel/debug/pm_debug/count

. Does it mean that more than 5 devices block the suspend?

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
