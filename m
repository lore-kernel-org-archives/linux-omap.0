From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH v4 0/3]Add Zoom2 board support
Date: Thu, 21 May 2009 05:27:53 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5129A0D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59275 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbZETX6A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:58:00 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4KNvuG6026644
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 18:58:02 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4KNvtrY008728
	for <linux-omap@vger.kernel.org>; Thu, 21 May 2009 05:27:55 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


From: Vikram Pandita <vikram.pandita@ti.com>

The following patch series adds support for Texas Instruments OMAP3 Zoom2 board.
The board has Modem attached to UART1, WLAN to UART2 and GPS to UART3.

An external debug board is included for console and LAN.

Please see:
http://www.logicpd.com/products/development-kits/texas-instruments-zoom%E2%84%A2-omap34x-ii-mdp

There is still thing that needs to be worked on and includes:
 - SMSC911x NFS mount problem
 - Low level debug uart need to use debug board
 - Dynamic detection of debug board presence


Vikram Pandita (3):
  OMAP3:zoom2: Add support for OMAP3 Zoom2 board
  OMAP3:zoom2: Defconfig for Zoom2 board
  OMAP3:zoom2: Makefile and Kconfig for Zoom2 board

 arch/arm/configs/omap_zoom2_defconfig       | 1211 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig                 |    4 +
 arch/arm/mach-omap2/Makefile                |    4 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c |  160 ++++
 arch/arm/mach-omap2/board-zoom2.c           |  110 +++
 5 files changed, 1488 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/configs/omap_zoom2_defconfig
 create mode 100644 arch/arm/mach-omap2/board-zoom-debugboard.c
 create mode 100644 arch/arm/mach-omap2/board-zoom2.c

