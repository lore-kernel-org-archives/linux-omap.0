From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/3] OMAP: Add DT bindings to specify when devices should not be idled or reset
Date: Tue, 20 Aug 2013 13:02:43 +0530
Message-ID: <1376983966-16490-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38948 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab3HTHeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Aug 2013 03:34:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

We have devices like co-processors, SoC internal busses, memory controllers
etc which should not be idled or reset. In some cases erratas around IP blocks
prevent them from either being idled or reset. Have a way to pass this
information from Device tree, and get rid of similar information that
exists as part of the omap_hwmod data files for various DT only OMAP SoCs.

Patches are tested on am335x beagleboneblack and omap4 panda es boards.

Rajendra Nayak (3):
  ARM: OMAP2+: hwmod: cleanup HWMOD_INIT_NO_RESET usage
  ARM: OMAP2+: Add new bindings for OMAP
  ARM: OMAP2+: Let DT say what devices should not to idled or reset

 .../devicetree/bindings/arm/omap/omap.txt          |    3 ++-
 arch/arm/boot/dts/am33xx.dtsi                      |    2 ++
 arch/arm/boot/dts/omap4.dtsi                       |    3 +++
 arch/arm/boot/dts/omap5.dtsi                       |    2 ++
 arch/arm/mach-omap2/omap_hwmod.c                   |   22 +++++++++++++-------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   22 ++++++++++----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 ++----
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |    4 +---
 8 files changed, 38 insertions(+), 26 deletions(-)

-- 
1.7.9.5

