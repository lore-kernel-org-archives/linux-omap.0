From: Kevin Hilman <khilman@ti.com>
Subject: debug needed: twl4030 RTC wakeups: repeated attempts fail on Beagle
Date: Fri, 10 Aug 2012 11:49:27 -0700
Message-ID: <87d32yd1l4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:57271 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932213Ab2HJSt3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Aug 2012 14:49:29 -0400
Received: by pbcwy7 with SMTP id wy7so2817448pbc.6
        for <linux-omap@vger.kernel.org>; Fri, 10 Aug 2012 11:49:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: NeilBrown <neilb@suse.de>, Russ Dill <russ.dill@gmail.com>

Hello,

In doing some automated testing of suspend/resume I noticed that
repeated attempts to suspend and resume via RTC wakeup fail on
3530/Beagle and 3730/Beagle-xM, but work fine on 3430/n900, 3530/Overo,
3730/OveroSTORM and 4430/Panda.

When RTC wakeup fails, a UART wakeup will work, and in the logs, you'll
see this:

[  316.036132] twl: i2c_read failed to transfer all messages
[  316.036163] twl4030: I2C error -13 reading PIH ISR

My guess about what might be happening is that very late in the suspend
process (during the noirq hooks), a PMIC interrupt fires, but by this
time the I2C driver is runtime suspended (and clock gated.)  Since
runtime PM is disabled at this point, I2C reads fail, so the twl4030 IRQ
driver cannot talk over I2C to the PMIC to determine the interrupt
source.

The real mystery is why this happens on Beagle and Beagle-xM, but none
of the other OMAP3 boards (at least the ones I have.)

Reproducing is easy.  Simply run rtcwake in a loop:

  # while true; do rtcwake -m mem -s 1; done

In my tests, this happens using omap2plus_defconfig (+ initramfs) on
v3.6-rc1, v3.5, v3.4, v3.3 but seems to work fine on v3.2.

I'm going on vacation for a few weeks, so any help debugging this would
be greatly appreciated. 

Thanks,

Kevin
