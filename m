From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: commit fc7b92fca4e546184557f1c53f84ad57c66b7695 broke compilation
Date: Tue, 15 Dec 2009 13:58:06 +0200
Message-ID: <20091215115806.GG3689@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36970 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760012AbZLOL6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 06:58:48 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Balaji T K <balajitk@ti.com>

Hi,

the patch renaming twl4030 to twl broke compilation of several omap 
boards.

Here are all the files including a file that doesn't exist anymore:

arch/arm/mach-omap2/board-cm-t35.c:#include <linux/i2c/twl4030.h>
arch/arm/mach-omap2/board-igep0020.c:#include <linux/i2c/twl4030.h>
arch/arm/mach-omap2/board-omap3evm.c:#include <linux/i2c/twl4030.h>
arch/arm/mach-omap2/board-omap3touchbook.c:#include <linux/i2c/twl4030.h>
arch/arm/mach-omap2/board-rx51-peripherals.c:#include <linux/i2c/twl4030.h>
arch/arm/mach-omap2/board-zoom-peripherals.c:#include <linux/i2c/twl4030.h>
drivers/mfd/twl4030-codec.c:#include <linux/i2c/twl4030.h>
drivers/video/omap/lcd_ldp.c:#include <linux/i2c/twl4030.h>
drivers/video/omap/lcd_omap2evm.c:#include <linux/i2c/twl4030.h>
drivers/video/omap/lcd_omap3beagle.c:#include <linux/i2c/twl4030.h>
drivers/video/omap/lcd_omap3evm.c:#include <linux/i2c/twl4030.h>
drivers/video/omap/lcd_overo.c:#include <linux/i2c/twl4030.h>
sound/soc/omap/sdp3430.c:#include <linux/i2c/twl4030.h>

-- 
balbi
