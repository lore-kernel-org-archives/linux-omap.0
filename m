From: andrzej zaborowski <balrogg@gmail.com>
Subject: [PATCH] Palm TE Touchscreen and fixes
Date: Sat, 14 Jan 2006 22:06:18 +0100
Message-ID: <fb249edb0601141306o6eb43a9o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_12239_9344829.1137272778340"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

------=_Part_12239_9344829.1137272778340
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,
I own a Palm Tungsten E PDA that is based on an OMAP310 motherboard.
There has already been some interest in running Linux on this device,
in particular Romain Goyet submitted a patch that made basic fixes
which were required for the kernel to boot and additionally included a
working driver for the LCD of OMAP310. This patch was applied around
Linux 2.6.13 and since then many changes broke the compatibility with
OMAP311 and even introduced compilation errors. I'm attaching three
patches against the todays GIT snapshot:

- The first one fixes the compilation errors and some clock issues
that made the kernel hang on boot on Palm Tungsten E. While these
changes make the kernel boot and work well with the device, and
hopefully don't affect other devices, I don't know how correct are my
ways of fixing it, as I'm completely inexperienced in kernel insides.
Note that the last hunk is for a compilation error introduced two days
ago here: http://www.kernel.org/git/?p=3Dlinux/kernel/git/tmlind/linux-omap=
-2.6.git;a=3Dcommit;h=3D89ac1ab633637032c80a5d3424120d153ff7d754
and I think today someone already proposed a different idea for
dealing with this error.

- The second patch adds support for the Touchscreen device found in
OMAP310. Again I don't know how proper is the driver, but it works and
it was written according to the documentation from Texas Instruments.
Because the DSP chipset of the OMAP310 board (called TSC2301) carries
out a big part of the task of controlling the touchscreen, in
hardware, the driver mechanism for this touchscreen is much simpler
than other OMAP touchscreens and I had to make small changes in
"omap_ts.c" which is generic for all OMAP touchscreens.

- The last patch only corrects some typos I found while browsing the source=
s.

I think the second and the third patch are 100% safe to apply, and the
first one needs to be reviewed by someone more experienced than
myself. I will appreciate any kind of critics.
Here's one detail I noticed: input from the touchscreen, with both
"tsdev" and "evdev" compiled in, doesn't stop the kernel srceensaver
from kicking in after five minutes from the bootup. Does someone know
what part of the system should notify the kernel to reset the timer?
Does it come from userspace or the device drivers?

Regards,
Andrzej Zaborowski
--
balrog 2oo6

Dear Outlook users: Please remove me from your address books
http://www.newsforge.com/article.pl?sid=3D03/08/21/143258

------=_Part_12239_9344829.1137272778340
Content-Type: application/octet-stream; name=linux-palmte-errors.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-palmte-errors.patch"

diff -Naur linux-omap-2.6.orig/arch/arm/mach-omap1/board-generic.c linux-omap-2.6/arch/arm/mach-omap1/board-generic.c
--- linux-omap-2.6.orig/arch/arm/mach-omap1/board-generic.c	2006-01-14 14:58:56.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap1/board-generic.c	2006-01-14 15:56:12.000000000 +0000
@@ -88,7 +88,7 @@
 static void __init omap_generic_init(void)
 {
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		generic_config[0].data = &generic1510_usb_config;
 	}
 #endif
