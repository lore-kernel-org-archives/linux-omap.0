From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3v4] Runtime check for OMAP35x
Date: Mon, 26 Jan 2009 17:08:36 -0800
Message-ID: <20090127010835.GC15757@atomide.com>
References: <1232120769-7569-1-git-send-email-premi@ti.com> <87mydmn9z3.fsf@deeprootsystems.com> <B85A65D85D7EB246BE421B3FB0FBB59301C69A03AD@dbde02.ent.ti.com> <87ljt66lal.fsf@deeprootsystems.com> <B85A65D85D7EB246BE421B3FB0FBB59301C69A054A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65070 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbZA0BIk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2009 20:08:40 -0500
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301C69A054A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Premi, Sanjeev <premi@ti.com> [090120 08:42]:
> 
> > -----Original Message-----
> > From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> > Sent: Tuesday, January 20, 2009 9:07 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 2/3v4] Runtime check for OMAP35x
> > 
> > "Premi, Sanjeev" <premi@ti.com> writes:
> > 
> > > <snip>--<snip>
> > >
> > >> > +#ifdef CONFIG_ARCH_OMAP35XX
> > >> > +static struct omap_globals omap35xx_globals = {
> > >> > +	.class	= OMAP35XX_CLASS,
> > >> > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
> > >> > +	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
> > >> > +	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
> > >> > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
> > >> > +	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
> > >> > +	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
> > >> > +};
> > >> 
> > >> This is exactly the same as omap34xx_globals.  Why is this needed?
> > >
> > 
> > > [sp] I have tried to add minimal support for OMAP35x. Since OMAP34x 
> > > and OMAP35x seem to be compatible today, this structure 
> > seems same. As 
> > > more code for specific OMAP35x variants comes in, I expect this to 
> > > change.
> > >
> > > The key difference here (as against OMAP34x) is use of 
> > OMAP35XX_CLASS; 
> > > which helps in identifying the different OMAP variants. We 
> > could have 
> > > 're-used' OMAP35XX_CLASS, it I wouldn't be right as this 
> > definition is 
> > > used to print the CPU name and Si version in id.c.
> > >
> > > With this patch, boot log with show (for example) "OMAP3530 ES2.1"
> > > on the OMAP3530 EVM - which can be considered same as 
> > OMAP3430 ES2.1; 
> > > but with 3503, 3515 and 3525 the print would read 3403, 3415,
> > > 3425 resp; this definitley would not be right.
> > 
> > I was not asking about the patch as a whole, I was commenting 
> > only on the addition of the omap35xx_globals variable.  You 
> > added a new struct which is exactly the same as the 35xx 
> > struct instead of just re-using the old one with a new name 
> > as I suggested.
> > 
> > Kevin
> 
> [sp] This would mean adding another #ifdef to get the right _CLASS. From earlier discussion, I understood that we wanted to remove #ifdefs so that same image can work for OMAP35x and OMAP34x.

Well the 34xx and 35xx are pretty much the same except for some
onboard features. How about the attached patch instead?

As an extra bonus it prints out the onboard coprocessors :)

This is what I'm getting on my omap3430sdp:

OMAP3430 ES2.0 (full speed SGX, IVA2)

And this is what I'm getting on my overo:

OMAP3503 ES2.1 (no SGX, no IVA2)

I'll update it to detect between 3410, 3420 and 3430, but meanwhile
some testing on various 35xx processors would be appreciated.

Regards,

Tony

--Q68bSM7Ycu6FN28Q
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="35xx-rev.patch"

>From 11c30c03a544a16c44ad5f0fbe682e251e76ee0e Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 26 Jan 2009 10:43:52 -0800
Subject: [PATCH] ARM: OMAP3: Add detection for 35xx

Add detection for 35xx and print info about the onboard coprocessors.

