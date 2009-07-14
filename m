From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: [PATCH 0/4] TWL patch series
Date: Tue, 14 Jul 2009 19:16:40 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043295A40B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49293 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562AbZGNNqv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 09:46:51 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
for OMAP3. The common modules like RTC, Regulator creates opportunity
to re-use the most of the code from twl4030.

Summary of Major difference between Triton and Phoenix chips are:
            -GPIO, Keypad is not present in Phoenix
            -I2C Chips addresses of modules like RTC, BCI, ADC, USB, PMC Master/Slave 
             have changed.  Base address of these module register is also changed.
            -PIH and SIH, module interrupt status registers will be replaced by PIH 
             (INT_STS_A, INT_STS_B and INT_STS_C) and module interrupt status registers
            -MADC to GPADC in Phoenix, 17 channels supported
             GPADC in Phoenix supports Realtime, Asynchronous SW request.
            -RTC register offsets have changed. Addition/removal of LDO/SMPS Voltage 
             Regulators

These patches are generated against mainline 2.6.31-rc1 and validated on OMAP 
3430 SDP for RTC driver and regulator drivers.

            [PATCH 1/4] ARM: OMAP: Rename twl4030* driver files to enable re-use
            [PATCH 2/4] ARM: OMAP: Rename all twl4030_i2c*.
            [PATCH 3/4] ARM: OMAP: Rename twl4030_ in rtc-twl.c to make it generic twl rtc
            [PATCH 4/4] Rename twl4030_ to twl_ in twl-regulator.c to make it generic twl reg

Below files needs updates/investigation for the possible re-use:
drivers/gpio/twl4030-gpio.c
drivers/usb/otg/twl4030-usb.c
drivers/input/misc/twl4030-pwrbutton.c
arch/arm/mach-omap2/board-rx51-peripherals.c
arch/arm/mach-omap2/board-omap3evm.c

Please provide your feedback on this patch series.

Thanks !!
Balaji T K