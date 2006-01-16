From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] Palm TE Touchscreen and fixes
Date: Tue, 17 Jan 2006 00:23:27 +0100
Message-ID: <fb249edb0601161523q70fc0ba1n@mail.gmail.com>
References: <fb249edb0601141306o6eb43a9o@mail.gmail.com>
	<20060115201949.GF5905@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_29734_25759083.1137453807791"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060115201949.GF5905@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

------=_Part_29734_25759083.1137453807791
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

> Regarding changes to clock.[ch], we should have CLOCK_IN_OMAP1510 and
> CLOCK_IN_OMAP3XX separate. At least the DSP clocks should not be on 310
> because it does not have a DSP AFAIK. They may be also other clocks that
> are not on 310.
>
> Could you please redo the clock.[ch] patch so it adds CLOCK_IN_OMAP3XX,
> and masks it only for the clocks you think you have on 310?
>
> Or if you don't know which clocks are on both 310 and 1510, you could
> just leave out DSP clocks for now, and enable all other 1510 clocks
> also for 310.

Indeed, I don't know which clocks are there and I don't know if the
board has a DSP or not. There is no real documentation for OMAP310
publicly availiable. The product page
(http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=3D=
6123&navigationId=3D11997&path=3Dtemplatedata/cm/product/data/omap_310)
doesn't mention DSP, except the line
"Digital Phase-Locked Loop (DPLL) for MPU/DSP/TC Clocking Control",
however it is said that OMAP310 is similar to OMAP5910
(http://focus.ti.com/docs/prod/folders/print/omap5910.html) which is
fully documented and this one definitely has a DSP.
After disabling the DSP related clocks and the DSP initialisation,
McBSP fails to initialise with the message: "mcbsp: could not acquire
dsp_ck handle", nevertheless the kernel still boots and everything
works fine. (It feels bad not knowing what's inside your computer.)
I'm attaching the same patch but with CLOCK_IN_OMAP1510 and
CLOCK_IN_OMAP310 separate and everything DSP-related turned off.
Regards,
--
balrog 2oo6

Dear Outlook users: Please remove me from your address books
http://www.newsforge.com/article.pl?sid=3D03/08/21/143258

------=_Part_29734_25759083.1137453807791
Content-Type: application/octet-stream; name=linux-palmte-errors.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-palmte-errors.patch"

diff -pNaur linux-omap-2.6.orig/arch/arm/mach-omap1/board-generic.c linux-omap-2.6/arch/arm/mach-omap1/board-generic.c
--- linux-omap-2.6.orig/arch/arm/mach-omap1/board-generic.c	2006-01-14 15:58:56.000000000 +0100
+++ linux-omap-2.6/arch/arm/mach-omap1/board-generic.c	2006-01-16 05:37:51.000000000 +0100
@@ -88,7 +88,7 @@ static struct omap_board_config_kernel g
 static void __init omap_generic_init(void)
 {
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		generic_config[0].data = &generic1510_usb_config;
 	}
 #endif
diff -pNaur linux-omap-2.6.orig/arch/arm/mach-omap1/clock.c linux-omap-2.6/arch/arm/mach-omap1/clock.c
--- linux-omap-2.6.orig/arch/arm/mach-omap1/clock.c	2006-01-14 15:58:56.000000000 +0100
+++ linux-omap-2.6/arch/arm/mach-omap1/clock.c	2006-01-16 05:37:51.000000000 +0100
@@ -687,6 +687,11 @@ int __init omap1_clk_init(void)
 			clk_register(*clkp);
 			continue;
 		}
+
+		if (((*clkp)->flags &CLOCK_IN_OMAP310) && cpu_is_omap310()) {
+			clk_register(*clkp);
+			continue;
+		}
 	}
 
 	info = omap_get_config(OMAP_TAG_CLOCK, struct omap_clock_config);
@@ -784,7 +789,7 @@ int __init omap1_clk_init(void)
 	clk_enable(&armxor_ck.clk);
 	clk_enable(&armtim_ck.clk); /* This should be done by timer code */
 
-	if (cpu_is_omap1510())
+	if (cpu_is_omap15xx())
 		clk_enable(&arm_gpio_ck);
 
 	return 0;
