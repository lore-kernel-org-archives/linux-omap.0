From: Paul Walmsley <paul@pwsan.com>
Subject: RE: State of SDP4430 platform
Date: Mon, 17 Jan 2011 16:19:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101171611270.13225@utopia.booyaka.com>
References: <20110116010936.GA21795@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1101152255100.13225@utopia.booyaka.com> <a40bc7a304b60cef73a3a0cfb84b2ee8@mail.gmail.com> <ceedbf20a12a6e821fda1496b10297a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39350 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab1AQXTR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 18:19:17 -0500
In-Reply-To: <ceedbf20a12a6e821fda1496b10297a2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

On Mon, 17 Jan 2011, Santosh Shilimkar wrote:

> The I2C timeout issue I could reproduce on my ES1.0 board. It's ES1.0
> specific issue because I2C burst mode wasn't fuctional on it. Twl RTC
> driver uses I2C burst mode and hence it times out. Other TWL I2C
> module has no such issue.
> The pull work-around we tried was not reliable hence it was dropped.
> 
> In short the TWL RTC driver won't function on ES1.0. Apart from that
> rest of the I2C clients should work as usual.

Looks like the IRQ handling code uses it too:

$ egrep -r 'twl_i2c_(write|read)\(' drivers/ | egrep -v twl-core | egrep -v 4030
drivers/mfd/twl6030-irq.c:		ret = twl_i2c_read(TWL_MODULE_PIH, sts.bytes,
drivers/mfd/twl6030-irq.c:		ret = twl_i2c_write(TWL_MODULE_PIH, sts.bytes,
drivers/mfd/twl6030-irq.c:	ret = twl_i2c_write(TWL_MODULE_PIH, &mask[0],
drivers/mfd/twl6030-irq.c:	ret = twl_i2c_write(TWL_MODULE_PIH, &mask[0],
drivers/mfd/twl6030-irq.c:	ret = twl_i2c_write(TWL_MODULE_PIH, &mask[0],
drivers/rtc/rtc-twl.c:	ret = twl_i2c_read(TWL_MODULE_RTC, rtc_data,
drivers/rtc/rtc-twl.c:	ret = twl_i2c_write(TWL_MODULE_RTC, rtc_data,
drivers/rtc/rtc-twl.c:	ret = twl_i2c_read(TWL_MODULE_RTC, rtc_data,
drivers/rtc/rtc-twl.c:	ret = twl_i2c_write(TWL_MODULE_RTC, alarm_data,
$

I'd assume this also would affect other, non-TWL, I2C endpoints, no?

Sounds like a platform_data flag should be passed into the I2C driver code 
to indicate that burst transactions are buggy on OMAP4430ES1.


- Paul
