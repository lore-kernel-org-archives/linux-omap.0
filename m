From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH take 2] PM: OMAP: Fix build with CONFIG_OMAP_PM_NONE set
Date: Wed, 08 Apr 2009 17:16:50 +0300
Message-ID: <49DCB1D2.9070405@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32206 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933893AbZDHOR1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Apr 2009 10:17:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Roger Quadros <ext-roger.quadros@nokia.com>
Date: Wed, 8 Apr 2009 17:12:43 +0300
Subject: [PATCH] PM: OMAP: Fix build with CONFIG_OMAP_PM_NONE set

Removes undefined symbol link errors when CONFIG_OMAP_PM is set.
The required symbols are defined in common.c and omap-pm.h
Dummy variables mpu_oops, dsp_oops and l3_oops have to be defined
because they are used in a number of places

It fixes the following link errors

arch/arm/mach-omap2/built-in.o: In function `omap3_round_to_table_rate':
arch/arm/mach-omap2/clock34xx.c:956: undefined reference to `mpu_opps'
arch/arm/mach-omap2/clock34xx.c:956: undefined reference to `dsp_opps'
arch/arm/mach-omap2/clock34xx.c:956: undefined reference to `l3_opps'
arch/arm/mach-omap2/built-in.o: In function `omap2_init_common_hw':
arch/arm/mach-omap2/io.c:241: undefined reference to
`omap_pm_if_early_init'
arch/arm/mach-omap2/io.c:246: undefined reference to `omap_pm_if_init'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
  arch/arm/plat-omap/common.c               |    6 ++++++
  arch/arm/plat-omap/include/mach/omap-pm.h |    8 ++++++++
  2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 2866612..634ca39 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -46,6 +46,12 @@ int omap_bootloader_tag_len;
  struct omap_board_config_kernel *omap_board_config;
  int omap_board_config_size;

+#ifdef CONFIG_OMAP_PM_NONE
+struct omap_opp *mpu_opps;
+struct omap_opp *dsp_opps;
+struct omap_opp *l3_opps;
+#endif
+
  #ifdef CONFIG_OMAP_BOOT_TAG

  static int __init parse_tag_omap(const struct tag *tag)
diff --git a/arch/arm/plat-omap/include/mach/omap-pm.h 
b/arch/arm/plat-omap/include/mach/omap-pm.h
index f0bbd36..5526e89 100644
--- a/arch/arm/plat-omap/include/mach/omap-pm.h
+++ b/arch/arm/plat-omap/include/mach/omap-pm.h
@@ -58,9 +58,13 @@ extern struct omap_opp *l3_opps;
   * framework starts.  The "_if_" is to avoid name collisions with the
   * PM idle-loop code.
   */
+#ifdef CONFIG_OMAP_PM_NONE
+#define omap_pm_if_early_init(a, b, c) 0
+#else
  int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
  				 struct omap_opp *dsp_opp_table,
  				 struct omap_opp *l3_opp_table);
+#endif

  /**
   * omap_pm_if_init - OMAP PM init code called after clock fw init
@@ -68,7 +72,11 @@ int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
   * The main initialization code.  OPP tables are passed in here.  The
   * "_if_" is to avoid name collisions with the PM idle-loop code.
   */
+#ifdef CONFIG_OMAP_PM_NONE
+#define omap_pm_if_init() 0
+#else
  int __init omap_pm_if_init(void);
+#endif

  /**
   * omap_pm_if_exit - OMAP PM exit code
-- 
1.5.6.3
