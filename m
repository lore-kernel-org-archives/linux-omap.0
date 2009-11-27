From: Thara Gopinath <thara@ti.com>
Subject: [PATCH] OMAP3: hwmod: support to specify the bit position of clockactivity bits
Date: Fri, 27 Nov 2009 20:56:11 +0530
Message-ID: <1259335571-13183-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51380 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbZK0P0K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Nov 2009 10:26:10 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nARFQD01025642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 09:26:16 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

Some modules like OMAP3 Smartreflex do not have the regular sysconfig
register.Instead clockactivity bits are part of another register at a
different bit position than the usual bit positions 8 and 9. This patch
introduces a flag SYSC_CHANGE_CLKACT_OFFSET which if specified the hwmod driver
takes the bit position of clockactivity bits from clockact_offs specified as
part of omap_hwmod_sysconfig. Else the default positions are used.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   14 ++++++++++++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   26 +++++++++++++++++---------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 633b216..bef725b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -180,12 +180,22 @@ static int _set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode, u32 *v)
  */
 static int _set_clockactivity(struct omap_hwmod *oh, u8 clockact, u32 *v)
 {
+	u32 clkact_mask;
+	u8  clkact_shift;
+
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_CLOCKACTIVITY))
 		return -EINVAL;
 
-	*v &= ~SYSC_CLOCKACTIVITY_MASK;
-	*v |= clockact << SYSC_CLOCKACTIVITY_SHIFT;
+	if (oh->sysconfig->sysc_flags & SYSC_CHANGE_CLKACT_OFFSET) {
+		clkact_shift = oh->sysconfig->clockact_offs;
+		clkact_mask = (0x3 << clkact_shift);
+	} else {
+		clkact_shift = SYSC_CLOCKACTIVITY_SHIFT;
+		clkact_mask = SYSC_CLOCKACTIVITY_MASK;
+	}
+	*v &= ~clkact_mask;
+	*v |= clockact << clkact_shift;
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index dbdd123..d85d184 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -203,14 +203,15 @@ struct omap_hwmod_ocp_if {
 #define MSTANDBY_SMART		(HWMOD_IDLEMODE_SMART << MASTER_STANDBY_SHIFT)
 
 /* omap_hwmod_sysconfig.sysc_flags capability flags */
-#define SYSC_HAS_AUTOIDLE	(1 << 0)
-#define SYSC_HAS_SOFTRESET	(1 << 1)
-#define SYSC_HAS_ENAWAKEUP	(1 << 2)
-#define SYSC_HAS_EMUFREE	(1 << 3)
-#define SYSC_HAS_CLOCKACTIVITY	(1 << 4)
-#define SYSC_HAS_SIDLEMODE	(1 << 5)
-#define SYSC_HAS_MIDLEMODE	(1 << 6)
-#define SYSS_MISSING		(1 << 7)
+#define SYSC_HAS_AUTOIDLE		(1 << 0)
+#define SYSC_HAS_SOFTRESET		(1 << 1)
+#define SYSC_HAS_ENAWAKEUP		(1 << 2)
+#define SYSC_HAS_EMUFREE		(1 << 3)
+#define SYSC_HAS_CLOCKACTIVITY		(1 << 4)
+#define SYSC_HAS_SIDLEMODE		(1 << 5)
+#define SYSC_HAS_MIDLEMODE		(1 << 6)
+#define SYSS_MISSING			(1 << 7)
+#define SYSC_CHANGE_CLKACT_OFFSET	(1 << 8)
 
 /* omap_hwmod_sysconfig.clockact flags */
 #define CLOCKACT_TEST_BOTH	0x0
@@ -235,14 +236,21 @@ struct omap_hwmod_ocp_if {
  * been associated with the clocks marked in @clockact.  This field is
  * only used if HWMOD_SET_DEFAULT_CLOCKACT is set (see below)
  *
+ * @clockact_offs: the position of clock activity bits in this register.
+ * @clockact_offs defines the position of clockactivity bits in the sysconfig
+ * register. Some modules like Smartreflex in 3430 has a different position for
+ * clockactivity bit than the default. This field will be used only if
+ * SYSC_CHANGE_CLKACT_OFFSET is set. Else the default position is assumed for
+ * these bits
  */
 struct omap_hwmod_sysconfig {
 	u16 rev_offs;
 	u16 sysc_offs;
 	u16 syss_offs;
 	u8 idlemodes;
-	u8 sysc_flags;
+	u16 sysc_flags;
 	u8 clockact;
+	u8 clockact_offs;
 };
 
 /**
-- 
1.5.4.7

