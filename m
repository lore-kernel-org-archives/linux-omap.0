From: Ran Shalit <ranshalit@gmail.com>
Subject: Smartreflex - validation failed
Date: Mon, 17 Nov 2014 20:05:28 +0200
Message-ID: <CAJ2oMhJOj+bkcnP1bruaqJmEZ5KPfVxBiJrW4zeXUn1JLZ+Z0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:53081 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbaKQSF3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2014 13:05:29 -0500
Received: by mail-wg0-f51.google.com with SMTP id k14so6265396wgh.24
        for <linux-omap@vger.kernel.org>; Mon, 17 Nov 2014 10:05:28 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Does anyone knows how to validate smartreflex operation?

I am setting new fequency but I than see that the voltage in all
points is still the same as following:

It seems that smartreflex is not enabled in default, so I enable
smartreflext as following:

~ # echo 1 > /dbg/voltage/vdd_core/smartreflex/autocomp
~ # echo 1 > /dbg/voltage/vdd_mpu/smartreflex/autocomp

I than change the frequency but I always see the same voltage as following:

~ # echo 550000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed

~ # cat /dbg/voltage/vdd_core/smartreflex/autocomp
1
~ # cat /sys/class/regulator/regulator.1/microvolts
1800000
~ # cat /sys/class/regulator/regulator.2/microvolts
1850000
~ # cat /sys/class/regulator/regulator.3/microvolts
1800000
~ # cat /sys/class/regulator/regulator.4/microvolts
2800000
~ # cat /sys/class/regulator/regulator.5/microvolts
1800000
~ # cat /sys/class/regulator/regulator.6/microvolts
1800000
~ # cat /sys/class/regulator/regulator.7/microvolts
2800000
~ # cat /sys/class/regulator/regulator.1/microvolts
1800000
~ # cat /sys/class/regulator/regulator.2/microvolts
1850000
~ # cat /sys/class/regulator/regulator.3/microvolts
1800000
~ # cat /sys/class/regulator/regulator.4/microvolts
2800000
~ # cat /sys/class/regulator/regulator.5/microvolts
1800000
~ # cat /sys/class/regulator/regulator.6/microvolts
1800000
~ # cat /sys/class/regulator/regulator.7/microvolts
2800000
~ #

~ # echo 500000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed

~ # cat /dbg/voltage/vdd_core/smartreflex/autocomp
1
~ # cat /sys/class/regulator/regulator.1/microvolts
1800000
~ # cat /sys/class/regulator/regulator.2/microvolts
1850000
~ # cat /sys/class/regulator/regulator.3/microvolts
1800000
~ # cat /sys/class/regulator/regulator.4/microvolts
2800000
~ # cat /sys/class/regulator/regulator.5/microvolts
1800000
~ # cat /sys/class/regulator/regulator.6/microvolts
1800000
~ # cat /sys/class/regulator/regulator.7/microvolts
2800000
~ # cat /sys/class/regulator/regulator.1/microvolts
1800000
~ # cat /sys/class/regulator/regulator.2/microvolts
1850000
~ # cat /sys/class/regulator/regulator.3/microvolts
1800000
~ # cat /sys/class/regulator/regulator.4/microvolts
2800000
~ # cat /sys/class/regulator/regulator.5/microvolts
1800000
~ # cat /sys/class/regulator/regulator.6/microvolts
1800000
~ # cat /sys/class/regulator/regulator.7/microvolts
2800000
~ #

Thanks for any suggestions,

Ran
