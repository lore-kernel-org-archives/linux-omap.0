From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/6] omap4 i2c board support and fixes
Date: Wed,  7 Apr 2010 13:17:20 +0530
Message-ID: <1270626446-10841-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58942 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033Ab0DGHrc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Apr 2010 03:47:32 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o377lS35028864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 02:47:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

This series mainly adds I2C board data for OMAP4430 SDP and few
needed fixes. I have made this into one series just for simplcity
otherwise couple patches are independent. The intent is to get it merged
in linux-omap master for testing. The needed I2C driver support is 
already merged in l-o master

It's generated against latest linux-omap master and tested with
omap4430 and omap3430 sdps with regular and multi-omap defconfig

Balaji T K (2):
  omap4: add i2c1 peripherals data
  omap4: Enable RTC and regulator support

Richard Woodruff (1):
  omap4: Fix build break when used with gcc-4.4.1 (2009-q3)

Santosh Shilimkar (3):
  omap4: Fix WDT Kconfig
  omap4: Fix McBSP4 base address
  omap4: Add i2c board support on omap4430 sdp platform

 arch/arm/configs/omap_4430sdp_defconfig |   39 ++++++-
 arch/arm/mach-omap2/board-4430sdp.c     |  187 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap-headsmp.S      |    6 +-
 arch/arm/mach-omap2/omap44xx-smc.S      |    2 +-
 arch/arm/plat-omap/i2c.c                |   21 +++-
 arch/arm/plat-omap/include/plat/mcbsp.h |    2 +-
 drivers/watchdog/Kconfig                |    6 +-
 7 files changed, 249 insertions(+), 14 deletions(-)

