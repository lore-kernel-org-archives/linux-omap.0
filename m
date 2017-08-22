From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ARM: omap1: add const and initconst to omap_lcd_config
Date: Tue, 22 Aug 2017 11:55:50 +0530
Message-ID: <1503383150-2363-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, aaro.koskinen@iki.fi, tony@atomide.com, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make these const as they are only passed to a const argument of the function
omapfb_set_lcd_config.
Also, replace __initdata with __initconst to avoid section conflict error.
Done using Coccinelle.

@match disable optional_qualifier@
identifier s;
@@
static struct omap_lcd_config s = {...};

@ref@
position p;
identifier match.s;
@@
s@p

@good1@
identifier match.s;
position ref.p;
@@
omapfb_set_lcd_config(&s@p,...)

@bad depends on  !good1@
position ref.p;
identifier match.s;
@@
s@p

@depends on forall !bad disable optional_qualifier@
identifier match.s;
@@
static
+ const
struct omap_lcd_config s;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 2 +-
 arch/arm/mach-omap1/board-fsample.c   | 2 +-
 arch/arm/mach-omap1/board-h2.c        | 2 +-
 arch/arm/mach-omap1/board-h3.c        | 2 +-
 arch/arm/mach-omap1/board-htcherald.c | 2 +-
 arch/arm/mach-omap1/board-innovator.c | 4 ++--
 arch/arm/mach-omap1/board-nokia770.c  | 2 +-
 arch/arm/mach-omap1/board-osk.c       | 2 +-
 arch/arm/mach-omap1/board-palmte.c    | 2 +-
 arch/arm/mach-omap1/board-palmtt.c    | 2 +-
 arch/arm/mach-omap1/board-palmz71.c   | 2 +-
 arch/arm/mach-omap1/board-perseus2.c  | 2 +-
 arch/arm/mach-omap1/board-sx1.c       | 2 +-
 13 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 6cbc69c..52e8e53 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -156,7 +156,7 @@
 	}
 };
 
-static struct omap_lcd_config ams_delta_lcd_config __initdata = {
+static const struct omap_lcd_config ams_delta_lcd_config __initconst = {
 	.ctrl_name	= "internal",
 };
 
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index fad95b7..4e8464f 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -266,7 +266,7 @@ static int nand_dev_ready(struct mtd_info *mtd)
 	&kp_device,
 };
 
-static struct omap_lcd_config fsample_lcd_config = {
+static const struct omap_lcd_config fsample_lcd_config = {
 	.ctrl_name	= "internal",
 };
 
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index dece47d..431f7eb 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -357,7 +357,7 @@ static int tps_setup(struct i2c_client *client, void *context)
 	.pins[1]	= 3,
 };
 
-static struct omap_lcd_config h2_lcd_config __initdata = {
+static const struct omap_lcd_config h2_lcd_config __initconst = {
 	.ctrl_name	= "internal",
 };
 
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 6d32bee..af46012 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -376,7 +376,7 @@ static void __init h3_init_smc91x(void)
 	.pins[1]	= 3,
 };
 
-static struct omap_lcd_config h3_lcd_config __initdata = {
+static const struct omap_lcd_config h3_lcd_config __initconst = {
 	.ctrl_name	= "internal",
 };
 
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index e424df9..67d4669 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -391,7 +391,7 @@
 };
 
 /* LCD Device resources */
-static struct omap_lcd_config htcherald_lcd_config __initdata = {
+static const struct omap_lcd_config htcherald_lcd_config __initconst = {
 	.ctrl_name	= "internal",
 };
 
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 67e1882..8c286a2 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -302,7 +302,7 @@ static void __init innovator_init_smc91x(void)
 	.pins[0]	= 2,
 };
 
-static struct omap_lcd_config innovator1510_lcd_config __initdata = {
+static const struct omap_lcd_config innovator1510_lcd_config __initconst = {
 	.ctrl_name	= "internal",
 };
 #endif
@@ -323,7 +323,7 @@ static void __init innovator_init_smc91x(void)
 	.pins[1]	= 3,
 };
 
-static struct omap_lcd_config innovator1610_lcd_config __initdata = {
+static const struct omap_lcd_config innovator1610_lcd_config __initconst = {
 	.ctrl_name	= "internal",
 };
 #endif
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 06243c0..eb41db7 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -103,7 +103,7 @@ static void mipid_shutdown(struct mipid_platform_data *pdata)
 	.shutdown = mipid_shutdown,
 };
 
-static struct omap_lcd_config nokia770_lcd_config __initdata = {
+static const struct omap_lcd_config nokia770_lcd_config __initconst = {
 	.ctrl_name	= "hwa742",
 };
 
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index d579f4e..c66372e 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -295,7 +295,7 @@ static void __init osk_init_cf(void)
 };
 
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
-static struct omap_lcd_config osk_lcd_config __initdata = {
+static const struct omap_lcd_config osk_lcd_config __initconst = {
 	.ctrl_name	= "internal",
 };
 #endif
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index e5288cd..2dc5deb 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -178,7 +178,7 @@
 	.pins[0]	= 2,
 };
 
-static struct omap_lcd_config palmte_lcd_config __initdata = {
+static const struct omap_lcd_config palmte_lcd_config __initconst = {
 	.ctrl_name	= "internal",
 };
 
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index d672495..a233276 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -241,7 +241,7 @@ static int palmtt_get_pendown_state(void)
 	.pins[0]	= 2,
 };
 
-static struct omap_lcd_config palmtt_lcd_config __initdata = {
+static const struct omap_lcd_config palmtt_lcd_config __initconst = {
 	.ctrl_name	= "internal",
 };
 
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index aaf741b..30b0709 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -206,7 +206,7 @@
 	.pins[0]	= 2,
 };
 
-static struct omap_lcd_config palmz71_lcd_config __initdata = {
+static const struct omap_lcd_config palmz71_lcd_config __initconst = {
 	.ctrl_name = "internal",
 };
 
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 150b57b..b178841 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -225,7 +225,7 @@ static int nand_dev_ready(struct mtd_info *mtd)
 	&kp_device,
 };
 
-static struct omap_lcd_config perseus2_lcd_config __initdata = {
+static const struct omap_lcd_config perseus2_lcd_config __initconst = {
 	.ctrl_name	= "internal",
 };
 
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 6c48225..ec27bb3 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -297,7 +297,7 @@ int sx1_setusbpower(u8 onoff)
 
 /*----------- LCD -------------------------*/
 
-static struct omap_lcd_config sx1_lcd_config __initdata = {
+static const struct omap_lcd_config sx1_lcd_config __initconst = {
 	.ctrl_name	= "internal",
 };
 
-- 
1.9.1
