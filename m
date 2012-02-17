From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] ARM: OMAP2+: hwmod: Add new sysc_type3 into omap_hwmod required for am33xx
Date: Fri, 17 Feb 2012 17:54:48 +0530
Message-ID: <1329481488-27771-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39390 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab2BQM16 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 07:27:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, paul@pwsan.com, b-cousson@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>

In case of AM33xx family of devices (like cpsw) have different sysc
bit field offsets defined,

sysc_type3:
|  3     2  |  1    0  |
| STDBYMODE | IDLEMODE |

So introduce new sysc_type3 in omap_hwmod common data.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_common_data.c |    9 +++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   10 ++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
index 51e5418..6dd922e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -49,6 +49,15 @@ struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2 = {
 	.srst_shift	= SYSC_TYPE2_SOFTRESET_SHIFT,
 };
 
+/**
+ * struct omap_hwmod_sysc_type3 - TYPE3 sysconfig scheme.
+ * Used by some IPs on AM33xx
+ */
+struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3 = {
+	.midle_shift	= SYSC_TYPE3_MIDLEMODE_SHIFT,
+	.sidle_shift	= SYSC_TYPE3_SIDLEMODE_SHIFT,
+};
+
 struct omap_dss_dispc_dev_attr omap2_3_dss_dispc_dev_attr = {
 	.manager_count		= 2,
 	.has_framedonetv_irq	= 0
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 9db27aa..3128364 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -41,6 +41,7 @@ struct omap_device;
 
 extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type1;
 extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
+extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
 
 /*
  * OCP SYSCONFIG bit shifts/masks TYPE1. These are for IPs compliant
@@ -70,6 +71,15 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
 #define SYSC_TYPE2_MIDLEMODE_SHIFT	4
 #define SYSC_TYPE2_MIDLEMODE_MASK	(0x3 << SYSC_TYPE2_MIDLEMODE_SHIFT)
 
+/*
+ * OCP SYSCONFIG bit shifts/masks TYPE3.
+ * This is applicable for some IPs present in AM33XX
+ */
+#define SYSC_TYPE3_SIDLEMODE_SHIFT	0
+#define SYSC_TYPE3_SIDLEMODE_MASK	(0x3 << SYSC_TYPE3_SIDLEMODE_SHIFT)
+#define SYSC_TYPE3_MIDLEMODE_SHIFT	2
+#define SYSC_TYPE3_MIDLEMODE_MASK	(0x3 << SYSC_TYPE3_MIDLEMODE_SHIFT)
+
 /* OCP SYSSTATUS bit shifts/masks */
 #define SYSS_RESETDONE_SHIFT		0
 #define SYSS_RESETDONE_MASK		(1 << SYSS_RESETDONE_SHIFT)
-- 
1.7.0.4

