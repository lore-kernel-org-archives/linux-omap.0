From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] PM: OMAP: Fix build with CONFIG_OMAP_PM_NONE set
Date: Tue, 07 Apr 2009 11:57:04 +0300
Message-ID: <49DB1560.4050609@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56538 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbZDGI6H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 04:58:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

From: Roger Quadros <ext-roger.quadros@nokia.com>
Date: Tue, 7 Apr 2009 11:10:29 +0300
Subject: [PATCH] PM: OMAP: Fix build with CONFIG_OMAP_PM_NONE set

Removes undefined symbol link errors. Required symbols are defined in
common.c and omap-pm.h

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
  arch/arm/plat-omap/common.c               |    6 ++++++
  arch/arm/plat-omap/include/mach/omap-pm.h |   15 +++++++++++++++
  2 files changed, 21 insertions(+), 0 deletions(-)

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
index f0bbd36..6a8499a 100644
--- a/arch/arm/plat-omap/include/mach/omap-pm.h
+++ b/arch/arm/plat-omap/include/mach/omap-pm.h
@@ -58,9 +58,20 @@ extern struct omap_opp *l3_opps;
   * framework starts.  The "_if_" is to avoid name collisions with the
   * PM idle-loop code.
   */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
+				 struct omap_opp *dsp_opp_table,
+				 struct omap_opp *l3_opp_table) {
+	mpu_opps = 0;
+	dsp_opps = 0;
+	l3_opps = 0;
+	return 0;
+}
+#else
  int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
  				 struct omap_opp *dsp_opp_table,
  				 struct omap_opp *l3_opp_table);
+#endif

  /**
   * omap_pm_if_init - OMAP PM init code called after clock fw init
@@ -68,7 +79,11 @@ int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
   * The main initialization code.  OPP tables are passed in here.  The
   * "_if_" is to avoid name collisions with the PM idle-loop code.
   */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline int __init omap_pm_if_init(void) { return 0; }
+#else
  int __init omap_pm_if_init(void);
+#endif

  /**
   * omap_pm_if_exit - OMAP PM exit code
-- 
1.5.6.3