diff -Naur linux-omap-2.6.orig/arch/arm/mach-omap1/clock.c linux-omap-2.6/arch/arm/mach-omap1/clock.c
--- linux-omap-2.6.orig/arch/arm/mach-omap1/clock.c	2006-01-14 14:58:56.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap1/clock.c	2006-01-14 15:56:12.000000000 +0000
@@ -673,7 +673,7 @@
 	arm_idlect1_mask = ~0;
 
 	for (clkp = onchip_clks; clkp < onchip_clks+ARRAY_SIZE(onchip_clks); clkp++) {
-		if (((*clkp)->flags &CLOCK_IN_OMAP1510) && cpu_is_omap1510()) {
+		if (((*clkp)->flags & CLOCK_IN_OMAP15XX) && cpu_is_omap15xx()) {
 			clk_register(*clkp);
 			continue;
 		}
@@ -784,7 +784,7 @@
 	clk_enable(&armxor_ck.clk);
 	clk_enable(&armtim_ck.clk); /* This should be done by timer code */
 
-	if (cpu_is_omap1510())
+	if (cpu_is_omap15xx())
 		clk_enable(&arm_gpio_ck);
 
 	return 0;
diff -Naur linux-omap-2.6.orig/arch/arm/mach-omap1/clock.h linux-omap-2.6/arch/arm/mach-omap1/clock.h
--- linux-omap-2.6.orig/arch/arm/mach-omap1/clock.h	2006-01-14 14:58:56.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap1/clock.h	2006-01-14 17:57:27.000000000 +0000
@@ -150,7 +150,7 @@
 static struct clk ck_ref = {
 	.name		= "ck_ref",
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  ALWAYS_ENABLED,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -159,7 +159,7 @@
 static struct clk ck_dpll1 = {
 	.name		= "ck_dpll1",
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  RATE_PROPAGATES | ALWAYS_ENABLED,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -182,7 +182,7 @@
 static struct clk arm_ck = {
 	.name		= "arm_ck",
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.rate_offset	= CKCTL_ARMDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
@@ -194,7 +194,7 @@
 	.clk = {
 		.name		= "armper_ck",
 		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+		.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 				  RATE_CKCTL | CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_PERCK,
@@ -209,7 +209,7 @@
 static struct clk arm_gpio_ck = {
 	.name		= "arm_gpio_ck",
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510,
+	.flags		= CLOCK_IN_OMAP15XX,
 	.enable_reg	= (void __iomem *)ARM_IDLECT2,
 	.enable_bit	= EN_GPIOCK,
 	.recalc		= &followparent_recalc,
@@ -221,7 +221,7 @@
 	.clk = {
 		.name		= "armxor_ck",
 		.parent		= &ck_ref,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+		.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 				  CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_XORPCK,
@@ -236,7 +236,7 @@
 	.clk = {
 		.name		= "armtim_ck",
 		.parent		= &ck_ref,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+		.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 				  CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_TIMCK,
@@ -251,7 +251,7 @@
 	.clk = {
 		.name		= "armwdt_ck",
 		.parent		= &ck_ref,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+		.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 				  CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_WDTCK,
@@ -279,7 +279,7 @@
 static struct clk dsp_ck = {
 	.name		= "dsp_ck",
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL,
 	.enable_reg	= (void __iomem *)ARM_CKCTL,
 	.enable_bit	= EN_DSPCK,
@@ -292,7 +292,7 @@
 static struct clk dspmmu_ck = {
 	.name		= "dspmmu_ck",
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL | ALWAYS_ENABLED,
 	.rate_offset	= CKCTL_DSPMMUDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
@@ -303,7 +303,7 @@
 static struct clk dspper_ck = {
 	.name		= "dspper_ck",
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL | VIRTUAL_IO_ADDRESS,
 	.enable_reg	= (void __iomem *)DSP_IDLECT2,
 	.enable_bit	= EN_PERCK,
@@ -317,7 +317,7 @@
 static struct clk dspxor_ck = {
 	.name		= "dspxor_ck",
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  VIRTUAL_IO_ADDRESS,
 	.enable_reg	= (void __iomem *)DSP_IDLECT2,
 	.enable_bit	= EN_XORPCK,
@@ -329,7 +329,7 @@
 static struct clk dsptim_ck = {
 	.name		= "dsptim_ck",
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  VIRTUAL_IO_ADDRESS,
 	.enable_reg	= (void __iomem *)DSP_IDLECT2,
 	.enable_bit	= EN_DSPTIMCK,
@@ -343,7 +343,7 @@
 	.clk = {
 		.name		= "tc_ck",
 		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+		.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP730 | RATE_CKCTL |
 				  RATE_PROPAGATES | ALWAYS_ENABLED |
 				  CLOCK_IDLE_CONTROL,
@@ -358,7 +358,7 @@
 static struct clk arminth_ck1510 = {
 	.name		= "arminth_ck",
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP1510 | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP15XX | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
 	/* Note: On 1510 the frequency follows TC_CK
 	 *
@@ -372,7 +372,7 @@
 	/* No-idle controlled by "tc_ck" */
 	.name		= "tibp_ck",
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP1510 | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP15XX | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -416,7 +416,7 @@
 	/* No-idle controlled by "tc_ck" */
 	.name		= "dma_ck",
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -436,7 +436,7 @@
 	.clk = {
 		.name		= "api_ck",
 		.parent		= &tc_ck.clk,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+		.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 				  CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_APICK,
@@ -451,7 +451,7 @@
 	.clk = {
 		.name		= "lb_ck",
 		.parent		= &tc_ck.clk,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IDLE_CONTROL,
+		.flags		= CLOCK_IN_OMAP15XX | CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_LBCK,
 		.recalc		= &followparent_recalc,
@@ -495,7 +495,7 @@
 	.clk = {
 		.name		= "lcd_ck",
 		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IN_OMAP1510 | RATE_CKCTL |
+		.flags		= CLOCK_IN_OMAP15XX | RATE_CKCTL |
 				  CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_LCDCK,
@@ -512,7 +512,7 @@
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | ENABLE_REG_32BIT |
+	.flags		= CLOCK_IN_OMAP15XX | ENABLE_REG_32BIT |
 			  ALWAYS_ENABLED | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
@@ -543,7 +543,7 @@
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  ENABLE_REG_32BIT | ALWAYS_ENABLED |
 			  CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
@@ -559,7 +559,7 @@
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | ENABLE_REG_32BIT |
+	.flags		= CLOCK_IN_OMAP15XX | ENABLE_REG_32BIT |
 			  ALWAYS_ENABLED | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
@@ -589,7 +589,7 @@
 	.name		= "usb_clko",
 	/* Direct from ULPD, no parent */
 	.rate		= 6000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)ULPD_CLOCK_CTRL,
 	.enable_bit	= USB_MCLK_EN_BIT,
@@ -601,7 +601,7 @@
 	.name		= "usb_hhc_ck",
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
-	.flags		= CLOCK_IN_OMAP1510 |
+	.flags		= CLOCK_IN_OMAP15XX |
 			  RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= USB_HOST_HHC_UHOST_EN,
@@ -637,7 +637,9 @@
 	.name		= "mclk",
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | RATE_FIXED,
+ 	.flags		= CLOCK_IN_OMAP15XX | RATE_FIXED,
+ 	.enable_reg	= (void __iomem *)0xfffe0834,
+ 	.enable_bit	= 6,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
 };
@@ -659,7 +661,7 @@
 	.name		= "bclk",
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | RATE_FIXED,
+	.flags		= CLOCK_IN_OMAP15XX | RATE_FIXED,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
 };
@@ -682,7 +684,7 @@
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 23,
@@ -705,7 +707,7 @@
 
 static struct clk virtual_ck_mpu = {
 	.name		= "mpu",
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP15XX | CLOCK_IN_OMAP16XX |
 			  VIRTUAL_CLOCK | ALWAYS_ENABLED,
 	.parent		= &arm_ck, /* Is smarter alias for */
 	.recalc		= &followparent_recalc,
diff -Naur linux-omap-2.6.orig/arch/arm/mach-omap1/io.c linux-omap-2.6/arch/arm/mach-omap1/io.c
--- linux-omap-2.6.orig/arch/arm/mach-omap1/io.c	2006-01-14 14:58:56.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap1/io.c	2006-01-14 15:56:12.000000000 +0000
@@ -110,7 +110,7 @@
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		iotable_init(omap1510_io_desc, ARRAY_SIZE(omap1510_io_desc));
 	}
 #endif
diff -Naur linux-omap-2.6.orig/arch/arm/mach-omap1/pm.c linux-omap-2.6/arch/arm/mach-omap1/pm.c
--- linux-omap-2.6.orig/arch/arm/mach-omap1/pm.c	2006-01-14 14:58:56.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap1/pm.c	2006-01-14 15:56:12.000000000 +0000
@@ -165,7 +165,7 @@
 	if ((use_idlect1 != ~0) || !do_sleep) {
 
 		__u32 saved_idlect1 = omap_readl(ARM_IDLECT1);
-		if (cpu_is_omap1510())
+		if (cpu_is_omap15xx())
 			use_idlect1 &= OMAP1510_BIG_SLEEP_REQUEST;
 		else
 			use_idlect1 &= OMAP1610_IDLECT1_SLEEP_VAL;
@@ -204,7 +204,7 @@
 	if (cpu_is_omap730())
 		level1_wake = OMAP_IRQ_BIT(INT_730_GPIO_BANK1) |
 			OMAP_IRQ_BIT(INT_730_IH2_IRQ);
-	else if (cpu_is_omap1510())
+	else if (cpu_is_omap15xx())
 		level1_wake = OMAP_IRQ_BIT(INT_GPIO_BANK1) |
 			OMAP_IRQ_BIT(INT_1510_IH2_IRQ);
 	else if (cpu_is_omap16xx())
@@ -218,7 +218,7 @@
 		omap_writel(~(OMAP_IRQ_BIT(INT_730_WAKE_UP_REQ) |
 				OMAP_IRQ_BIT(INT_730_MPUIO_KEYPAD)),
 				OMAP_IH2_1_MIR);
-	} else if (cpu_is_omap1510()) {
+	} else if (cpu_is_omap15xx()) {
 		level2_wake |= OMAP_IRQ_BIT(INT_KEYBOARD);
 		omap_writel(~level2_wake,  OMAP_IH2_MIR);
 	} else if (cpu_is_omap16xx()) {
@@ -283,7 +283,7 @@
 		MPUI730_SAVE(EMIFS_CONFIG);
 		MPUI730_SAVE(EMIFF_SDRAM_CONFIG);
 
-	} else if (cpu_is_omap1510()) {
+	} else if (cpu_is_omap15xx()) {
 		MPUI1510_SAVE(OMAP_IH1_MIR);
 		MPUI1510_SAVE(OMAP_IH2_MIR);
 		MPUI1510_SAVE(MPUI_CTRL);
@@ -307,7 +307,7 @@
 	ARM_SAVE(ARM_CKCTL);
 	ARM_SAVE(ARM_IDLECT1);
 	ARM_SAVE(ARM_IDLECT2);
-	if (!(cpu_is_omap1510()))
+	if (!(cpu_is_omap15xx()))
 		ARM_SAVE(ARM_IDLECT3);
 	ARM_SAVE(ARM_EWUPCT);
 	ARM_SAVE(ARM_RSTCT1);
@@ -395,7 +395,7 @@
 	 * Restore ARM state, except ARM_IDLECT1/2 which omap_cpu_suspend did
 	 */
 
-	if (!(cpu_is_omap1510()))
+	if (!(cpu_is_omap15xx()))
 		ARM_RESTORE(ARM_IDLECT3);
 	ARM_RESTORE(ARM_CKCTL);
 	ARM_RESTORE(ARM_EWUPCT);
@@ -411,7 +411,7 @@
 		MPUI730_RESTORE(OMAP_IH1_MIR);
 		MPUI730_RESTORE(OMAP_IH2_0_MIR);
 		MPUI730_RESTORE(OMAP_IH2_1_MIR);
-	} else if (cpu_is_omap1510()) {
+	} else if (cpu_is_omap15xx()) {
 		MPUI1510_RESTORE(MPUI_CTRL);
 		MPUI1510_RESTORE(MPUI_DSP_BOOT_CONFIG);
 		MPUI1510_RESTORE(MPUI_DSP_API_CONFIG);
@@ -472,7 +472,7 @@
 	ARM_SAVE(ARM_CKCTL);
 	ARM_SAVE(ARM_IDLECT1);
 	ARM_SAVE(ARM_IDLECT2);
-	if (!(cpu_is_omap1510()))
+	if (!(cpu_is_omap15xx()))
 		ARM_SAVE(ARM_IDLECT3);
 	ARM_SAVE(ARM_EWUPCT);
 	ARM_SAVE(ARM_RSTCT1);
@@ -493,7 +493,7 @@
 		MPUI730_SAVE(MPUI_DSP_API_CONFIG);
 		MPUI730_SAVE(EMIFF_SDRAM_CONFIG);
 		MPUI730_SAVE(EMIFS_CONFIG);
-	} else if (cpu_is_omap1510()) {
+	} else if (cpu_is_omap15xx()) {
 		MPUI1510_SAVE(MPUI_CTRL);
 		MPUI1510_SAVE(MPUI_DSP_STATUS);
 		MPUI1510_SAVE(MPUI_DSP_BOOT_CONFIG);
@@ -556,7 +556,7 @@
 			   MPUI730_SHOW(MPUI_DSP_API_CONFIG),
 			   MPUI730_SHOW(EMIFF_SDRAM_CONFIG),
 			   MPUI730_SHOW(EMIFS_CONFIG));
-		} else if (cpu_is_omap1510()) {
+		} else if (cpu_is_omap15xx()) {
 			my_buffer_offset += sprintf(my_base + my_buffer_offset,
 			   "MPUI1510_CTRL_REG             0x%-8x \n"
 			   "MPUI1510_DSP_STATUS_REG:      0x%-8x \n"
@@ -716,7 +716,7 @@
 						omap730_idle_loop_suspend_sz);
 		omap_sram_suspend = omap_sram_push(omap730_cpu_suspend,
 						   omap730_cpu_suspend_sz);
-	} else if (cpu_is_omap1510()) {
+	} else if (cpu_is_omap15xx()) {
 		omap_sram_idle = omap_sram_push(omap1510_idle_loop_suspend,
 						omap1510_idle_loop_suspend_sz);
 		omap_sram_suspend = omap_sram_push(omap1510_cpu_suspend,
diff -Naur linux-omap-2.6.orig/arch/arm/plat-omap/dsp/dsp_common.c linux-omap-2.6/arch/arm/plat-omap/dsp/dsp_common.c
--- linux-omap-2.6.orig/arch/arm/plat-omap/dsp/dsp_common.c	2006-01-14 14:58:57.000000000 +0000
+++ linux-omap-2.6/arch/arm/plat-omap/dsp/dsp_common.c	2006-01-14 15:56:12.000000000 +0000
@@ -260,7 +260,7 @@
 {
 	dspmem_size = 0;
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		dspmem_base = OMAP1510_DSP_BASE;
 		dspmem_size = OMAP1510_DSP_SIZE;
 		daram_base = OMAP1510_DARAM_BASE;
diff -Naur linux-omap-2.6.orig/arch/arm/plat-omap/gpio.c linux-omap-2.6/arch/arm/plat-omap/gpio.c
--- linux-omap-2.6.orig/arch/arm/plat-omap/gpio.c	2006-01-14 14:58:57.000000000 +0000
+++ linux-omap-2.6/arch/arm/plat-omap/gpio.c	2006-01-14 15:56:12.000000000 +0000
@@ -174,7 +174,7 @@
 static inline struct gpio_bank *get_gpio_bank(int gpio)
 {
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		if (OMAP_GPIO_IS_MPUIO(gpio))
 			return &gpio_bank[0];
 		return &gpio_bank[1];
@@ -223,7 +223,7 @@
 		return 0;
 	}
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510() && gpio < 16)
+	if (cpu_is_omap15xx() && gpio < 16)
 		return 0;
 #endif
 #if defined(CONFIG_ARCH_OMAP16XX)
@@ -879,7 +879,7 @@
 
 	initialized = 1;
 
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		gpio_ick = clk_get(NULL, "arm_gpio_ck");
 		if (IS_ERR(gpio_ick))
 			printk("Could not get arm_gpio_ck\n");
@@ -900,7 +900,7 @@
 	}
 
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		printk(KERN_INFO "OMAP1510 GPIO hardware\n");
 		gpio_bank_count = 2;
 		gpio_bank = gpio_bank_1510;
diff -Naur linux-omap-2.6.orig/arch/arm/plat-omap/mcbsp.c linux-omap-2.6/arch/arm/plat-omap/mcbsp.c
--- linux-omap-2.6.orig/arch/arm/plat-omap/mcbsp.c	2006-01-14 14:58:57.000000000 +0000
+++ linux-omap-2.6/arch/arm/plat-omap/mcbsp.c	2006-01-14 16:56:46.000000000 +0000
@@ -184,7 +184,7 @@
 		return 0;
 	}
 
-	if (cpu_is_omap1510() || cpu_is_omap16xx() || cpu_is_omap24xx()) {
+	if (cpu_is_omap15xx() || cpu_is_omap16xx() || cpu_is_omap24xx()) {
 		if (id > OMAP_MAX_MCBSP_COUNT) {
 			printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n", id + 1);
 			return -1;
@@ -198,7 +198,7 @@
 #ifdef CONFIG_ARCH_OMAP1
 static void omap_mcbsp_dsp_request(void)
 {
-	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
+	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
 		omap_dsp_request_mem();
 		clk_enable(mcbsp_dsp_ck);
 		clk_enable(mcbsp_api_ck);
@@ -217,7 +217,7 @@
 
 static void omap_mcbsp_dsp_free(void)
 {
-	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
+	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
 		omap_dsp_release_mem();
 		clk_disable(mcbsp_dspxor_ck);
 		clk_disable(mcbsp_dsp_ck);
@@ -833,7 +833,7 @@
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		mcbsp_info = mcbsp_1510;
 		mcbsp_count = ARRAY_SIZE(mcbsp_1510);
 	}
diff -Naur linux-omap-2.6.orig/drivers/video/omap/lcd_palmte.c linux-omap-2.6/drivers/video/omap/lcd_palmte.c
--- linux-omap-2.6.orig/drivers/video/omap/lcd_palmte.c	2006-01-14 14:59:39.000000000 +0000
+++ linux-omap-2.6/drivers/video/omap/lcd_palmte.c	2006-01-14 15:56:12.000000000 +0000
@@ -24,9 +24,9 @@
 #include <linux/module.h>
 
 #include <asm/io.h>
-#include <asm/arch/fpga.h>
 
-#include "omapfb.h"
+#include <asm/arch/fpga.h>
+#include <asm/arch/omapfb.h>
 
 /* #define OMAPFB_DBG 1 */
 
@@ -67,11 +67,11 @@
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
@@ -80,7 +80,7 @@
 	.vsw		= 1,
 	.vfp		= 8,
 	.vbp		= 7,
-	.pcd		= 5,
+	.pcd		= 0,
 
 	.init		= palmte_panel_init,
 	.cleanup	= palmte_panel_cleanup,
diff -Naur linux-omap-2.6.orig/include/asm-arm/arch-omap/clock.h linux-omap-2.6/include/asm-arm/arch-omap/clock.h
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/clock.h	2006-01-14 14:59:47.000000000 +0000
+++ linux-omap-2.6/include/asm-arm/arch-omap/clock.h	2006-01-14 15:56:12.000000000 +0000
@@ -81,7 +81,7 @@
 #define CM_PLL_SEL2		(1 << 19)
 #define CM_SYSCLKOUT_SEL1	(1 << 20)
 #define CLOCK_IN_OMAP730	(1 << 21)
-#define CLOCK_IN_OMAP1510	(1 << 22)
+#define CLOCK_IN_OMAP15XX	(1 << 22)
 #define CLOCK_IN_OMAP16XX	(1 << 23)
 #define CLOCK_IN_OMAP242X	(1 << 24)
 #define CLOCK_IN_OMAP243X	(1 << 25)
diff -Naur linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h	2006-01-14 14:59:47.000000000 +0000
+++ linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h	2006-01-14 18:05:42.000000000 +0000
@@ -40,7 +40,7 @@
 #define OMAP24XX_MCBSP1_BASE	0x48074000
 #define OMAP24XX_MCBSP2_BASE	0x48076000
 
-#ifdef CONFIG_ARCH_OMAP16XX
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP15XX)
 
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x02






























------=_Part_12239_9344829.1137272778340
Content-Type: application/octet-stream; name=linux-palmte-ts.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-palmte-ts.patch"

diff -Naur linux-omap-2.6.orig/arch/arm/mach-omap1/Kconfig linux-omap-2.6/arch/arm/mach-omap1/Kconfig
--- linux-omap-2.6.orig/arch/arm/mach-omap1/Kconfig	2006-01-14 14:58:56.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap1/Kconfig	2006-01-14 19:43:54.000000000 +0000
@@ -73,11 +73,11 @@
 	bool "Palm Tungsten E"
 	depends on ARCH_OMAP1 && ARCH_OMAP15XX
 	help
-          Support for the Palm Tungsten E PDA. Currently only the LCD panel
-          is supported. To boot the kernel, you'll need a PalmOS compatible
-          bootloader; check out http://palmtelinux.sourceforge.net for more
-          informations.
-          Say Y here if you have such a PDA, say NO otherwise.
+	  Support for the Palm Tungsten E PDA. Currently only the LCD
+	  panel with the touchscreen input are supported. To boot the
+	  kernel, you'll need a PalmOS compatible bootloader; check out
+	  http://palmtelinux.sourceforge.net for more informations.
+	  Say Y here if you have such a PDA, say N otherwise.
 
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
diff -Naur linux-omap-2.6.orig/drivers/input/touchscreen/Kconfig linux-omap-2.6/drivers/input/touchscreen/Kconfig
--- linux-omap-2.6.orig/drivers/input/touchscreen/Kconfig	2006-01-14 14:59:17.000000000 +0000
+++ linux-omap-2.6/drivers/input/touchscreen/Kconfig	2006-01-14 15:56:12.000000000 +0000
@@ -99,7 +99,8 @@
 config TOUCHSCREEN_OMAP
 	tristate "OMAP touchscreen input driver"
 	depends on INPUT && INPUT_TOUCHSCREEN && ARCH_OMAP
-	select OMAP_TSC2101
+	select OMAP_TSC2101 if MACH_OMAP_H3 || MACH_OMAP_H2
+	select OMAP_TSC2301 if MACH_OMAP_PALMTE
 	help
 	  Say Y here if you have an OMAP based board with touchscreen
 	  attached to it, e.g. OMAP Innovator, OSK, H2 or H3
diff -Naur linux-omap-2.6.orig/drivers/input/touchscreen/omap/Makefile linux-omap-2.6/drivers/input/touchscreen/omap/Makefile
--- linux-omap-2.6.orig/drivers/input/touchscreen/omap/Makefile	2006-01-14 14:59:17.000000000 +0000
+++ linux-omap-2.6/drivers/input/touchscreen/omap/Makefile	2006-01-14 15:56:12.000000000 +0000
@@ -8,5 +8,6 @@
 objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_H3) += ts_hx.o
 objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += ts_inn1510.o
 objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_OSK) += ts_osk.o
+objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_PALMTE) += ts_palmte.o
 
 omapts-objs := omap_ts.o $(objs-yy)
diff -Naur linux-omap-2.6.orig/drivers/input/touchscreen/omap/omap_ts.c linux-omap-2.6/drivers/input/touchscreen/omap/omap_ts.c
--- linux-omap-2.6.orig/drivers/input/touchscreen/omap/omap_ts.c	2006-01-14 14:59:17.000000000 +0000
+++ linux-omap-2.6/drivers/input/touchscreen/omap/omap_ts.c	2006-01-14 15:56:12.000000000 +0000
@@ -23,7 +23,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  * History:
  * 12/12/2004    Srinath Modified and intergrated code for H2 and H3
- *
+ * 13/01/2006    Added PalmTE specific code, Andrzej Zaborowski
  */
 
 #include <linux/errno.h>
@@ -55,8 +55,17 @@
 #if defined(CONFIG_MACH_OMAP_INNOVATOR) && defined(CONFIG_ARCH_OMAP15XX)
 	&innovator1510_ts,
 #endif
+#ifdef CONFIG_MACH_OMAP_PALMTE
+	&palmte_ts,
+#endif
 };
 
+#ifdef CONFIG_MACH_OMAP_PALMTE
+static int omap_ts_host_controlled = 1;
+#else
+static int omap_ts_host_controlled = 0;
+#endif
+
 static struct omap_ts_t ts_omap;
 
 static int omap_ts_read(void)
@@ -127,10 +136,38 @@
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t omap_ts_handler_host(int irq, void *dev_id,
+		struct pt_regs *regs)
+{
+	spin_lock(&ts_omap.lock);
+
+	if (!ts_omap.touched) {
+		DEBUG_TS("omap_ts_handler_host: pen down\n");
+		input_report_key(&(ts_omap.inputdevice), BTN_TOUCH, 1);
+		ts_omap.touched = 1;
+	}
+
+	omap_ts_read();
+
+	if (ts_omap.dev->penup() && ts_omap.touched) {
+		DEBUG_TS("omap_ts_handler_host: pen up\n");
+		ts_omap.touched = 0;
+		input_report_abs(&(ts_omap.inputdevice), ABS_X, 0);
+		input_report_abs(&(ts_omap.inputdevice), ABS_Y, 0);
+		input_report_abs(&(ts_omap.inputdevice), ABS_PRESSURE, 0);
+		input_sync(&(ts_omap.inputdevice));
+		input_report_key(&(ts_omap.inputdevice), BTN_TOUCH, 0);
+	}
+
+	spin_unlock(&ts_omap.lock);
+	return IRQ_HANDLED;
+}
+
 static int __init omap_ts_probe(struct platform_device *pdev)
 {
 	int i;
 	int status = -ENODEV;
+	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 
 	memset(&ts_omap, 0, sizeof(ts_omap));
 	spin_lock_init(&ts_omap.lock);
@@ -154,10 +191,15 @@
 
 	/* request irq */
 	if (ts_omap.irq != -1) {
-		if (request_irq(ts_omap.irq, omap_ts_handler, 0,
+		if (omap_ts_host_controlled)
+			irq_handler = omap_ts_handler_host;
+		else
+			irq_handler = omap_ts_handler;
+
+		if (request_irq(ts_omap.irq, irq_handler, 0,
 				OMAP_TS_NAME, &ts_omap)) {
-			printk(KERN_ERR
-	  "omap_ts.c: Could not allocate touchscreen IRQ!\n");
+			printk(KERN_ERR "omap_ts.c: Could not "
+					"allocate touchscreen IRQ!\n");
 			ts_omap.irq = -1;
 			return -EINVAL;
 		}
@@ -176,6 +218,7 @@
 	    BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
 	input_register_device(ts_omap.inputdevice);
 
+	ts_omap.touched = 0;
 	ts_omap.dev->enable();
 
 	printk("OMAP touchscreen driver initialized\n");
@@ -211,6 +254,7 @@
 {
 	/* Nothing */
 }
+
 static struct platform_driver omap_ts_driver = {
 	.probe 		= omap_ts_probe,
 	.remove 	= omap_ts_remove,
diff -Naur linux-omap-2.6.orig/drivers/input/touchscreen/omap/omap_ts.h linux-omap-2.6/drivers/input/touchscreen/omap/omap_ts.h
--- linux-omap-2.6.orig/drivers/input/touchscreen/omap/omap_ts.h	2006-01-14 14:59:17.000000000 +0000
+++ linux-omap-2.6/drivers/input/touchscreen/omap/omap_ts.h	2006-01-14 15:56:12.000000000 +0000
@@ -38,7 +38,7 @@
         void (*enable)  (void);
         void (*disable) (void);
         void (*remove)  (void);
-        int  (*penup)  (void);
+        int  (*penup)   (void);
 };
 
 struct omap_ts_t{
@@ -54,5 +54,6 @@
 extern struct ts_device hx_ts;
 extern struct ts_device osk_ts;
 extern struct ts_device innovator1510_ts;
+extern struct ts_device palmte_ts;
 
 #endif /* __OMAP_TS_H */
diff -Naur linux-omap-2.6.orig/drivers/input/touchscreen/omap/ts_palmte.c linux-omap-2.6/drivers/input/touchscreen/omap/ts_palmte.c
--- linux-omap-2.6.orig/drivers/input/touchscreen/omap/ts_palmte.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/drivers/input/touchscreen/omap/ts_palmte.c	2006-01-14 16:57:24.000000000 +0000
@@ -0,0 +1,186 @@
+/*
+ * drivers/input/touchscreen/omap/ts_palmte.c
+ *
+ * Touchscreen support for the OMAP 310 boards
+ * 
+ * Copyright (c) 2005 Andrzej Zaborowski  <balrog@zabor.org>
+ * based on the H2/H3 Touchscreen driver:
+ * Copyright (c) 2002 MontaVista Software Inc.
+ * Copyright (c) 2004 Texas Instruments, Inc.
+ * Assembled using driver code copyright the companies above.
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This package is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this package; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/input.h>
+#include <linux/device.h>
+#include <asm/mach-types.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/hardware.h>
+#include <asm/hardware/tsc2301.h>
+
+#include "../drivers/ssi/omap-tsc2301.h"
+#include "omap_ts.h"
+
+#define PALMTE_GPIO_NUM				6
+
+#define TOUCHSCREEN_DATA_REGISTERS_PAGE		0x0
+#define TOUCHSCREEN_CONTROL_REGISTERS_PAGE	0x1
+
+#define TSC2301_XRES				320
+#define TSC2301_READ_MAX			0x4
+#define TSC2301_GETSTATUS(ret)			\
+	(((ret) & 0x8000) || !((ret) & 0x4000))
+#define TSC2301_MASKVAL				0x0fff
+#define TSC2301_PRESSUREVAL(x)			((x) << 12)
+
+static int palmte_ts_penup(void);
+static int palmte_ts_probe(struct omap_ts_t *ts);
+static void palmte_ts_read(u16 *data);
+static void palmte_ts_enable(void);
+static void palmte_ts_disable(void);
+#ifdef	MODULE
+static void palmte_ts_remove(void);
+#endif
+
+struct ts_device palmte_ts = {
+	.probe 		= palmte_ts_probe,
+	.read 		= palmte_ts_read,
+	.enable 	= palmte_ts_enable,
+	.disable 	= palmte_ts_disable,
+	.remove 	= __exit_p(palmte_ts_remove),
+	.penup 		= palmte_ts_penup,
+};
+
+static int palmte_ts_penup(void)
+{
+	u16 ret;
+
+	/*
+	 * Read the ADC control register
+	 *
+	 * TODO: Instead read the DAV bit of the TSC2301_TS_CONFIG2_CTRL
+	 * register that indicates actual converted data availiable.
+	 */
+	ret = omap_tsc2301_read(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			TSC2301_TS_ADC_CTRL);
+
+	/* Check for pen status in the ADC control register */
+	ret = TSC2301_GETSTATUS(ret);
+	return !ret;
+
+}
+
+static int __init palmte_ts_probe(struct omap_ts_t *ts)
+{
+	unsigned gpio = PALMTE_GPIO_NUM;
+
+	ts->irq = OMAP_GPIO_IRQ(gpio);
+	if (omap_request_gpio(gpio) != 0) {
+		printk(KERN_ERR "palmte_ts_init.c: Could not reserve GPIO!\n");
+		return -EINVAL;
+	}
+
+	omap_set_gpio_direction(gpio, 1);
+	set_irq_type(ts->irq, IRQT_FALLING);
+	return 0;
+}
+
+static void palmte_ts_read(u16 *values)
+{
+	s32 t, p = 0;
+	int i;
+
+	/* Read X, Y, Z1 and Z2 */
+	omap_tsc2301_reads(TOUCHSCREEN_DATA_REGISTERS_PAGE, TSC2301_TS_X,
+			values, TSC2301_READ_MAX);
+
+	for (i = 0; i < TSC2301_READ_MAX; i ++)
+		values[i] &= TSC2301_MASKVAL;
+
+	/* Calculate Pressure */
+	if (values[TSC2301_TS_Z1] != 0) {
+		t = ((TSC2301_XRES * values[TSC2301_TS_X]) *
+			(values[TSC2301_TS_Z2] - values[TSC2301_TS_Z1]));
+		p = t / (u32) (TSC2301_PRESSUREVAL(values[TSC2301_TS_Z1]));
+		if (p < 0)
+			p = 0;
+	}
+
+	values[TSC2301_TS_Z1] = p;
+}
+
+static void palmte_ts_enable(void)
+{
+	int ret = omap_tsc2301_enable();
+	if (ret) {
+		printk(KERN_ERR "TSC2301 Codec initialization failed!\n");
+		return;
+	}
+
+	/* Stop all conversions */
+	omap_tsc2301_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			TSC2301_TS_ADC_CTRL,
+			TSC2301_ADC_POWERDOWN | TSC2301_ADC_CONTROL);
+
+	/*
+	 * Use internal reference, 100 usec power-up delay,
+	 * power down between conversions, 1.25V internal reference
+	 */
+	omap_tsc2301_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			TSC2301_TS_REF_CTRL, TSC2301_REF_POWERUP);
+
+	/* Set an 84usec precharge time and 32 usec sense time */
+	omap_tsc2301_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			TSC2301_TS_CONFIG_CTRL, TSC2301_CONFIG_TIMES);
+
+	omap_tsc2301_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			TSC2301_TS_CONFIG2_CTRL, TSC2301_CONFIG_TIMES);
+
+	/*
+	 * Set the TSC controlled mode and slowest rates, this is
+	 * in order to work around the hardware bug documented here:
+	 * http://focus.ti.com/lit/er/slaz003/slaz003.pdf
+	 */
+	omap_tsc2301_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			TSC2301_TS_ADC_CTRL, TSC2301_ADC_SLOW);
+
+	/*
+	 * TSC2301-controlled conversions,
+	 * Continuous X, Y, Z1, Z2 scan mode,
+	 * 12-bit samples,
+	 * Average (mean) 4 samples per coordinate,
+	 * 1 MHz internal conversion clock,
+	 * 500 usec panel voltage stabilization delay
+	 */
+	omap_tsc2301_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			TSC2301_TS_ADC_CTRL, TSC2301_ADC_CONTROL);
+}
+
+static void palmte_ts_disable(void)
+{
+	/* Stop conversions and power down */
+	omap_tsc2301_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			TSC2301_TS_ADC_CTRL, TSC2301_ADC_POWERDOWN);
+	omap_tsc2301_disable();
+}
+
+#ifdef	MODULE
+static void __exit palmte_ts_remove(void)
+{
+	omap_free_gpio(PALMTE_GPIO_NUM);
+}
+#endif
diff -Naur linux-omap-2.6.orig/drivers/ssi/Kconfig linux-omap-2.6/drivers/ssi/Kconfig
--- linux-omap-2.6.orig/drivers/ssi/Kconfig	2006-01-14 14:59:35.000000000 +0000
+++ linux-omap-2.6/drivers/ssi/Kconfig	2006-01-14 15:56:12.000000000 +0000
@@ -15,4 +15,12 @@
 	---help---
 	  Say Y here if you want support for the TSC2101 codec.  It is
 	  needed for touchscreen and audio on OMAP1610 and 1710.
+
+config OMAP_TSC2301
+	depends on ARCH_OMAP1 || ARCH_OMAP15XX
+	tristate "TSC2301 codec support for Touchscreen"
+	select OMAP_UWIRE if MACH_OMAP_PALMTE
+	---help---
+	  Say Y here if you want support for the TSC2301 codec.  It is
+	  needed for the touchscreen driver for OMAP310 and 311.
 endmenu
diff -Naur linux-omap-2.6.orig/drivers/ssi/Makefile linux-omap-2.6/drivers/ssi/Makefile
--- linux-omap-2.6.orig/drivers/ssi/Makefile	2006-01-14 14:59:35.000000000 +0000
+++ linux-omap-2.6/drivers/ssi/Makefile	2006-01-14 15:56:12.000000000 +0000
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_OMAP_UWIRE)        += omap-uwire.o
 obj-$(CONFIG_OMAP_TSC2101)      += omap-tsc2101.o
+obj-$(CONFIG_OMAP_TSC2301)      += omap-tsc2301.o
diff -Naur linux-omap-2.6.orig/drivers/ssi/omap-tsc2301.c linux-omap-2.6/drivers/ssi/omap-tsc2301.c
--- linux-omap-2.6.orig/drivers/ssi/omap-tsc2301.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/drivers/ssi/omap-tsc2301.c	2006-01-14 15:56:12.000000000 +0000
@@ -0,0 +1,184 @@
+/*
+ * drivers/ssi/omap-tsc2301.c
+ *
+ * TSC2301 codec interface driver for the OMAP platform
+ *
+ * Copyright (c) 2005 Andrzej Zaborowski  <balrog@zabor.org>
+ * based on the TSC2101 codec interface driver:
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This package is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this package; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/mach-types.h>
+#include <asm/hardware.h>
+#include <asm/hardware/clock.h>
+
+#include <asm/arch/mux.h>
+#include <asm/arch/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/hardware/tsc2301.h>
+
+#include "omap-tsc2301.h"
+
+#if CONFIG_ARCH_OMAP15XX
+#include <../drivers/ssi/omap-uwire.h>
+#else
+#error "Unsupported configuration"
+#endif
+
+#define SPIO			1
+
+static int count;
+static spinlock_t tsc2301_lock = SPIN_LOCK_UNLOCKED;
+static struct clk *tsc2301_mclk_ck;
+
+static int omap_tsc2301_configure(void);
+
+#define PALMTE_TSC2301_CS	0	/* As opposed to 3 */
+#define CLK_SOFT_REQ_REG_BASE	(0xfffe0800 | 0x34)
+#define SOFT_COM_MCK0_REQ_MASK	(0x1 << 6)
+
+int omap_tsc2301_enable(void)
+{
+	int ret = 0;
+
+	spin_lock(&tsc2301_lock);
+	if (count ++ == 0) {
+		int ret = 0;
+
+		/* Get the MCLK - assuming the rate is at 12000000 */
+		tsc2301_mclk_ck = clk_get(0, "mclk");
+		if (tsc2301_mclk_ck == 0) {
+			printk(KERN_ERR "Unable to get the clock MCLK!!!\n");
+			ret = -EPERM;
+			goto done;
+		}
+
+		clk_enable(tsc2301_mclk_ck);
+
+		ret = omap_tsc2301_configure();
+
+		/* Lock the module */
+		if (!ret && !try_module_get(THIS_MODULE)) {
+			printk(KERN_CRIT "Failed to get TSC module\n");
+			ret = -ESTALE;
+		}
+	}
+
+done:
+	spin_unlock(&tsc2301_lock);
+	return ret;
+}
+
+void omap_tsc2301_disable(void)
+{
+	spin_lock(&tsc2301_lock);
+	if (-- count == 0) {
+		/* Release the MCLK */
+		clk_disable(tsc2301_mclk_ck);
+		clk_put(tsc2301_mclk_ck);
+		tsc2301_mclk_ck = NULL;
+
+		module_put(THIS_MODULE);
+	}
+	spin_unlock(&tsc2301_lock);
+}
+
+void omap_tsc2301_write(int page, u8 address, u16 data)
+{
+
+	int ret = 0;
+	int cs = 0;
+	if (machine_is_omap_palmte())
+		cs = PALMTE_TSC2301_CS;
+
+	/* Address */
+	ret = omap_uwire_data_transfer(cs,
+			(((page) << 11) | (address << 5)), 16,
+			0, NULL, 1);
+	if (ret) {
+		printk(KERN_ERR "uwire-write returned error for address %x\n",
+				address);
+		return;
+	}
+
+	/* Data */
+	ret = omap_uwire_data_transfer(cs, data, 16, 0, NULL, 0);
+	if (ret) {
+		printk(KERN_ERR "uwire-write returned error for address %x\n",
+				address);
+		return;
+	}
+}
+
+void omap_tsc2301_reads(int page, u8 startaddress, u16 *data, int numregs)
+{
+	int cs = 0, i;
+	if (machine_is_omap_palmte())
+		cs = PALMTE_TSC2301_CS;
+
+	/* Address */
+	(void) omap_uwire_data_transfer(cs, 0x8000 | (page << 11) |
+			(startaddress << 5), 16, 0, NULL, 1);
+
+	/* Data */
+	for (i = 0; i < (numregs - 1); i ++, data ++)
+		omap_uwire_data_transfer(cs, 0, 0, 16, data, 1);
+
+	omap_uwire_data_transfer(cs, 0, 0, 16, data, 0);
+}
+
+u16 omap_tsc2301_read(int page, u8 address)
+{
+	u16 ret;
+	omap_tsc2301_reads(page, address, &ret, 1);
+	return ret;
+}
+
+/* FIXME: adapt clock divisors for uwire to current ARM xor clock rate */
+static int omap_tsc2301_configure(void)
+{
+	unsigned long uwire_flags = 0;
+
+	if (machine_is_omap_palmte()) {
+		uwire_flags = UWIRE_READ_RISING_EDGE | UWIRE_WRITE_RISING_EDGE;
+		omap_uwire_configure_mode(PALMTE_TSC2301_CS, uwire_flags);
+	}
+
+	/* Configure MCLK enable */
+	omap_writel(omap_readl(PU_PD_SEL_2) | (1 << 22), PU_PD_SEL_2);	
+
+	return 0;
+}
+
+EXPORT_SYMBOL(omap_tsc2301_enable);
+EXPORT_SYMBOL(omap_tsc2301_read);
+EXPORT_SYMBOL(omap_tsc2301_reads);
+EXPORT_SYMBOL(omap_tsc2301_write);
+EXPORT_SYMBOL(omap_tsc2301_disable);
+
+MODULE_AUTHOR("Andrzej Zaborowski");
+MODULE_DESCRIPTION("Interface driver for TI TSC2301 chips.");
+MODULE_LICENSE("GPL");
diff -Naur linux-omap-2.6.orig/drivers/ssi/omap-tsc2301.h linux-omap-2.6/drivers/ssi/omap-tsc2301.h
--- linux-omap-2.6.orig/drivers/ssi/omap-tsc2301.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/drivers/ssi/omap-tsc2301.h	2006-01-14 15:56:12.000000000 +0000
@@ -0,0 +1,36 @@
+/*
+ * drivers/ssi/omap-tsc2301.h
+ *
+ * TSC2301 codec interface driver for the OMAP platform
+ *
+ * Copyright (c) 2005 Andrzej Zaborowski  <balrog@zabor.org>
+ * based on the TSC2101 codec interface driver:
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This package is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this package; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __OMAP_TSC2301_H
+#define __OMAP_TSC2301_H
+
+extern u16 omap_tsc2301_read(int page, u8 address);
+extern void omap_tsc2301_reads(int page, u8 startaddress, u16 *data,
+		int numregs);
+extern void omap_tsc2301_write(int page, u8 address, u16 data);
+
+extern void omap_tsc2301_disable(void);
+extern int omap_tsc2301_enable(void);
+
+#endif /* __OMAP_TSC2301_H */
diff -Naur linux-omap-2.6.orig/include/asm-arm/hardware/tsc2301.h linux-omap-2.6/include/asm-arm/hardware/tsc2301.h
--- linux-omap-2.6.orig/include/asm-arm/hardware/tsc2301.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/include/asm-arm/hardware/tsc2301.h	2006-01-14 15:56:12.000000000 +0000
@@ -0,0 +1,116 @@
+/*
+ * include/asm-arm/hardware/tsc2301.h
+ *
+ * TI TSC2301 Touchscreen, Audio and Battery control register definitions 
+ *
+ * Copyright (c) 2005 Andrzej Zaborowski  <balrog@zabor.org>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This package is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this package; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __ASM_HARDWARE_TSC2301_H
+#define __ASM_HARDWARE_TSC2301_H
+
+/* Page 0, Touch Screen & Keypad Data registers */
+#define TSC2301_TS_X			0x00
+#define TSC2301_TS_Y			0x01
+#define TSC2301_TS_Z1			0x02
+#define TSC2301_TS_Z2			0x03
+#define TSC2301_TS_KPDATA		0x04
+#define TSC2301_TS_BAT1			0x05
+#define TSC2301_TS_BAT2			0x06
+#define TSC2301_TS_AUX1			0x07
+#define TSC2301_TS_AUX2			0x08
+#define TSC2301_TS_TEMP1		0x09
+#define TSC2301_TS_TEMP2		0x0a
+#define TSC2301_TS_DAC			0x0b
+
+/* Page 1, Touch Screen & Keypad Control registers */
+#define TSC2301_TS_ADC_CTRL		0x00
+#define TSC2301_TS_KEY_CTRL		0x01
+#define TSC2301_TS_DAC_CTRL		0x02
+#define TSC2301_TS_REF_CTRL		0x03
+#define TSC2301_TS_RESET_CTRL		0x04
+#define TSC2301_TS_CONFIG_CTRL		0x05
+#define TSC2301_TS_CONFIG2_CTRL		0x06
+#define TSC2301_TS_KPMASK		0x10
+
+/* Page 2, Audio Control registers */
+#define TSC2301_AUDIO_CTRL		0x00
+#define TSC2301_ADC_GAIN_CTRL		0x01
+#define TSC2301_DAC_GAIN_CTRL		0x02
+#define TSC2301_ANALOG_GAIN_CTRL	0x03
+#define TSC2301_KEYCLICK_CTRL		0x04
+#define TSC2301_AUDIO_POWER_CTRL	0x05
+#define TSC2301_GPIO			0x06
+#define TSC2301_LCH_BASS_BOOST_N0	0x07
+#define TSC2301_LCH_BASS_BOOST_N1	0x08
+#define TSC2301_LCH_BASS_BOOST_N2	0x09
+#define TSC2301_LCH_BASS_BOOST_N3	0x0a
+#define TSC2301_LCH_BASS_BOOST_N4	0x0b
+#define TSC2301_LCH_BASS_BOOST_N5	0x0c
+#define TSC2301_LCH_BASS_BOOST_D1	0x0d
+#define TSC2301_LCH_BASS_BOOST_D2	0x0e
+#define TSC2301_LCH_BASS_BOOST_D4	0x0f
+#define TSC2301_LCH_BASS_BOOST_D5	0x10
+#define TSC2301_RCH_BASS_BOOST_N0	0x11
+#define TSC2301_RCH_BASS_BOOST_N1	0x12
+#define TSC2301_RCH_BASS_BOOST_N2	0x13
+#define TSC2301_RCH_BASS_BOOST_N3	0x14
+#define TSC2301_RCH_BASS_BOOST_N4	0x15
+#define TSC2301_RCH_BASS_BOOST_N5	0x16
+#define TSC2301_RCH_BASS_BOOST_D1	0x17
+#define TSC2301_RCH_BASS_BOOST_D2	0x18
+#define TSC2301_RCH_BASS_BOOST_D4	0x19
+#define TSC2301_RCH_BASS_BOOST_D5	0x1a
+
+/* Bit field definitions for TS Control */
+#define TSC2301_ADC_CONTROL		0x8874
+#define TSC2301_ADC_POWERDOWN		0x4000
+#define TSC2301_ADC_SLOW		0x07ff
+#define TSC2301_REF_POWERUP		0x0014
+#define TSC2301_CONFIG_TIMES		0x0008
+
+/* Bit position */
+#define TSC2301_BIT(ARG)		(0x01 << (ARG))
+
+/* Field masks for Audio Control */
+#define TSC2301_AC_ADCHPF(ARG)		(((ARG) & 0x03) << 14)
+#define TSC2301_AC_WLEN(ARG)		(((ARG) & 0x03) << 10)
+#define TSC2301_AC_DATFM(ARG)		(((ARG) & 0x03) << 8)
+#define TSC2301_AC_DACFS(ARG)		(((ARG) & 0x07) << 3)
+#define TSC2301_AC_ADCFS(ARG)		(((ARG) & 0x07))
+
+/* Field masks for TSC2301_DAC_GAIN_CTRL */
+#define TSC2301_DGC_DALMU		TSC2301_BIT(15)
+#define TSC2301_DGC_DALVL(ARG)		(((ARG) & 0x7F) << 8)
+#define TSC2301_DGC_DARMU		TSC2301_BIT(7)
+#define TSC2301_DGC_DARVL(ARG)		(((ARG) & 0x7F))
+
+/* Field masks settings for TSC2301_GPIO_CTRL */
+#define TSC2301_DIR5			TSC2301_BIT(13)
+#define TSC2301_DIR4			TSC2301_BIT(12)
+#define TSC2301_DIR3			TSC2301_BIT(11)
+#define TSC2301_DIR2			TSC2301_BIT(10)
+#define TSC2301_DIR1			TSC2301_BIT(9)
+#define TSC2301_DIR0			TSC2301_BIT(8)
+#define TSC2301_GPIO5			TSC2301_BIT(5)
+#define TSC2301_GPIO4			TSC2301_BIT(4)
+#define TSC2301_GPIO3			TSC2301_BIT(3)
+#define TSC2301_GPIO2			TSC2301_BIT(2)
+#define TSC2301_GPIO1			TSC2301_BIT(1)
+#define TSC2301_GPIO0			TSC2301_BIT(0)
+
+#endif	/* __ASM_HARDWARE_TSC2301_H */





























------=_Part_12239_9344829.1137272778340
Content-Type: application/octet-stream; name=linux-typos.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-typos.patch"

diff -Naur linux-omap-2.6.orig/Documentation/arm/Booting linux-omap-2.6/Documentation/arm/Booting
--- linux-omap-2.6.orig/Documentation/arm/Booting	2006-01-14 14:58:51.000000000 +0000
+++ linux-omap-2.6/Documentation/arm/Booting	2006-01-14 15:56:12.000000000 +0000
@@ -118,7 +118,7 @@
 
 In either case, the following conditions must be met:
 
-- Quiesce all DMA capable devicess so that memory does not get
+- Quiesce all DMA capable devices so that memory does not get
   corrupted by bogus network packets or disk data. This will save
   you many hours of debug.
 
diff -Naur linux-omap-2.6.orig/Documentation/arm/README linux-omap-2.6/Documentation/arm/README
--- linux-omap-2.6.orig/Documentation/arm/README	2006-01-14 14:58:51.000000000 +0000
+++ linux-omap-2.6/Documentation/arm/README	2006-01-14 15:56:12.000000000 +0000
@@ -89,7 +89,7 @@
   Although modularisation is supported (and required for the FP emulator),
   each module on an ARM2/ARM250/ARM3 machine when is loaded will take
   memory up to the next 32k boundary due to the size of the pages.
-  Therefore, modularisation on these machines really worth it?
+  Therefore, is modularisation on these machines really worth it?
 
   However, ARM6 and up machines allow modules to take multiples of 4k, and
   as such Acorn RiscPCs and other architectures using these processors can
diff -Naur linux-omap-2.6.orig/Documentation/arm/Setup linux-omap-2.6/Documentation/arm/Setup
--- linux-omap-2.6.orig/Documentation/arm/Setup	2006-01-14 14:58:51.000000000 +0000
+++ linux-omap-2.6/Documentation/arm/Setup	2006-01-14 15:56:12.000000000 +0000
@@ -58,7 +58,7 @@
  video_y
 
    This describes the character position of cursor on VGA console, and
-   is otherwise unused. (should not used for other console types, and
+   is otherwise unused. (should not be used for other console types, and
    should not be used for other purposes).
 
  memc_control_reg
diff -Naur linux-omap-2.6.orig/include/linux/timer.h linux-omap-2.6/include/linux/timer.h
--- linux-omap-2.6.orig/include/linux/timer.h	2006-01-14 15:00:00.000000000 +0000
+++ linux-omap-2.6/include/linux/timer.h	2006-01-14 15:56:12.000000000 +0000
@@ -69,13 +69,13 @@
  * @timer: the timer to be added
  *
  * The kernel will do a ->function(->data) callback from the
- * timer interrupt at the ->expired point in the future. The
+ * timer interrupt at the ->expires point in the future. The
  * current time is 'jiffies'.
  *
- * The timer's ->expired, ->function (and if the handler uses it, ->data)
+ * The timer's ->expires, ->function (and if the handler uses it, ->data)
  * fields must be set prior calling this function.
  *
- * Timers with an ->expired field in the past will be executed in the next
+ * Timers with an ->expires field in the past will be executed in the next
  * timer tick.
  */
 static inline void add_timer(struct timer_list *timer)




























------=_Part_12239_9344829.1137272778340
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_12239_9344829.1137272778340--
