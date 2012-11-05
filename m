From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/6] ARM: OMAP3+: move smartreflex-class3.c to drivers/power/avs
Date: Mon, 5 Nov 2012 09:02:08 -0600
Message-ID: <1352127734-30103-2-git-send-email-nm@ti.com>
References: <1352127734-30103-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1352127734-30103-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Rafael <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbouatmailru@gmail.com>, linux-pm <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

smartreflex.c now resides in drivers/power/avs directory,
but class driver is in mach-omap2. High time we move it
to drivers/power/avs.

This series *does not* try to fix VP/VC to be voltage
regulator OR introduce a new OMAP voltage regulator series.
Instead, it purely tries to do the minimal changes needed
to move code to drivers/power/avs as a start.

Baseline: k.org v3.7-rc4
Testing: Platform: beagle XM C1 (3730)
while [ 1 ]
do
echo -n "0" >/sys/kernel/debug/smartreflex/smartreflex_core/autocomp
date
echo -n "1" >/sys/kernel/debug/smartreflex/smartreflex_core/autocomp
done
Screen capture after the series(RFC): on inductor L5 (VDD2 - core):
https://plus.google.com/photos/112464029509057661457/albums/5715034179943520193/5802619719180530114

RFC: http://marc.info/?t=135102876700003&r=1&w=2

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

