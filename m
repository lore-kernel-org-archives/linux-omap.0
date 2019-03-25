From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/7] ARM: OMAP2+: Remove hwmod .rev data and use local SoC
 checks instead
Date: Mon, 25 Mar 2019 11:38:18 -0700
Message-ID: <20190325183819.15400-7-tony@atomide.com>
References: <20190325183819.15400-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190325183819.15400-1-tony@atomide.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can just check for omap2 and 3 for i2c and smartreflex locally.
The rest of the .rev data is already unused.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/i2c.c                             | 11 +++--------
 arch/arm/mach-omap2/omap_hwmod.h                      |  2 --
 arch/arm/mach-omap2/omap_hwmod_2420_data.c            |  1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c            |  1 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c    |  1 -
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c    |  2 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c            |  4 ----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c            |  3 ---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c            |  2 --
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c             |  5 -----
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c            |  1 -
 arch/arm/mach-omap2/sr_device.c                       |  5 ++++-
 12 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -53,15 +53,10 @@ int omap_i2c_reset(struct omap_hwmod *oh)
 	u16 i2c_con;
 	int c = 0;
 
-	if (oh->class->rev == OMAP_I2C_IP_VERSION_2) {
-		i2c_con = OMAP4_I2C_CON_OFFSET;
-	} else if (oh->class->rev == OMAP_I2C_IP_VERSION_1) {
+	if (soc_is_omap24xx() || soc_is_omap34xx() || soc_is_am35xx())
 		i2c_con = OMAP2_I2C_CON_OFFSET;
-	} else {
-		WARN(1, "Cannot reset I2C block %s: unsupported revision\n",
-		     oh->name);
-		return -EINVAL;
-	}
+	else
+		i2c_con = OMAP4_I2C_CON_OFFSET;
 
 	/* Disable I2C */
 	v = omap_hwmod_read(oh, i2c_con);
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -503,7 +503,6 @@ struct omap_hwmod_omap4_prcm {
  * struct omap_hwmod_class - the type of an IP block
  * @name: name of the hwmod_class
  * @sysc: device SYSCONFIG/SYSSTATUS register data
- * @rev: revision of the IP class
  * @pre_shutdown: ptr to fn to be executed immediately prior to device shutdown
  * @reset: ptr to fn to be executed in place of the standard hwmod reset fn
  * @enable_preprogram:  ptr to fn to be executed during device enable
@@ -529,7 +528,6 @@ struct omap_hwmod_omap4_prcm {
 struct omap_hwmod_class {
 	const char				*name;
 	struct omap_hwmod_class_sysconfig	*sysc;
-	u32					rev;
 	int					(*pre_shutdown)(struct omap_hwmod *oh);
 	int					(*reset)(struct omap_hwmod *oh);
 	int					(*enable_preprogram)(struct omap_hwmod *oh);
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -91,7 +91,6 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
-	.rev		= OMAP_I2C_IP_VERSION_1,
 	.reset		= &omap_i2c_reset,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -68,7 +68,6 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
-	.rev		= OMAP_I2C_IP_VERSION_1,
 	.reset		= &omap_i2c_reset,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -96,7 +96,6 @@ static struct omap_hwmod_class_sysconfig omap2xxx_gpio_sysc = {
 struct omap_hwmod_class omap2xxx_gpio_hwmod_class = {
 	.name = "gpio",
 	.sysc = &omap2xxx_gpio_sysc,
-	.rev = 0,
 };
 
 /* system dma */
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -534,7 +534,6 @@ static struct omap_hwmod_class_sysconfig am33xx_gpio_sysc = {
 struct omap_hwmod_class am33xx_gpio_hwmod_class = {
 	.name		= "gpio",
 	.sysc		= &am33xx_gpio_sysc,
-	.rev		= 2,
 };
 
 /* gpio1 */
@@ -643,7 +642,6 @@ static struct omap_hwmod_class_sysconfig am33xx_i2c_sysc = {
 static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &am33xx_i2c_sysc,
-	.rev		= OMAP_I2C_IP_VERSION_2,
 	.reset		= &omap_i2c_reset,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -484,7 +484,6 @@ static struct omap_hwmod am35xx_uart4_hwmod = {
 static struct omap_hwmod_class i2c_class = {
 	.name	= "i2c",
 	.sysc	= &i2c_sysc,
-	.rev	= OMAP_I2C_IP_VERSION_1,
 	.reset	= &omap_i2c_reset,
 };
 
@@ -707,7 +706,6 @@ static struct omap_hwmod_class_sysconfig omap3xxx_gpio_sysc = {
 static struct omap_hwmod_class omap3xxx_gpio_hwmod_class = {
 	.name = "gpio",
 	.sysc = &omap3xxx_gpio_sysc,
-	.rev = 1,
 };
 
 /* gpio1 */
@@ -1029,7 +1027,6 @@ static struct omap_hwmod_class_sysconfig omap34xx_sr_sysc = {
 static struct omap_hwmod_class omap34xx_smartreflex_hwmod_class = {
 	.name = "smartreflex",
 	.sysc = &omap34xx_sr_sysc,
-	.rev  = 1,
 };
 
 static struct omap_hwmod_class_sysconfig omap36xx_sr_sysc = {
@@ -1044,7 +1041,6 @@ static struct omap_hwmod_class_sysconfig omap36xx_sr_sysc = {
 static struct omap_hwmod_class omap36xx_smartreflex_hwmod_class = {
 	.name = "smartreflex",
 	.sysc = &omap36xx_sr_sysc,
-	.rev  = 2,
 };
 
 /* SR1 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1075,7 +1075,6 @@ static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
 static struct omap_hwmod_class omap44xx_gpio_hwmod_class = {
 	.name	= "gpio",
 	.sysc	= &omap44xx_gpio_sysc,
-	.rev	= 2,
 };
 
 /* gpio1 */
@@ -1374,7 +1373,6 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.name	= "i2c",
 	.sysc	= &omap44xx_i2c_sysc,
-	.rev	= OMAP_I2C_IP_VERSION_2,
 	.reset	= &omap_i2c_reset,
 };
 
@@ -2367,7 +2365,6 @@ static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
 static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
 	.name	= "smartreflex",
 	.sysc	= &omap44xx_smartreflex_sysc,
-	.rev	= 2,
 };
 
 /* smartreflex_core */
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -620,7 +620,6 @@ static struct omap_hwmod_class_sysconfig omap54xx_gpio_sysc = {
 static struct omap_hwmod_class omap54xx_gpio_hwmod_class = {
 	.name	= "gpio",
 	.sysc	= &omap54xx_gpio_sysc,
-	.rev	= 2,
 };
 
 /* gpio1 */
@@ -819,7 +818,6 @@ static struct omap_hwmod_class omap54xx_i2c_hwmod_class = {
 	.name	= "i2c",
 	.sysc	= &omap54xx_i2c_sysc,
 	.reset	= &omap_i2c_reset,
-	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
 /* i2c1 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -693,7 +693,6 @@ static struct omap_hwmod_class_sysconfig dra7xx_aes_sysc = {
 static struct omap_hwmod_class dra7xx_aes_hwmod_class = {
 	.name	= "aes",
 	.sysc	= &dra7xx_aes_sysc,
-	.rev	= 2,
 };
 
 /* AES1 */
@@ -737,7 +736,6 @@ static struct omap_hwmod_class_sysconfig dra7xx_sha0_sysc = {
 static struct omap_hwmod_class dra7xx_sha0_hwmod_class = {
 	.name		= "sham",
 	.sysc		= &dra7xx_sha0_sysc,
-	.rev		= 2,
 };
 
 struct omap_hwmod dra7xx_sha0_hwmod = {
@@ -811,7 +809,6 @@ static struct omap_hwmod_class_sysconfig dra7xx_gpio_sysc = {
 static struct omap_hwmod_class dra7xx_gpio_hwmod_class = {
 	.name	= "gpio",
 	.sysc	= &dra7xx_gpio_sysc,
-	.rev	= 2,
 };
 
 /* gpio1 */
@@ -1085,7 +1082,6 @@ static struct omap_hwmod_class dra7xx_i2c_hwmod_class = {
 	.name	= "i2c",
 	.sysc	= &dra7xx_i2c_sysc,
 	.reset	= &omap_i2c_reset,
-	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
 /* i2c1 */
@@ -2019,7 +2015,6 @@ static struct omap_hwmod_class_sysconfig dra7xx_smartreflex_sysc = {
 static struct omap_hwmod_class dra7xx_smartreflex_hwmod_class = {
 	.name	= "smartreflex",
 	.sysc	= &dra7xx_smartreflex_sysc,
-	.rev	= 2,
 };
 
 /* smartreflex_core */
diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -484,7 +484,6 @@ static struct omap_hwmod_class_sysconfig dm81xx_gpio_sysc = {
 static struct omap_hwmod_class dm81xx_gpio_hwmod_class = {
 	.name	= "gpio",
 	.sysc	= &dm81xx_gpio_sysc,
-	.rev	= 2,
 };
 
 static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -119,7 +119,10 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 	}
 
 	sr_data->name = oh->name;
-	sr_data->ip_type = oh->class->rev;
+	if (cpu_is_omap343x())
+		sr_data->ip_type = 1;
+	else
+		sr_data->ip_type = 2;
 	sr_data->senn_mod = 0x1;
 	sr_data->senp_mod = 0x1;
 
-- 
2.21.0