diff -pNaur linux-omap-2.6.orig/arch/arm/mach-omap1/clock.h linux-omap-2.6/arch/arm/mach-omap1/clock.h
--- linux-omap-2.6.orig/arch/arm/mach-omap1/clock.h	2006-01-14 15:58:56.000000000 +0100
+++ linux-omap-2.6/arch/arm/mach-omap1/clock.h	2006-01-16 05:46:42.000000000 +0100
@@ -151,7 +151,7 @@ static struct clk ck_ref = {
 	.name		= "ck_ref",
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
 };
@@ -160,7 +160,7 @@ static struct clk ck_dpll1 = {
 	.name		= "ck_dpll1",
 	.parent		= &ck_ref,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  RATE_PROPAGATES | ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
 };
@@ -183,7 +183,8 @@ static struct clk arm_ck = {
 	.name		= "arm_ck",
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  RATE_CKCTL | RATE_PROPAGATES | ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | RATE_CKCTL | RATE_PROPAGATES |
+			  ALWAYS_ENABLED,
 	.rate_offset	= CKCTL_ARMDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -195,7 +196,8 @@ static struct arm_idlect1_clk armper_ck 
 		.name		= "armper_ck",
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  RATE_CKCTL | CLOCK_IDLE_CONTROL,
+				  CLOCK_IN_OMAP310 | RATE_CKCTL |
+				  CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_PERCK,
 		.rate_offset	= CKCTL_PERDIV_OFFSET,
@@ -209,7 +211,7 @@ static struct arm_idlect1_clk armper_ck 
 static struct clk arm_gpio_ck = {
 	.name		= "arm_gpio_ck",
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510,
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 	.enable_reg	= (void __iomem *)ARM_IDLECT2,
 	.enable_bit	= EN_GPIOCK,
 	.recalc		= &followparent_recalc,
@@ -222,7 +224,7 @@ static struct arm_idlect1_clk armxor_ck 
 		.name		= "armxor_ck",
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  CLOCK_IDLE_CONTROL,
+				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_XORPCK,
 		.recalc		= &followparent_recalc,
@@ -237,7 +239,7 @@ static struct arm_idlect1_clk armtim_ck 
 		.name		= "armtim_ck",
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  CLOCK_IDLE_CONTROL,
+				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_TIMCK,
 		.recalc		= &followparent_recalc,
@@ -252,7 +254,7 @@ static struct arm_idlect1_clk armwdt_ck 
 		.name		= "armwdt_ck",
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  CLOCK_IDLE_CONTROL,
+				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_WDTCK,
 		.recalc		= &omap1_watchdog_recalc,
@@ -344,9 +346,9 @@ static struct arm_idlect1_clk tc_ck = {
 		.name		= "tc_ck",
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  CLOCK_IN_OMAP730 | RATE_CKCTL |
-				  RATE_PROPAGATES | ALWAYS_ENABLED |
-				  CLOCK_IDLE_CONTROL,
+				  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
+				  RATE_CKCTL | RATE_PROPAGATES |
+				  ALWAYS_ENABLED | CLOCK_IDLE_CONTROL,
 		.rate_offset	= CKCTL_TCDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -358,7 +360,8 @@ static struct arm_idlect1_clk tc_ck = {
 static struct clk arminth_ck1510 = {
 	.name		= "arminth_ck",
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP1510 | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
+			  ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
 	/* Note: On 1510 the frequency follows TC_CK
 	 *
@@ -372,7 +375,8 @@ static struct clk tipb_ck = {
 	/* No-idle controlled by "tc_ck" */
 	.name		= "tibp_ck",
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP1510 | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
+			  ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -417,7 +421,7 @@ static struct clk dma_ck = {
 	.name		= "dma_ck",
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -437,7 +441,7 @@ static struct arm_idlect1_clk api_ck = {
 		.name		= "api_ck",
 		.parent		= &tc_ck.clk,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  CLOCK_IDLE_CONTROL,
+				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_APICK,
 		.recalc		= &followparent_recalc,
@@ -451,7 +455,8 @@ static struct arm_idlect1_clk lb_ck = {
 	.clk = {
 		.name		= "lb_ck",
 		.parent		= &tc_ck.clk,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IDLE_CONTROL,
+		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
+				  CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_LBCK,
 		.recalc		= &followparent_recalc,
@@ -495,8 +500,8 @@ static struct arm_idlect1_clk lcd_ck_151
 	.clk = {
 		.name		= "lcd_ck",
 		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IN_OMAP1510 | RATE_CKCTL |
-				  CLOCK_IDLE_CONTROL,
+		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
+				  RATE_CKCTL | CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_LCDCK,
 		.rate_offset	= CKCTL_LCDDIV_OFFSET,
@@ -512,8 +517,9 @@ static struct clk uart1_1510 = {
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | ENABLE_REG_32BIT |
-			  ALWAYS_ENABLED | CLOCK_NO_IDLE_PARENT,
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
+			  ENABLE_REG_32BIT | ALWAYS_ENABLED |
+			  CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
@@ -544,8 +550,8 @@ static struct clk uart2_ck = {
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  ENABLE_REG_32BIT | ALWAYS_ENABLED |
-			  CLOCK_NO_IDLE_PARENT,
+			  CLOCK_IN_OMAP310 | ENABLE_REG_32BIT |
+			  ALWAYS_ENABLED | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 30,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
@@ -559,8 +565,9 @@ static struct clk uart3_1510 = {
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | ENABLE_REG_32BIT |
-			  ALWAYS_ENABLED | CLOCK_NO_IDLE_PARENT,
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
+			  ENABLE_REG_32BIT | ALWAYS_ENABLED |
+			  CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
@@ -590,7 +597,7 @@ static struct clk usb_clko = {	/* 6 MHz 
 	/* Direct from ULPD, no parent */
 	.rate		= 6000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  RATE_FIXED | ENABLE_REG_32BIT,
+			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)ULPD_CLOCK_CTRL,
 	.enable_bit	= USB_MCLK_EN_BIT,
 	.enable		= &omap1_clk_enable_generic,
@@ -601,7 +608,7 @@ static struct clk usb_hhc_ck1510 = {
 	.name		= "usb_hhc_ck",
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
-	.flags		= CLOCK_IN_OMAP1510 |
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 			  RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= USB_HOST_HHC_UHOST_EN,
@@ -637,7 +644,9 @@ static struct clk mclk_1510 = {
 	.name		= "mclk",
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | RATE_FIXED,
+ 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | RATE_FIXED,
+ 	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
+ 	.enable_bit	= 6,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
 };
@@ -659,7 +668,7 @@ static struct clk bclk_1510 = {
 	.name		= "bclk",
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | RATE_FIXED,
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | RATE_FIXED,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
 };
@@ -683,7 +692,8 @@ static struct clk mmc1_ck = {
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT |
+			  CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 23,
 	.enable		= &omap1_clk_enable_generic,
@@ -706,7 +716,7 @@ static struct clk mmc2_ck = {
 static struct clk virtual_ck_mpu = {
 	.name		= "mpu",
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  VIRTUAL_CLOCK | ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | VIRTUAL_CLOCK | ALWAYS_ENABLED,
 	.parent		= &arm_ck, /* Is smarter alias for */
 	.recalc		= &followparent_recalc,
 	.set_rate	= &omap1_select_table_rate,
diff -pNaur linux-omap-2.6.orig/arch/arm/mach-omap1/io.c linux-omap-2.6/arch/arm/mach-omap1/io.c
--- linux-omap-2.6.orig/arch/arm/mach-omap1/io.c	2006-01-14 15:58:56.000000000 +0100
+++ linux-omap-2.6/arch/arm/mach-omap1/io.c	2006-01-16 05:37:51.000000000 +0100
@@ -110,7 +110,7 @@ void __init omap1_map_common_io(void)
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		iotable_init(omap1510_io_desc, ARRAY_SIZE(omap1510_io_desc));
 	}
 #endif
diff -pNaur linux-omap-2.6.orig/arch/arm/mach-omap1/pm.c linux-omap-2.6/arch/arm/mach-omap1/pm.c
--- linux-omap-2.6.orig/arch/arm/mach-omap1/pm.c	2006-01-14 15:58:56.000000000 +0100
+++ linux-omap-2.6/arch/arm/mach-omap1/pm.c	2006-01-16 05:37:51.000000000 +0100
@@ -165,7 +165,7 @@ void omap_pm_idle(void)
 	if ((use_idlect1 != ~0) || !do_sleep) {
 
 		__u32 saved_idlect1 = omap_readl(ARM_IDLECT1);
-		if (cpu_is_omap1510())
+		if (cpu_is_omap15xx())
 			use_idlect1 &= OMAP1510_BIG_SLEEP_REQUEST;
 		else
 			use_idlect1 &= OMAP1610_IDLECT1_SLEEP_VAL;
@@ -204,7 +204,7 @@ static void omap_pm_wakeup_setup(void)
 	if (cpu_is_omap730())
 		level1_wake = OMAP_IRQ_BIT(INT_730_GPIO_BANK1) |
 			OMAP_IRQ_BIT(INT_730_IH2_IRQ);
-	else if (cpu_is_omap1510())
+	else if (cpu_is_omap15xx())
 		level1_wake = OMAP_IRQ_BIT(INT_GPIO_BANK1) |
 			OMAP_IRQ_BIT(INT_1510_IH2_IRQ);
 	else if (cpu_is_omap16xx())
@@ -218,7 +218,7 @@ static void omap_pm_wakeup_setup(void)
 		omap_writel(~(OMAP_IRQ_BIT(INT_730_WAKE_UP_REQ) |
 				OMAP_IRQ_BIT(INT_730_MPUIO_KEYPAD)),
 				OMAP_IH2_1_MIR);
-	} else if (cpu_is_omap1510()) {
+	} else if (cpu_is_omap15xx()) {
 		level2_wake |= OMAP_IRQ_BIT(INT_KEYBOARD);
 		omap_writel(~level2_wake,  OMAP_IH2_MIR);
 	} else if (cpu_is_omap16xx()) {
@@ -283,7 +283,7 @@ void omap_pm_suspend(void)
 		MPUI730_SAVE(EMIFS_CONFIG);
 		MPUI730_SAVE(EMIFF_SDRAM_CONFIG);
 
-	} else if (cpu_is_omap1510()) {
+	} else if (cpu_is_omap15xx()) {
 		MPUI1510_SAVE(OMAP_IH1_MIR);
 		MPUI1510_SAVE(OMAP_IH2_MIR);
 		MPUI1510_SAVE(MPUI_CTRL);
@@ -307,7 +307,7 @@ void omap_pm_suspend(void)
 	ARM_SAVE(ARM_CKCTL);
 	ARM_SAVE(ARM_IDLECT1);
 	ARM_SAVE(ARM_IDLECT2);
-	if (!(cpu_is_omap1510()))
+	if (!(cpu_is_omap15xx()))
 		ARM_SAVE(ARM_IDLECT3);
 	ARM_SAVE(ARM_EWUPCT);
 	ARM_SAVE(ARM_RSTCT1);
@@ -395,7 +395,7 @@ void omap_pm_suspend(void)
 	 * Restore ARM state, except ARM_IDLECT1/2 which omap_cpu_suspend did
 	 */
 
-	if (!(cpu_is_omap1510()))
+	if (!(cpu_is_omap15xx()))
 		ARM_RESTORE(ARM_IDLECT3);
 	ARM_RESTORE(ARM_CKCTL);
 	ARM_RESTORE(ARM_EWUPCT);
@@ -411,7 +411,7 @@ void omap_pm_suspend(void)
 		MPUI730_RESTORE(OMAP_IH1_MIR);
 		MPUI730_RESTORE(OMAP_IH2_0_MIR);
 		MPUI730_RESTORE(OMAP_IH2_1_MIR);
-	} else if (cpu_is_omap1510()) {
+	} else if (cpu_is_omap15xx()) {
 		MPUI1510_RESTORE(MPUI_CTRL);
 		MPUI1510_RESTORE(MPUI_DSP_BOOT_CONFIG);
 		MPUI1510_RESTORE(MPUI_DSP_API_CONFIG);
@@ -472,7 +472,7 @@ static int omap_pm_read_proc(
 	ARM_SAVE(ARM_CKCTL);
 	ARM_SAVE(ARM_IDLECT1);
 	ARM_SAVE(ARM_IDLECT2);
-	if (!(cpu_is_omap1510()))
+	if (!(cpu_is_omap15xx()))
 		ARM_SAVE(ARM_IDLECT3);
 	ARM_SAVE(ARM_EWUPCT);
 	ARM_SAVE(ARM_RSTCT1);
@@ -493,7 +493,7 @@ static int omap_pm_read_proc(
 		MPUI730_SAVE(MPUI_DSP_API_CONFIG);
 		MPUI730_SAVE(EMIFF_SDRAM_CONFIG);
 		MPUI730_SAVE(EMIFS_CONFIG);
-	} else if (cpu_is_omap1510()) {
+	} else if (cpu_is_omap15xx()) {
 		MPUI1510_SAVE(MPUI_CTRL);
 		MPUI1510_SAVE(MPUI_DSP_STATUS);
 		MPUI1510_SAVE(MPUI_DSP_BOOT_CONFIG);
@@ -556,7 +556,7 @@ static int omap_pm_read_proc(
 			   MPUI730_SHOW(MPUI_DSP_API_CONFIG),
 			   MPUI730_SHOW(EMIFF_SDRAM_CONFIG),
 			   MPUI730_SHOW(EMIFS_CONFIG));
-		} else if (cpu_is_omap1510()) {
+		} else if (cpu_is_omap15xx()) {
 			my_buffer_offset += sprintf(my_base + my_buffer_offset,
 			   "MPUI1510_CTRL_REG             0x%-8x \n"
 			   "MPUI1510_DSP_STATUS_REG:      0x%-8x \n"
@@ -716,7 +716,7 @@ static int __init omap_pm_init(void)
 						omap730_idle_loop_suspend_sz);
 		omap_sram_suspend = omap_sram_push(omap730_cpu_suspend,
 						   omap730_cpu_suspend_sz);
-	} else if (cpu_is_omap1510()) {
+	} else if (cpu_is_omap15xx()) {
 		omap_sram_idle = omap_sram_push(omap1510_idle_loop_suspend,
 						omap1510_idle_loop_suspend_sz);
 		omap_sram_suspend = omap_sram_push(omap1510_cpu_suspend,
diff -pNaur linux-omap-2.6.orig/arch/arm/plat-omap/gpio.c linux-omap-2.6/arch/arm/plat-omap/gpio.c
--- linux-omap-2.6.orig/arch/arm/plat-omap/gpio.c	2006-01-14 15:58:57.000000000 +0100
+++ linux-omap-2.6/arch/arm/plat-omap/gpio.c	2006-01-16 05:37:51.000000000 +0100
@@ -174,7 +174,7 @@ static int gpio_bank_count;
 static inline struct gpio_bank *get_gpio_bank(int gpio)
 {
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		if (OMAP_GPIO_IS_MPUIO(gpio))
 			return &gpio_bank[0];
 		return &gpio_bank[1];
@@ -223,7 +223,7 @@ static inline int gpio_valid(int gpio)
 		return 0;
 	}
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510() && gpio < 16)
+	if (cpu_is_omap15xx() && gpio < 16)
 		return 0;
 #endif
 #if defined(CONFIG_ARCH_OMAP16XX)
@@ -879,7 +879,7 @@ static int __init _omap_gpio_init(void)
 
 	initialized = 1;
 
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		gpio_ick = clk_get(NULL, "arm_gpio_ck");
 		if (IS_ERR(gpio_ick))
 			printk("Could not get arm_gpio_ck\n");
@@ -900,7 +900,7 @@ static int __init _omap_gpio_init(void)
 	}
 
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		printk(KERN_INFO "OMAP1510 GPIO hardware\n");
 		gpio_bank_count = 2;
 		gpio_bank = gpio_bank_1510;
diff -pNaur linux-omap-2.6.orig/arch/arm/plat-omap/mcbsp.c linux-omap-2.6/arch/arm/plat-omap/mcbsp.c
--- linux-omap-2.6.orig/arch/arm/plat-omap/mcbsp.c	2006-01-14 15:58:57.000000000 +0100
+++ linux-omap-2.6/arch/arm/plat-omap/mcbsp.c	2006-01-16 05:37:51.000000000 +0100
@@ -184,7 +184,7 @@ static int omap_mcbsp_check(unsigned int
 		return 0;
 	}
 
-	if (cpu_is_omap1510() || cpu_is_omap16xx() || cpu_is_omap24xx()) {
+	if (cpu_is_omap15xx() || cpu_is_omap16xx() || cpu_is_omap24xx()) {
 		if (id > OMAP_MAX_MCBSP_COUNT) {
 			printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n", id + 1);
 			return -1;
@@ -198,7 +198,7 @@ static int omap_mcbsp_check(unsigned int
 #ifdef CONFIG_ARCH_OMAP1
 static void omap_mcbsp_dsp_request(void)
 {
-	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
+	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
 		omap_dsp_request_mem();
 		clk_enable(mcbsp_dsp_ck);
 		clk_enable(mcbsp_api_ck);
@@ -217,7 +217,7 @@ static void omap_mcbsp_dsp_request(void)
 
 static void omap_mcbsp_dsp_free(void)
 {
-	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
+	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
 		omap_dsp_release_mem();
 		clk_disable(mcbsp_dspxor_ck);
 		clk_disable(mcbsp_dsp_ck);
@@ -833,7 +833,7 @@ static int __init omap_mcbsp_init(void)
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		mcbsp_info = mcbsp_1510;
 		mcbsp_count = ARRAY_SIZE(mcbsp_1510);
 	}
diff -pNaur linux-omap-2.6.orig/drivers/video/omap/lcd_palmte.c linux-omap-2.6/drivers/video/omap/lcd_palmte.c
--- linux-omap-2.6.orig/drivers/video/omap/lcd_palmte.c	2006-01-14 15:59:39.000000000 +0100
+++ linux-omap-2.6/drivers/video/omap/lcd_palmte.c	2006-01-16 05:37:51.000000000 +0100
@@ -24,9 +24,9 @@
 #include <linux/module.h>
 
 #include <asm/io.h>
-#include <asm/arch/fpga.h>
 
-#include "omapfb.h"
+#include <asm/arch/fpga.h>
+#include <asm/arch/omapfb.h>
 
 /* #define OMAPFB_DBG 1 */
 
@@ -67,11 +67,11 @@ struct lcd_panel palmte_panel = {
 	.name		= "palmte",
 	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
 			  OMAP_LCDC_INV_HSYNC | OMAP_LCDC_HSVS_RISING_EDGE |
-			  OMAP_LCDC_HSVS_OPPOSITE;
+			  OMAP_LCDC_HSVS_OPPOSITE,
 
 	.data_lines	= 16,
 	.bpp		= 8,
-	.pixel_clock	= 12500,
+	.pixel_clock	= 12000,
 	.x_res		= 320,
 	.y_res		= 320,
 	.hsw		= 4,
@@ -80,7 +80,7 @@ struct lcd_panel palmte_panel = {
 	.vsw		= 1,
 	.vfp		= 8,
 	.vbp		= 7,
-	.pcd		= 5,
+	.pcd		= 0,
 
 	.init		= palmte_panel_init,
 	.cleanup	= palmte_panel_cleanup,
diff -pNaur linux-omap-2.6.orig/include/asm-arm/arch-omap/clock.h linux-omap-2.6/include/asm-arm/arch-omap/clock.h
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/clock.h	2006-01-14 15:59:47.000000000 +0100
+++ linux-omap-2.6/include/asm-arm/arch-omap/clock.h	2006-01-16 05:37:51.000000000 +0100
@@ -80,10 +80,11 @@ extern void clk_deny_idle(struct clk *cl
 #define CM_PLL_SEL1		(1 << 18)
 #define CM_PLL_SEL2		(1 << 19)
 #define CM_SYSCLKOUT_SEL1	(1 << 20)
-#define CLOCK_IN_OMAP730	(1 << 21)
-#define CLOCK_IN_OMAP1510	(1 << 22)
-#define CLOCK_IN_OMAP16XX	(1 << 23)
-#define CLOCK_IN_OMAP242X	(1 << 24)
-#define CLOCK_IN_OMAP243X	(1 << 25)
+#define CLOCK_IN_OMAP310	(1 << 21)
+#define CLOCK_IN_OMAP730	(1 << 22)
+#define CLOCK_IN_OMAP1510	(1 << 23)
+#define CLOCK_IN_OMAP16XX	(1 << 24)
+#define CLOCK_IN_OMAP242X	(1 << 25)
+#define CLOCK_IN_OMAP243X	(1 << 26)
 
 #endif
diff -pNaur linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h	2006-01-14 15:59:47.000000000 +0100
+++ linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h	2006-01-16 05:37:51.000000000 +0100
@@ -40,7 +40,7 @@
 #define OMAP24XX_MCBSP1_BASE	0x48074000
 #define OMAP24XX_MCBSP2_BASE	0x48076000
 
-#ifdef CONFIG_ARCH_OMAP16XX
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP15XX)
 
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x02










------=_Part_29734_25759083.1137453807791
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_29734_25759083.1137453807791--