Some parts of the 35xx detection based on an earlier patch by
Sanjeev Premi <premi@ti.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index fe97bab..2e9691a 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -370,7 +370,7 @@ static void __init omap3_beagle_init(void)
 
 static void __init omap3_beagle_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_35xx();
 	omap2_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 9995ac2..b0af6f3 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -282,7 +282,7 @@ static void __init overo_init(void)
 
 static void __init overo_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_35xx();
 	omap2_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 7cd1b2e..c8c4703 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -69,6 +69,12 @@ EXPORT_SYMBOL(omap_type);
 
 /*----------------------------------------------------------------------------*/
 
+#define FEAT_OMAP3503	((OMAP343X_SGX_NONE << OMAP343X_FEATURE_SGX_SHIFT) | \
+				OMAP343X_FEATURE_IVA2_HW_NONE)
+#define FEAT_OMAP3515	OMAP343X_FEATURE_IVA2_HW_NONE
+#define FEAT_OMAP3525	(OMAP343X_SGX_NONE << OMAP343X_FEATURE_SGX_SHIFT)
+#define FEAT_OMAP3530	0
+
 #define OMAP_TAP_IDCODE		0x0204
 #define OMAP_TAP_DIE_ID_0	0x0218
 #define OMAP_TAP_DIE_ID_1	0x021C
@@ -152,12 +158,126 @@ void __init omap24xx_check_revision(void)
 	pr_info("\n");
 }
 
-void __init omap34xx_check_revision(void)
+static u32 __init omap34xx_get_features(char *feat_name)
+{
+	u32 features, module;
+
+	features = omap_ctrl_readl(OMAP343X_CONTROL_FEATURE_OMAP_STATUS) &
+				(OMAP343X_FEATURE_SGX_MASK |
+					OMAP343X_FEATURE_IVA2_HW_NONE);
+
+	module = (features & OMAP343X_FEATURE_SGX_MASK) >>
+					OMAP343X_FEATURE_SGX_SHIFT;
+	switch (module) {
+	case OMAP343X_SGX_FULL:
+		strcat(feat_name, "full speed SGX, ");
+		break;
+	case OMAP343X_SGX_HALF:
+		strcat(feat_name, "half speed SGX, ");
+		break;
+	case OMAP343X_SGX_NONE:
+		strcat(feat_name, "no SGX, ");
+		break;
+	default:
+		strcat(feat_name, "unknown SGX, ");
+		break;
+	}
+
+	module = features & OMAP343X_FEATURE_IVA2_HW_NONE;
+	switch (module) {
+	case 0:
+		strcat(feat_name, "IVA2");
+		break;
+	case OMAP343X_FEATURE_IVA2_HW_NONE:
+		strcat(feat_name, "no IVA2");
+		break;
+	default:
+		break;
+	}
+
+	return features;
+}
+
+static void __init omap34xx_set_revision(u8 rev, char *rev_name, char *features)
+{
+	u32 coprocessors;
+
+	coprocessors = omap34xx_get_features(features);
+
+	switch (rev) {
+	case 0:
+		omap_revision = OMAP3430_REV_ES2_0;
+		strcat(rev_name, "ES2.0");
+		break;
+	case 2:
+		omap_revision = OMAP3430_REV_ES2_1;
+		strcat(rev_name, "ES2.1");
+		break;
+	case 3:
+		omap_revision = OMAP3430_REV_ES3_0;
+		strcat(rev_name, "ES3.0");
+		break;
+	case 4:
+		omap_revision = OMAP3430_REV_ES3_1;
+		strcat(rev_name, "ES3.1");
+		break;
+	default:
+		/* Use the latest known revision as default */
+		omap_revision = OMAP3430_REV_ES3_1;
+		strcat(rev_name, "Unknown revision");
+	}
+}
+
+static void __init omap35xx_set_revision(u8 rev, char *rev_name, char *features)
+{
+	u32 coprocessors;
+
+	/* Get the subrevision based on the onboard coprocessors */
+	coprocessors = omap34xx_get_features(features);
+	switch (coprocessors) {
+	case FEAT_OMAP3503:
+		omap_revision |= OMAP3503_MASK;
+		break;
+	case FEAT_OMAP3515:
+		omap_revision |= OMAP3515_MASK;
+		break;
+	case FEAT_OMAP3525:
+		omap_revision |= OMAP3525_MASK;
+		break;
+	case FEAT_OMAP3530:
+		omap_revision |= OMAP3530_MASK;
+		break;
+	default:
+		break;
+	}
+
+	/* Get the silicon revision */
+	switch (rev) {
+	case 1:
+		omap_revision |= OMAP35XX_MASK_ES2_0;
+		strcat(rev_name, "ES2.0");
+		break;
+	case 2:
+		omap_revision |= OMAP35XX_MASK_ES2_1;
+		strcat(rev_name, "ES2.1");
+		break;
+	case 3:
+		omap_revision |= OMAP35XX_MASK_ES3_0;
+		strcat(rev_name, "ES3.0");
+		break;
+	default:
+		/* Use the latest known revision as default */
+		omap_revision |= OMAP35XX_MASK_ES3_0;
+		strcat(rev_name, "Unknown revision");
+	}
+}
+
+static void __init omap34xx_check_revision(void)
 {
 	u32 cpuid, idcode;
 	u16 hawkeye;
 	u8 rev;
-	char *rev_name = "ES1.0";
+	char rev_name[32] = "", feat_name[32] = "";
 
 	/*
 	 * We cannot access revision registers on ES1.0.
@@ -181,32 +301,14 @@ void __init omap34xx_check_revision(void)
 	rev = (idcode >> 28) & 0xff;
 
 	if (hawkeye == 0xb7ae) {
-		switch (rev) {
-		case 0:
-			omap_revision = OMAP3430_REV_ES2_0;
-			rev_name = "ES2.0";
-			break;
-		case 2:
-			omap_revision = OMAP3430_REV_ES2_1;
-			rev_name = "ES2.1";
-			break;
-		case 3:
-			omap_revision = OMAP3430_REV_ES3_0;
-			rev_name = "ES3.0";
-			break;
-		case 4:
-			omap_revision = OMAP3430_REV_ES3_1;
-			rev_name = "ES3.1";
-			break;
-		default:
-			/* Use the latest known revision as default */
-			omap_revision = OMAP3430_REV_ES3_1;
-			rev_name = "Unknown revision\n";
-		}
+		if (cpu_is_omap35xx())
+			omap35xx_set_revision(rev, rev_name, feat_name);
+		else
+			omap34xx_set_revision(rev, rev_name, feat_name);
 	}
 
 out:
