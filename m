From: Abhilash K V <abhilash.kv@ti.com>
Subject: [PATCH v5 1/3] AM35x: Using OMAP3 generic hwmods
Date: Fri, 30 Sep 2011 11:42:31 +0530
Message-ID: <1317363153-10259-2-git-send-email-abhilash.kv@ti.com>
References: <1317363153-10259-1-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317363153-10259-1-git-send-email-abhilash.kv@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, paul@pwsan.com, aneesh@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, christian.gmeiner@gmail.com, Abhilash K V <abhilash.kv@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Abhilash K V <abhilash.kv@ti.com>

Removing modules iva, sr1_hwmod, sr2_hwmod, mailbox from
the base omap3xxx_hwmods list, so that they can be excluded
for am35x.

Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
---
New in v5: reworked to use the new approach to select
 device-specific hwmods as suggested by PaulW here
 http://marc.info/?l=linux-kernel&m=131671863104802&w=2

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 3008e16..8de6dc4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3159,7 +3159,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_mmc2_hwmod,
 	&omap3xxx_mmc3_hwmod,
 	&omap3xxx_mpu_hwmod,
-	&omap3xxx_iva_hwmod,
 
 	&omap3xxx_timer1_hwmod,
 	&omap3xxx_timer2_hwmod,
@@ -3188,8 +3187,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_i2c1_hwmod,
 	&omap3xxx_i2c2_hwmod,
 	&omap3xxx_i2c3_hwmod,
-	&omap34xx_sr1_hwmod,
-	&omap34xx_sr2_hwmod,
 
 	/* gpio class */
 	&omap3xxx_gpio1_hwmod,
@@ -3211,8 +3208,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_mcbsp2_sidetone_hwmod,
 	&omap3xxx_mcbsp3_sidetone_hwmod,
 
-	/* mailbox class */
-	&omap3xxx_mailbox_hwmod,
 
 	/* mcspi class */
 	&omap34xx_mcspi1,
@@ -3225,31 +3220,43 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 
 /* 3430ES1-only hwmods */
 static __initdata struct omap_hwmod *omap3430es1_hwmods[] = {
+	&omap3xxx_iva_hwmod,
 	&omap3430es1_dss_core_hwmod,
+	/* mailbox class */
+	&omap3xxx_mailbox_hwmod,
 	NULL
 };
 
 /* 3430ES2+-only hwmods */
 static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] = {
+	&omap3xxx_iva_hwmod,
 	&omap3xxx_dss_core_hwmod,
 	&omap3xxx_usbhsotg_hwmod,
+	/* mailbox class */
+	&omap3xxx_mailbox_hwmod,
 	NULL
 };
 
 /* 34xx-only hwmods (all ES revisions) */
 static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
+	&omap3xxx_iva_hwmod,
 	&omap34xx_sr1_hwmod,
 	&omap34xx_sr2_hwmod,
+	/* mailbox class */
+	&omap3xxx_mailbox_hwmod,
 	NULL
 };
 
 /* 36xx-only hwmods (all ES revisions) */
 static __initdata struct omap_hwmod *omap36xx_hwmods[] = {
+	&omap3xxx_iva_hwmod,
 	&omap3xxx_uart4_hwmod,
 	&omap3xxx_dss_core_hwmod,
 	&omap36xx_sr1_hwmod,
 	&omap36xx_sr2_hwmod,
 	&omap3xxx_usbhsotg_hwmod,
+	/* mailbox class */
+	&omap3xxx_mailbox_hwmod,
 	NULL
 };
 
-- 
1.7.1
