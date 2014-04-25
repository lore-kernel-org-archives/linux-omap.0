From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 01/10] ARM: OMAP: hwmod: Add SYSC offsets for AES IP
Date: Fri, 25 Apr 2014 18:02:39 -0500
Message-ID: <1398466968-29506-2-git-send-email-joelf@ti.com>
References: <1398466968-29506-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398466968-29506-1-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

The AES IP has the SIDLE offset by 2 and not 3, to allow SIDLE modes
to work for AES, we add a new SYSC type to HWMOD code.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.h             |   11 +++++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.c |   10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 0f97d63..b2efcc8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -41,6 +41,7 @@ struct omap_device;
 extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type1;
 extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
 extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
+extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type4;
 
 /*
  * OCP SYSCONFIG bit shifts/masks TYPE1. These are for IPs compliant
@@ -81,6 +82,16 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
 #define SYSC_TYPE3_MIDLEMODE_SHIFT	2
 #define SYSC_TYPE3_MIDLEMODE_MASK	(0x3 << SYSC_TYPE3_MIDLEMODE_SHIFT)
 
+/*
+ * OCP SYSCONFIG bit shifts/masks TYPE4.
+ */
+#define SYSC_TYPE4_SIDLEMODE_SHIFT	2
+#define SYSC_TYPE4_SIDLEMODE_MASK	(0x3 << SYSC_TYPE4_SIDLEMODE_SHIFT)
+#define SYSC_TYPE4_SOFTRESET_SHIFT	1
+#define SYSC_TYPE4_SOFTRESET_MASK	(1 << SYSC_TYPE4_SOFTRESET_SHIFT)
+#define SYSC_TYPE4_AUTOIDLE_SHIFT	0
+#define SYSC_TYPE4_AUTOIDLE_MASK	(1 << SYSC_TYPE4_AUTOIDLE_SHIFT)
+
 /* OCP SYSSTATUS bit shifts/masks */
 #define SYSS_RESETDONE_SHIFT		0
 #define SYSS_RESETDONE_MASK		(1 << SYSS_RESETDONE_SHIFT)
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
index 79d623b..7443dc0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -59,6 +59,16 @@ struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3 = {
 	.sidle_shift	= SYSC_TYPE3_SIDLEMODE_SHIFT,
 };
 
+/**
+ * struct omap_hwmod_sysc_type4 - TYPE4 sysconfig scheme.
+ * Used by some IPs on AM33xx
+ */
+struct omap_hwmod_sysc_fields omap_hwmod_sysc_type4 = {
+	.sidle_shift	= SYSC_TYPE4_SIDLEMODE_SHIFT,
+	.srst_shift	= SYSC_TYPE4_SOFTRESET_SHIFT,
+	.autoidle_shift	= SYSC_TYPE4_AUTOIDLE_SHIFT,
+};
+
 struct omap_dss_dispc_dev_attr omap2_3_dss_dispc_dev_attr = {
 	.manager_count		= 2,
 	.has_framedonetv_irq	= 0
-- 
1.7.9.5
