From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
Date: Fri, 15 Feb 2013 17:36:08 +0530
Message-ID: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38569 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab3BOMFM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 07:05:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: balbi@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP UART IP needs manual idle modes based on state of the
IP. Currently this is handled by the driver with function pointers
implemented in platform code.

This however breaks in case of device tree because of missing
idle handling. 

The series tries to address the issue

Patches has been tested on OMAP4 and OMAP5 devices where the console
slugishness was observed without idle mode handling. CPUIDLE and
suspend tested ok on these devices.

Need help in testing on OMAP2, OMAP3 and AM3XXX devices. 

Santosh Shilimkar (2):
  ARM: OMAP2+: hwmod-data: UART IP needs software control of sidle
    modes
  SERIAL: OMAP: Remove the idle handling from the driver

 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 ++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    6 ++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    4 +++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 +++-
 arch/arm/mach-omap2/serial.c                       |   31 --------------------
 drivers/tty/serial/omap-serial.c                   |   23 ---------------
 6 files changed, 18 insertions(+), 55 deletions(-)

-- 
1.7.9.5

