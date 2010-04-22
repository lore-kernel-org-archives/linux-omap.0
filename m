From: "Arce, Abraham" <x0066660@ti.com>
Subject: [PATCH 0/4] OMAP4 Ethernet Controller Support
Date: Thu, 22 Apr 2010 09:42:03 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DC15EB1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49985 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964Ab0DVOmU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 10:42:20 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>


Enable network chip Micrel KS8851 for OMAP4430 SDP

- Based on mainline version 2.6.34 rc5
- Tested in OMAP4430 SDP
- One dependency
  http://patchwork.ozlabs.org/patch/50363/

Throughput measurements using nuttcp application:
  11.9375 MB /  10.07 sec =    9.9441 Mbps 95 %TX 0 %RX 0 retrans 7.90 msRTT

Patches

 0001-OMAP4-Clocks-Change-SPI-Instance-Names.patch
 0002-OMAP4-SPI-Fix-Driver-Kconfig.patch
 0003-OMAP4-Ethernet-KS8851-Board-Support.patch
 0004-OMAP4-Networking-Defconfig-Support.patch

---

 arch/arm/configs/omap_4430sdp_defconfig |   57 ++++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/board-4430sdp.c     |   30 ++++++++++++++++
 arch/arm/mach-omap2/clock44xx_data.c    |    8 ++--
 drivers/spi/Kconfig                     |    6 +--
 4 files changed, 92 insertions(+), 9 deletions(-)

