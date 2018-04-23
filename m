From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/16] ARM: OMAP2+: Use signed value for sysc register offsets
Date: Mon, 23 Apr 2018 10:45:36 -0700
Message-ID: <20180423174549.57412-4-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
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
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We currently don't know if a revision register exists or not. Zero is
often a valid offset for the revision register. As we are still checking
device tree data against platform data, we will get bogus warnings with
correct device tree data because of incomplete platform data.

Let's fix the issue by using signed offsets and tag the revision registers
that don't exist with -ENODEV, and init the missing ones with the correct
revision register offset.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c              | 21 ++++++++++---------
 arch/arm/mach-omap2/omap_hwmod.h              |  6 +++---
 .../omap_hwmod_33xx_43xx_ipblock_data.c       |  1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  4 ++++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c    |  1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  4 ++++
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c    |  3 +++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c     |  6 ++++++
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c    |  1 +
 9 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -481,7 +481,7 @@ static int _wait_softreset_complete(struct omap_hwmod *oh)
 
 	sysc = oh->class->sysc;
 
-	if (sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
+	if (sysc->sysc_flags & SYSS_HAS_RESET_STATUS && sysc->syss_offs > 0)
 		omap_test_timeout((omap_hwmod_read(oh, sysc->syss_offs)
 				   & SYSS_RESETDONE_MASK),
 				  MAX_MODULE_SOFTRESET_WAIT, c);
@@ -3171,19 +3171,19 @@ static int omap_hwmod_init_regbits(struct device *dev,
  */
 int omap_hwmod_init_reg_offs(struct device *dev,
 			     const struct ti_sysc_module_data *data,
-			     u32 *rev_offs, u32 *sysc_offs, u32 *syss_offs)
+			     s32 *rev_offs, s32 *sysc_offs, s32 *syss_offs)
 {
-	*rev_offs = 0;
+	*rev_offs = -ENODEV;
 	*sysc_offs = 0;
 	*syss_offs = 0;
 
-	if (data->offsets[SYSC_REVISION] > 0)
+	if (data->offsets[SYSC_REVISION] >= 0)
 		*rev_offs = data->offsets[SYSC_REVISION];
 
-	if (data->offsets[SYSC_SYSCONFIG] > 0)
+	if (data->offsets[SYSC_SYSCONFIG] >= 0)
 		*sysc_offs = data->offsets[SYSC_SYSCONFIG];
 
-	if (data->offsets[SYSC_SYSSTATUS] > 0)
+	if (data->offsets[SYSC_SYSSTATUS] >= 0)
 		*syss_offs = data->offsets[SYSC_SYSSTATUS];
 
 	return 0;
@@ -3312,8 +3312,8 @@ static int omap_hwmod_check_module(struct device *dev,
 				   struct omap_hwmod *oh,
 				   const struct ti_sysc_module_data *data,
 				   struct sysc_regbits *sysc_fields,
-				   u32 rev_offs, u32 sysc_offs,
-				   u32 syss_offs, u32 sysc_flags,
+				   s32 rev_offs, s32 sysc_offs,
+				   s32 syss_offs, u32 sysc_flags,
 				   u32 idlemodes)
 {
 	if (!oh->class->sysc)
@@ -3365,7 +3365,7 @@ static int omap_hwmod_check_module(struct device *dev,
 int omap_hwmod_allocate_module(struct device *dev, struct omap_hwmod *oh,
 			       const struct ti_sysc_module_data *data,
 			       struct sysc_regbits *sysc_fields,
-			       u32 rev_offs, u32 sysc_offs, u32 syss_offs,
+			       s32 rev_offs, s32 sysc_offs, s32 syss_offs,
 			       u32 sysc_flags, u32 idlemodes)
 {
 	struct omap_hwmod_class_sysconfig *sysc;
@@ -3425,7 +3425,8 @@ int omap_hwmod_init_module(struct device *dev,
 {
 	struct omap_hwmod *oh;
 	struct sysc_regbits *sysc_fields;
-	u32 rev_offs, sysc_offs, syss_offs, sysc_flags, idlemodes;
+	s32 rev_offs, sysc_offs, syss_offs;
+	u32 sysc_flags, idlemodes;
 	int error;
 
 	if (!dev || !data)
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -317,9 +317,9 @@ struct omap_hwmod_ocp_if {
  * then this field has to be populated with the correct offset structure.
  */
 struct omap_hwmod_class_sysconfig {
-	u32 rev_offs;
-	u32 sysc_offs;
-	u32 syss_offs;
+	s32 rev_offs;
+	s32 sysc_offs;
+	s32 syss_offs;
 	u16 sysc_flags;
 	struct sysc_regbits *sysc_fields;
 	u8 srst_udelay;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -629,6 +629,7 @@ struct omap_hwmod am33xx_gpmc_hwmod = {
 
 /* 'i2c' class */
 static struct omap_hwmod_class_sysconfig am33xx_i2c_sysc = {
+	.rev_offs	= 0,
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0090,
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -885,6 +885,7 @@ static struct omap_hwmod omap3xxx_dma_system_hwmod = {
  */
 
 static struct omap_hwmod_class_sysconfig omap3xxx_mcbsp_sysc = {
+	.rev_offs	= -ENODEV,
 	.sysc_offs	= 0x008c,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_ENAWAKEUP |
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
@@ -990,6 +991,7 @@ static struct omap_hwmod omap3xxx_mcbsp5_hwmod = {
 
 /* 'mcbsp sidetone' class */
 static struct omap_hwmod_class_sysconfig omap3xxx_mcbsp_sidetone_sysc = {
+	.rev_offs	= -ENODEV,
 	.sysc_offs	= 0x0010,
 	.sysc_flags	= SYSC_HAS_AUTOIDLE,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
@@ -1018,6 +1020,7 @@ static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod = {
 
 /* SR common */
 static struct omap_hwmod_class_sysconfig omap34xx_sr_sysc = {
+	.rev_offs	= -ENODEV,
 	.sysc_offs	= 0x24,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_NO_CACHE),
 	.sysc_fields	= &omap34xx_sr_sysc_fields,
@@ -1030,6 +1033,7 @@ static struct omap_hwmod_class omap34xx_smartreflex_hwmod_class = {
 };
 
 static struct omap_hwmod_class_sysconfig omap36xx_sr_sysc = {
+	.rev_offs	= -ENODEV,
 	.sysc_offs	= 0x38,
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_ENAWAKEUP |
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -378,6 +378,7 @@ static struct omap_hwmod am43xx_usb_otg_ss1_hwmod = {
 };
 
 static struct omap_hwmod_class_sysconfig am43xx_qspi_sysc = {
+	.rev_offs	= 0,
 	.sysc_offs      = 0x0010,
 	.sysc_flags     = SYSC_HAS_SIDLEMODE,
 	.idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1360,6 +1360,7 @@ static struct omap_hwmod omap44xx_hsi_hwmod = {
  */
 
 static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
+	.rev_offs	= 0,
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0090,
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
@@ -1634,6 +1635,7 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
 
 /* The IP is not compliant to type1 / type2 scheme */
 static struct omap_hwmod_class_sysconfig omap44xx_mcasp_sysc = {
+	.rev_offs	= 0,
 	.sysc_offs	= 0x0004,
 	.sysc_flags	= SYSC_HAS_SIDLEMODE,
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
@@ -1667,6 +1669,7 @@ static struct omap_hwmod omap44xx_mcasp_hwmod = {
  */
 
 static struct omap_hwmod_class_sysconfig omap44xx_mcbsp_sysc = {
+	.rev_offs	= -ENODEV,
 	.sysc_offs	= 0x008c,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_ENAWAKEUP |
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
@@ -2353,6 +2356,7 @@ static struct omap_hwmod omap44xx_slimbus2_hwmod = {
 
 /* The IP is not compliant to type1 / type2 scheme */
 static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
+	.rev_offs	= -ENODEV,
 	.sysc_offs	= 0x0038,
 	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -804,6 +804,7 @@ static struct omap_hwmod omap54xx_gpio8_hwmod = {
  */
 
 static struct omap_hwmod_class_sysconfig omap54xx_i2c_sysc = {
+	.rev_offs	= 0,
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0090,
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
@@ -974,6 +975,7 @@ static struct omap_hwmod omap54xx_mailbox_hwmod = {
  */
 
 static struct omap_hwmod_class_sysconfig omap54xx_mcbsp_sysc = {
+	.rev_offs	= -ENODEV,
 	.sysc_offs	= 0x008c,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_ENAWAKEUP |
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
@@ -1997,6 +1999,7 @@ static struct omap_hwmod omap54xx_ocp2scp3_hwmod = {
  */
 
 static struct omap_hwmod_class_sysconfig omap54xx_sata_sysc = {
+	.rev_offs	= 0x00fc,
 	.sysc_offs	= 0x0000,
 	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1070,6 +1070,7 @@ static struct omap_hwmod dra7xx_hdq1w_hwmod = {
  */
 
 static struct omap_hwmod_class_sysconfig dra7xx_i2c_sysc = {
+	.rev_offs	= 0,
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0090,
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
@@ -1440,6 +1441,7 @@ static struct omap_hwmod dra7xx_mcspi4_hwmod = {
  *
  */
 static struct omap_hwmod_class_sysconfig dra7xx_mcasp_sysc = {
+	.rev_offs	= 0,
 	.sysc_offs	= 0x0004,
 	.sysc_flags	= SYSC_HAS_SIDLEMODE,
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
@@ -1898,6 +1900,7 @@ static struct omap_hwmod dra7xx_pciess2_hwmod = {
  */
 
 static struct omap_hwmod_class_sysconfig dra7xx_qspi_sysc = {
+	.rev_offs	= 0,
 	.sysc_offs	= 0x0010,
 	.sysc_flags	= SYSC_HAS_SIDLEMODE,
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
@@ -1930,6 +1933,7 @@ static struct omap_hwmod dra7xx_qspi_hwmod = {
  *
  */
 static struct omap_hwmod_class_sysconfig dra7xx_rtcss_sysc = {
+	.rev_offs	= 0x0074,
 	.sysc_offs	= 0x0078,
 	.sysc_flags	= SYSC_HAS_SIDLEMODE,
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
@@ -1965,6 +1969,7 @@ static struct omap_hwmod dra7xx_rtcss_hwmod = {
  */
 
 static struct omap_hwmod_class_sysconfig dra7xx_sata_sysc = {
+	.rev_offs	= 0x00fc,
 	.sysc_offs	= 0x0000,
 	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
@@ -2003,6 +2008,7 @@ static struct omap_hwmod dra7xx_sata_hwmod = {
 
 /* The IP is not compliant to type1 / type2 scheme */
 static struct omap_hwmod_class_sysconfig dra7xx_smartreflex_sysc = {
+	.rev_offs	= -ENODEV,
 	.sysc_offs	= 0x0038,
 	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -954,6 +954,7 @@ static struct omap_hwmod_ocp_if dm816x_l4_hs__emac1 = {
 };
 
 static struct omap_hwmod_class_sysconfig dm81xx_sata_sysc = {
+	.rev_offs	= 0x00fc,
 	.sysc_offs	= 0x1100,
 	.sysc_flags	= SYSC_HAS_SIDLEMODE,
 	.idlemodes	= SIDLE_FORCE,
-- 
2.17.0
