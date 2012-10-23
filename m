From: Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 0/6] ARM: OMAP3+: move smartreflex-class3.c to drivers/power/avs
Date: Tue, 23 Oct 2012 16:43:55 -0500
Message-ID: <1351028641-20832-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37325 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058Ab2JWVoH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Oct 2012 17:44:07 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9NLi6Bk012579
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 16:44:06 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9NLi6cU028643
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 16:44:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@ti.com>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>

smartreflex.c now resides in drivers/power/avs directory, but class driver
is in mach-omap2. High time we move it off to drivers/power/avs.

This series *does not* try to fix VP/VC to be voltage regulator OR introduce
a new OMAP voltage regulator series. instead, it purely tries to do the minimal
changes needed to move code to drivers/power/avs as a start.

Baseline: k.org v3.7-rc2 
Testing: Platform: beagle XM C1 (3730)
while [ 1 ]
do
echo -n "0" >/sys/kernel/debug/smartreflex/smartreflex_core/autocomp
date
echo -n "1" >/sys/kernel/debug/smartreflex/smartreflex_core/autocomp
done
Screen capture after the series: on inductor L5 (VDD2 - core):
https://plus.google.com/photos/112464029509057661457/albums/5715034179943520193/5802619719180530114

RFC for a view if this is ok as an intermediate step.

Nishanth Menon (6):
  PM / AVS / OMAP: move Kconfig definition of smartreflex to avs
    directory
  ARM: OMAP: voltage: remove duplicate header definitions
  ARM: OMAP: voltage: move voltdm_reset to platform_data header
  ARM: OMAP: SmartReflex: provide SoC integration API for VP
  ARM: OMAP: SmartReflex: use pr_warn instead of pr_warning
  PM / AVS / OMAP: move Smartreflex-class3 driver to power/avs

 arch/arm/mach-omap2/Makefile                       |    1 -
 arch/arm/mach-omap2/sr_device.c                    |    5 ++++
 arch/arm/mach-omap2/voltage.h                      |    4 ---
 arch/arm/plat-omap/Kconfig                         |   31 --------------------
 drivers/power/avs/Kconfig                          |   31 ++++++++++++++++++++
 drivers/power/avs/Makefile                         |    1 +
 .../power/avs}/smartreflex-class3.c                |   20 +++++++++----
 drivers/power/avs/smartreflex.c                    |    2 ++
 include/linux/platform_data/voltage-omap.h         |    1 +
 include/linux/power/smartreflex.h                  |   18 ++++++++++++
 10 files changed, 73 insertions(+), 41 deletions(-)
 rename {arch/arm/mach-omap2 => drivers/power/avs}/smartreflex-class3.c (75%)

Regards,
Nishanth Menon
-- 
1.7.9.5
