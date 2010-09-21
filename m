From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] OMAP: hwmod: Fix softreset status check for some new OMAP4 IPs
Date: Tue, 21 Sep 2010 18:57:59 +0200
Message-ID: <1285088279-425-3-git-send-email-b-cousson@ti.com>
References: <1285088279-425-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59610 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754985Ab0IUQ6K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 12:58:10 -0400
In-Reply-To: <1285088279-425-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, p-basak2@ti.com, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

In OMAP3 a specific SYSSTATUS register was used to get the softreset status.
Starting in OMAP4, some IPs does not have SYSSTATUS register and instead
use the SYSC softreset bit to provide the status.

Other cases might exist:
- Some IPs like McBSP does have a softreset control but no reset status.
- Some IPs that represent subsystem, like the DSS, can contains
a reset status without softreset control. The status is the aggregation
of all the sub modules reset status.

- Add a new flag (SYSC_HAS_RESET_STATUS) to identify the new programming model
and replace the previous SYSS_MISSING, that was used to flag IP with
softreset control but without the SYSSTATUS register, with a specific
SYSS_HAS_RESET_STATUS flag.

- MCSPI and MMC contains both programming models, so the legacy one
will be prevented by removing the syss offset field that become useless.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   22 +++++++++++++++++-----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 ++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4309107..4819a49 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -997,6 +997,12 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
  * enabled for this to work.  Returns -EINVAL if the hwmod cannot be
  * reset this way or if the hwmod is in the wrong state, -ETIMEDOUT if
  * the module did not reset in time, or 0 upon success.
+ *
+ * In OMAP3 a specific SYSSTATUS register is used to get the reset status.
+ * Starting in OMAP4, some IPs does not have SYSSTATUS register and instead
+ * use the SYSCONFIG softreset bit to provide the status.
+ *
+ * Note that some IP like McBSP does have a reset control but no reset status.
  */
 static int _reset(struct omap_hwmod *oh)
 {
@@ -1005,8 +1011,7 @@ static int _reset(struct omap_hwmod *oh)
 	int ret = 0;
 
 	if (!oh->class->sysc ||
-	    !(oh->class->sysc->sysc_flags & SYSC_HAS_SOFTRESET) ||
-	    (oh->class->sysc->sysc_flags & SYSS_MISSING))
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_SOFTRESET))
 		return -EINVAL;
 
 	/* clocks must be on for this operation */
@@ -1028,9 +1033,16 @@ static int _reset(struct omap_hwmod *oh)
 		goto dis_opt_clks;
 	_write_sysconfig(v, oh);
 
-	omap_test_timeout((omap_hwmod_readl(oh, oh->class->sysc->syss_offs) &
-			   SYSS_RESETDONE_MASK),
-			  MAX_MODULE_SOFTRESET_WAIT, c);
+	if (oh->class->sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
+		omap_test_timeout((omap_hwmod_readl(oh,
+						    oh->class->sysc->syss_offs)
+				   & SYSS_RESETDONE_MASK),
+				  MAX_MODULE_SOFTRESET_WAIT, c);
+	else if (oh->class->sysc->sysc_flags & SYSC_HAS_RESET_STATUS)
+		omap_test_timeout(!(omap_hwmod_readl(oh,
+						     oh->class->sysc->sysc_offs)
+				   & SYSC_TYPE2_SOFTRESET_MASK),
+				  MAX_MODULE_SOFTRESET_WAIT, c);
 
 	if (c == MAX_MODULE_SOFTRESET_WAIT)
 		pr_warning("omap_hwmod: %s: softreset failed (waited %d usec)\n",
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 878f919..ee53758 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -251,8 +251,9 @@ struct omap_hwmod_ocp_if {
 #define SYSC_HAS_CLOCKACTIVITY	(1 << 4)
 #define SYSC_HAS_SIDLEMODE	(1 << 5)
 #define SYSC_HAS_MIDLEMODE	(1 << 6)
-#define SYSS_MISSING		(1 << 7)
+#define SYSS_HAS_RESET_STATUS	(1 << 7)
 #define SYSC_NO_CACHE		(1 << 8)  /* XXX SW flag, belongs elsewhere */
+#define SYSC_HAS_RESET_STATUS	(1 << 9)
 
 /* omap_hwmod_sysconfig.clockact flags */
 #define CLOCKACT_TEST_BOTH	0x0
-- 
1.6.0.4

