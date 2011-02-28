From: Michael Buesch <mb@bu3sch.de>
Subject: Nokia n810 LCD (MIPID/blizzard) on 2.6.38
Date: Mon, 28 Feb 2011 21:45:43 +0100
Message-ID: <1298925943.16391.19.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:35668 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014Ab1B1Upq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 15:45:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Varadarajan Charulatha <charu@ti.com>

The n810 LCD does not work on the 2.6.38(-rc6) kernel
due to changes in the OMAP GPIO-hwmod code.

The hwmod code performs a soft-reset on the GPIO
module. The first GPIO module carries the MIPID
"nreset" line, which is toggled due to the hwmod soft reset.
This resets Blizzard and breaks it, because
it assumes the LCD was left in the state that the
bootloader initialized it to:

	if (!(blizzard_read_reg(BLIZZARD_PLL_DIV) & 0x80)) {
		dev_err(fbdev->dev,
			  "controller not initialized by the bootloader\n");
		r = -ENODEV;
		goto err3;
	}

My temporary workaround to this issue is to disable
soft reset for the first GPIO module:

	static struct omap_hwmod omap2420_gpio1_hwmod = {
		.name           = "gpio1",
		.flags          = HWMOD_INIT_NO_RESET, /* Workaround: Don't reset the n810 MIPID */

I'm wondering if a better fix suitable for the mainline
kernel inclusion could be found.
Any ideas?

-- 
Greetings, Michael.




