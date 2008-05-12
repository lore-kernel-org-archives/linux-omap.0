From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: OMAP3530 EVM Sources are on linux.omap.com
Date: Mon, 12 May 2008 16:29:21 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C001578E8398@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40657 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbYELK7n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2008 06:59:43 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m4CAxO9c022801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 May 2008 05:59:34 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m4CAxNq7024618
	for <linux-omap@vger.kernel.org>; Mon, 12 May 2008 05:59:23 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello all:

We have uploaded OMAP3530 EVM sources on linux.omap.com

x-loader               : http://linux.omap.com/pub/xloader/3530evm/
u-boot-1.1.4           : http://linux.omap.com/pub/bootloader/3530evm/
Linux Kernel 2.6.22-18 : http://linux.omap.com/pub/kernel/3530evm/
Tool Chain used        : Code Sourcery arm-2007q3

Few important features supported in kernel are listed below:

*       ALSA Audio Driver.
*       Power Management
*       Supports for NFS file system.
*       Ethernet.
*       Frame buffer (FBDEV).
*       Debug UART port.
*       DMA framework.
*       TWL4030 (T2) RTC.
*       Watchdog driver.
*       Support T2 Core GPIO.
*       GPIO.
*       V4L2 Based Video driver.
*       Keypad.
*       HS-I2C.
*       McBSP.
*       McSPI.
*       TouchScreen.
*       UART library.
*       High-speed MMC
*       NAND
*       USB OTG
*       TV out.
*       Clock framework with device driver adaptation

Platform description can be found here,
http://focus.ti.com/general/docs/wtbu/wtbusplashcontent.tsp?templateId=6123&contentId=4750#omap3530

Regards,
Khasim
