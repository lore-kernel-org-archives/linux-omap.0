From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/9] ARM: OMAP2+: Move all omap_hwmod_sysc_fields to
 omap_hwmod_common_data.c
Date: Fri, 15 Dec 2017 10:08:54 -0800
Message-ID: <20171215180900.3243-4-tony@atomide.com>
References: <20171215180900.3243-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171215180900.3243-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We want to be able to eventually allocate these dynamically with the
data for omap_hwmod_class_sysconfig coming from dts.

Note that omap_hwmod_sysc_type_smartreflex is the same as the older
omap36xx_sr_sysc_fields, so let's use the earlier omap36xx_sr_sysc_fields
instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.h             |  6 ++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   | 21 -------------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   | 17 +--------------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c    |  7 +------
 arch/arm/mach-omap2/omap_hwmod_common_data.c | 31 ++++++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -40,6 +40,12 @@ struct omap_device;
 extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type1;
 extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
 extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
+extern struct omap_hwmod_sysc_fields omap34xx_sr_sysc_fields;
+extern struct omap_hwmod_sysc_fields omap36xx_sr_sysc_fields;
+extern struct omap_hwmod_sysc_fields omap3_sham_sysc_fields;
+extern struct omap_hwmod_sysc_fields omap3xxx_aes_sysc_fields;
+extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_mcasp;
+extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_usb_host_fs;
 
 /*
  * OCP SYSCONFIG bit shifts/masks TYPE1. These are for IPs compliant
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1190,10 +1190,6 @@ static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod = {
 };
 
 /* SR common */
-static struct omap_hwmod_sysc_fields omap34xx_sr_sysc_fields = {
-	.clkact_shift	= 20,
-};
-
 static struct omap_hwmod_class_sysconfig omap34xx_sr_sysc = {
 	.sysc_offs	= 0x24,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_NO_CACHE),
@@ -1206,11 +1202,6 @@ static struct omap_hwmod_class omap34xx_smartreflex_hwmod_class = {
 	.rev  = 1,
 };
 
-static struct omap_hwmod_sysc_fields omap36xx_sr_sysc_fields = {
-	.sidle_shift	= 24,
-	.enwkup_shift	= 26,
-};
-
 static struct omap_hwmod_class_sysconfig omap36xx_sr_sysc = {
 	.sysc_offs	= 0x38,
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
@@ -2731,12 +2722,6 @@ static struct omap_hwmod_ocp_if omap3xxx_l3_main__gpmc = {
 };
 
 /* l4_core -> SHAM2 (SHA1/MD5) (similar to omap24xx) */
-static struct omap_hwmod_sysc_fields omap3_sham_sysc_fields = {
-	.sidle_shift	= 4,
-	.srst_shift	= 1,
-	.autoidle_shift	= 0,
-};
-
 static struct omap_hwmod_class_sysconfig omap3_sham_sysc = {
 	.rev_offs	= 0x5c,
 	.sysc_offs	= 0x60,
@@ -2777,12 +2762,6 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__sham = {
 };
 
 /* l4_core -> AES */
-static struct omap_hwmod_sysc_fields omap3xxx_aes_sysc_fields = {
-	.sidle_shift	= 6,
-	.srst_shift	= 1,
-	.autoidle_shift	= 0,
-};
-
 static struct omap_hwmod_class_sysconfig omap3_aes_sysc = {
 	.rev_offs	= 0x44,
 	.sysc_offs	= 0x48,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1658,10 +1658,6 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
  */
 
 /* The IP is not compliant to type1 / type2 scheme */
-static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_mcasp = {
-	.sidle_shift	= 0,
-};
-
 static struct omap_hwmod_class_sysconfig omap44xx_mcasp_sysc = {
 	.sysc_offs	= 0x0004,
 	.sysc_flags	= SYSC_HAS_SIDLEMODE,
@@ -2403,17 +2399,12 @@ static struct omap_hwmod omap44xx_slimbus2_hwmod = {
  */
 
 /* The IP is not compliant to type1 / type2 scheme */
-static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_smartreflex = {
-	.sidle_shift	= 24,
-	.enwkup_shift	= 26,
-};
-
 static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
 	.sysc_offs	= 0x0038,
 	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type_smartreflex,
+	.sysc_fields	= &omap36xx_sr_sysc_fields,
 };
 
 static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
@@ -2844,12 +2835,6 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
  */
 
 /* The IP is not compliant to type1 / type2 scheme */
-static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_usb_host_fs = {
-	.midle_shift	= 4,
-	.sidle_shift	= 2,
-	.srst_shift	= 1,
-};
-
 static struct omap_hwmod_class_sysconfig omap44xx_usb_host_fs_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0210,
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2055,17 +2055,12 @@ static struct omap_hwmod dra7xx_sata_hwmod = {
  */
 
 /* The IP is not compliant to type1 / type2 scheme */
-static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_smartreflex = {
-	.sidle_shift	= 24,
-	.enwkup_shift	= 26,
-};
-
 static struct omap_hwmod_class_sysconfig dra7xx_smartreflex_sysc = {
 	.sysc_offs	= 0x0038,
 	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type_smartreflex,
+	.sysc_fields	= &omap36xx_sr_sysc_fields,
 };
 
 static struct omap_hwmod_class dra7xx_smartreflex_hwmod_class = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -63,3 +63,34 @@ struct omap_dss_dispc_dev_attr omap2_3_dss_dispc_dev_attr = {
 	.manager_count		= 2,
 	.has_framedonetv_irq	= 0
 };
+
+struct omap_hwmod_sysc_fields omap34xx_sr_sysc_fields = {
+	.clkact_shift	= 20,
+};
+
+struct omap_hwmod_sysc_fields omap36xx_sr_sysc_fields = {
+	.sidle_shift	= 24,
+	.enwkup_shift	= 26,
+};
+
+struct omap_hwmod_sysc_fields omap3_sham_sysc_fields = {
+	.sidle_shift	= 4,
+	.srst_shift	= 1,
+	.autoidle_shift	= 0,
+};
+
+struct omap_hwmod_sysc_fields omap3xxx_aes_sysc_fields = {
+	.sidle_shift	= 6,
+	.srst_shift	= 1,
+	.autoidle_shift	= 0,
+};
+
+struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_mcasp = {
+	.sidle_shift	= 0,
+};
+
+struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_usb_host_fs = {
+	.midle_shift	= 4,
+	.sidle_shift	= 2,
+	.srst_shift	= 1,
+};
-- 
2.15.0