-	pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
+	pr_info("OMAP%04x %s (%s)\n", omap_rev() >> 16, rev_name, feat_name);
 }
 
 /*
@@ -241,6 +343,10 @@ void __init omap2_check_revision(void)
 			omap_chip.oc |= CHIP_IS_OMAP3430ES1;
 		else if (omap_rev() > OMAP3430_REV_ES1_0)
 			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
+	} else if (cpu_is_omap35xx()) {
+		/* 35xx are treated as 3430ES2 for power and clockdomains */
+		omap_chip.oc = CHIP_IS_OMAP3430;
+		omap_chip.oc |= CHIP_IS_OMAP3430ES2;
 	} else {
 		pr_err("Uninitialized omap_chip, please fix!\n");
 	}
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 8c53125..311822a 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -316,7 +316,7 @@ void __init omap2_set_globals_243x(void)
 
 #if defined(CONFIG_ARCH_OMAP3430)
 
-static struct omap_globals omap343x_globals = {
+static struct omap_globals omap34xx_globals = {
 	.class	= OMAP343X_CLASS,
 	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
 	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
@@ -328,7 +328,14 @@ static struct omap_globals omap343x_globals = {
 
 void __init omap2_set_globals_343x(void)
 {
-	omap2_globals = &omap343x_globals;
+	omap2_globals = &omap34xx_globals;
+	__omap2_set_globals();
+}
+
+void __init omap2_set_globals_35xx(void)
+{
+	omap34xx_globals.class = OMAP35XX_CLASS;
+	omap2_globals = &omap34xx_globals;
 	__omap2_set_globals();
 }
 #endif
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index af4105f..f41cba2 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -60,6 +60,7 @@ struct omap_globals {
 void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_343x(void);
+void omap2_set_globals_35xx(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 4038596..8d067e3 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -186,6 +186,25 @@
 #define OMAP2_SYSBOOT_1_MASK		(1 << 1)
 #define OMAP2_SYSBOOT_0_MASK		(1 << 0)
 
+/* CONTROL_FEATURE_OMAP_STATUS register and bits */
+#define OMAP343X_CONTROL_FEATURE_OMAP_STATUS	0x044c
+#define OMAP343X_FEATURE_SGX_MASK	(0x3 << 13)
+#define OMAP343X_FEATURE_SGX_SHIFT	13
+#define		OMAP343X_SGX_FULL	0
+#define		OMAP343X_SGX_HALF	1
+#define		OMAP343X_SGX_NONE	2
+#define OMAP343X_FEATURE_IVA2_HW_NONE	(1 << 12)
+#define OMAP343X_FEATURE_L2_CACHE_MASK	(0x3 << 10)
+#define OMAP343X_FEATURE_L2_CACHE_SHIFT	10
+#define		OMAP343X_L2_0KB		0
+#define		OMAP343X_L2_64KB	1
+#define		OMAP343X_L2_128KB	2
+#define		OMAP343X_L2_256KB	3
+#define OMAP343X_FEATURE_ARM_MHZ_MASK	(0x3 << 8)
+#define OMAP343X_FEATURE_ARM_MHZ_SHIFT	8
+#define OMAP343X_FEATURE_IVA2_MHZ_MASK	(0x3 << 6)
+#define OMAP343X_FEATURE_IVA2_MHZ_SHIFT	6
+
 /* CONTROL_FUSE_SR bits */
 #define OMAP343X_SR2_SENNENABLE_MASK	(0x3 << 10)
 #define OMAP343X_SR2_SENNENABLE_SHIFT	10
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index a8e1178..d3b26b6 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -112,6 +112,7 @@ unsigned int omap_rev(void);
  * cpu_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
  * cpu_is_omap243x():	True for OMAP2430
  * cpu_is_omap343x():	True for OMAP3430
+ * cpu_is_omap35xx():	True for OMAP3503, OMAP3515, OMAP3525, OMAP3530
  */
 #define GET_OMAP_CLASS	(omap_rev() & 0xff)
 
@@ -123,10 +124,10 @@ static inline int is_omap ##class (void)		\
 
 #define GET_OMAP_SUBCLASS	((omap_rev() >> 20) & 0x0fff)
 
-#define IS_OMAP_SUBCLASS(subclass, id)			\
+#define IS_OMAP_SUBCLASS(subclass, id, mask)		\
 static inline int is_omap ##subclass (void)		\
 {							\
-	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
+	return ((GET_OMAP_SUBCLASS & (mask)) == ((id) & (mask))) ? 1 : 0; \
 }
 
 IS_OMAP_CLASS(7xx, 0x07)
@@ -135,9 +136,10 @@ IS_OMAP_CLASS(16xx, 0x16)
 IS_OMAP_CLASS(24xx, 0x24)
 IS_OMAP_CLASS(34xx, 0x34)
 
-IS_OMAP_SUBCLASS(242x, 0x242)
-IS_OMAP_SUBCLASS(243x, 0x243)
-IS_OMAP_SUBCLASS(343x, 0x343)
+IS_OMAP_SUBCLASS(242x, 0x242, 0xfff)
+IS_OMAP_SUBCLASS(243x, 0x243, 0xfff)
+IS_OMAP_SUBCLASS(343x, 0x343, 0xfff)
+IS_OMAP_SUBCLASS(35xx, 0x350, 0xff0)
 
 #define cpu_is_omap7xx()		0
 #define cpu_is_omap15xx()		0
@@ -147,6 +149,7 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 #define cpu_is_omap243x()		0
 #define cpu_is_omap34xx()		0
 #define cpu_is_omap343x()		0
+#define cpu_is_omap35xx()		0
 
 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -188,8 +191,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 # if defined(CONFIG_ARCH_OMAP34XX)
 #  undef  cpu_is_omap34xx
 #  undef  cpu_is_omap343x
+#  undef  cpu_is_omap35xx
 #  define cpu_is_omap34xx()		is_omap34xx()
 #  define cpu_is_omap343x()		is_omap343x()
+#  define cpu_is_omap35xx()		is_omap35xx()
 # endif
 #else
 # if defined(CONFIG_ARCH_OMAP24XX)
@@ -209,8 +214,12 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 #  define cpu_is_omap34xx()		1
 # endif
 # if defined(CONFIG_ARCH_OMAP3430)
+#  undef  cpu_is_omap34xx
 #  undef  cpu_is_omap343x
-#  define cpu_is_omap343x()		1
+#  undef  cpu_is_omap35xx
+#  define cpu_is_omap34xx()		is_omap34xx()
+#  define cpu_is_omap343x()		is_omap343x()
+#  define cpu_is_omap35xx()		is_omap35xx()
 # endif
 #endif
 
@@ -230,6 +239,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
  * cpu_is_omap2423():	True for OMAP2423
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
+ * cpu_is_omap3503():	True for OMAP3503
+ * cpu_is_omap3515():	True for OMAP3515
+ * cpu_is_omap3525():	True for OMAP3525
+ * cpu_is_omap3530():	True for OMAP3530
  */
 #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
 
@@ -252,6 +265,10 @@ IS_OMAP_TYPE(2422, 0x2422)
 IS_OMAP_TYPE(2423, 0x2423)
 IS_OMAP_TYPE(2430, 0x2430)
 IS_OMAP_TYPE(3430, 0x3430)
+IS_OMAP_TYPE(3503, 0x3503)
+IS_OMAP_TYPE(3515, 0x3515)
+IS_OMAP_TYPE(3525, 0x3525)
+IS_OMAP_TYPE(3530, 0x3530)
 
 #define cpu_is_omap310()		0
 #define cpu_is_omap730()		0
@@ -266,6 +283,10 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
 #define cpu_is_omap3430()		0
+#define cpu_is_omap3503()		0
+#define cpu_is_omap3515()		0
+#define cpu_is_omap3525()		0
+#define cpu_is_omap3530()		0
 
 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -316,7 +337,15 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 #if defined(CONFIG_ARCH_OMAP34XX)
 # undef cpu_is_omap3430
+# undef cpu_is_omap3503
+# undef cpu_is_omap3515
+# undef cpu_is_omap3525
+# undef cpu_is_omap3530
 # define cpu_is_omap3430()		is_omap3430()
+# define cpu_is_omap3503()		is_omap3503()
+# define cpu_is_omap3515()		is_omap3515()
+# define cpu_is_omap3525()		is_omap3525()
+# define cpu_is_omap3530()		is_omap3530()
 #endif
 
 /* Macros to detect if we have OMAP1 or OMAP2 */
@@ -341,6 +370,16 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3430_REV_ES3_0	0x34303034
 #define OMAP3430_REV_ES3_1	0x34304034
 
+#define OMAP35XX_CLASS		0x35000034	/* Yes, it's still a 34xx */
+#define OMAP3503_MASK		0x00030000
+#define OMAP3515_MASK		0x00150000
+#define OMAP3525_MASK		0x00250000
+#define OMAP3530_MASK		0x00300000
+
+#define OMAP35XX_MASK_ES2_0	0x00001000
+#define OMAP35XX_MASK_ES2_1	0x00002000
+#define OMAP35XX_MASK_ES3_0	0x00003000
+
 /*
  * omap_chip bits
  *

--Q68bSM7Ycu6FN28Q--
