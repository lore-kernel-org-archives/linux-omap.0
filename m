From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 14/20] OMAP2&3: hwmod: Replace l3 -> l3_main
Date: Fri, 02 Jul 2010 09:29:36 -0600
Message-ID: <20100702152934.6221.64274.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45300 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758902Ab0GBPbG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:31:06 -0400
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

Replace all the struct that contain l3 with l3_main in order
to be consistent with the OMAP4 naming convention.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   34 +++++++++++------------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   34 +++++++++++------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   42 ++++++++++++++--------------
 3 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 646386c..8c90b27 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -30,41 +30,41 @@
  */
 
 static struct omap_hwmod omap2420_mpu_hwmod;
-static struct omap_hwmod omap2420_l3_hwmod;
+static struct omap_hwmod omap2420_l3_main_hwmod;
 static struct omap_hwmod omap2420_l4_core_hwmod;
 
 /* L3 -> L4_CORE interface */
-static struct omap_hwmod_ocp_if omap2420_l3__l4_core = {
-	.master	= &omap2420_l3_hwmod,
+static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
+	.master	= &omap2420_l3_main_hwmod,
 	.slave	= &omap2420_l4_core_hwmod,
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* MPU -> L3 interface */
-static struct omap_hwmod_ocp_if omap2420_mpu__l3 = {
+static struct omap_hwmod_ocp_if omap2420_mpu__l3_main = {
 	.master = &omap2420_mpu_hwmod,
-	.slave	= &omap2420_l3_hwmod,
+	.slave	= &omap2420_l3_main_hwmod,
 	.user	= OCP_USER_MPU,
 };
 
 /* Slave interfaces on the L3 interconnect */
-static struct omap_hwmod_ocp_if *omap2420_l3_slaves[] = {
-	&omap2420_mpu__l3,
+static struct omap_hwmod_ocp_if *omap2420_l3_main_slaves[] = {
+	&omap2420_mpu__l3_main,
 };
 
 /* Master interfaces on the L3 interconnect */
-static struct omap_hwmod_ocp_if *omap2420_l3_masters[] = {
-	&omap2420_l3__l4_core,
+static struct omap_hwmod_ocp_if *omap2420_l3_main_masters[] = {
+	&omap2420_l3_main__l4_core,
 };
 
 /* L3 */
-static struct omap_hwmod omap2420_l3_hwmod = {
+static struct omap_hwmod omap2420_l3_main_hwmod = {
 	.name		= "l3_main",
 	.class		= &l3_hwmod_class,
-	.masters	= omap2420_l3_masters,
-	.masters_cnt	= ARRAY_SIZE(omap2420_l3_masters),
-	.slaves		= omap2420_l3_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap2420_l3_slaves),
+	.masters	= omap2420_l3_main_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2420_l3_main_masters),
+	.slaves		= omap2420_l3_main_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_l3_main_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 	.flags		= HWMOD_NO_IDLEST,
 };
@@ -80,7 +80,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
 
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2420_l4_core_slaves[] = {
-	&omap2420_l3__l4_core,
+	&omap2420_l3_main__l4_core,
 };
 
 /* Master interfaces on the L4_CORE interconnect */
@@ -123,7 +123,7 @@ static struct omap_hwmod omap2420_l4_wkup_hwmod = {
 
 /* Master interfaces on the MPU device */
 static struct omap_hwmod_ocp_if *omap2420_mpu_masters[] = {
-	&omap2420_mpu__l3,
+	&omap2420_mpu__l3_main,
 };
 
 /* MPU */
@@ -137,7 +137,7 @@ static struct omap_hwmod omap2420_mpu_hwmod = {
 };
 
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
-	&omap2420_l3_hwmod,
+	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
 	&omap2420_l4_wkup_hwmod,
 	&omap2420_mpu_hwmod,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index b2100cf..c0f3311 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -30,41 +30,41 @@
  */
 
 static struct omap_hwmod omap2430_mpu_hwmod;
-static struct omap_hwmod omap2430_l3_hwmod;
+static struct omap_hwmod omap2430_l3_main_hwmod;
 static struct omap_hwmod omap2430_l4_core_hwmod;
 
 /* L3 -> L4_CORE interface */
-static struct omap_hwmod_ocp_if omap2430_l3__l4_core = {
-	.master	= &omap2430_l3_hwmod,
+static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
+	.master	= &omap2430_l3_main_hwmod,
 	.slave	= &omap2430_l4_core_hwmod,
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* MPU -> L3 interface */
-static struct omap_hwmod_ocp_if omap2430_mpu__l3 = {
+static struct omap_hwmod_ocp_if omap2430_mpu__l3_main = {
 	.master = &omap2430_mpu_hwmod,
-	.slave	= &omap2430_l3_hwmod,
+	.slave	= &omap2430_l3_main_hwmod,
 	.user	= OCP_USER_MPU,
 };
 
 /* Slave interfaces on the L3 interconnect */
-static struct omap_hwmod_ocp_if *omap2430_l3_slaves[] = {
-	&omap2430_mpu__l3,
+static struct omap_hwmod_ocp_if *omap2430_l3_main_slaves[] = {
+	&omap2430_mpu__l3_main,
 };
 
 /* Master interfaces on the L3 interconnect */
-static struct omap_hwmod_ocp_if *omap2430_l3_masters[] = {
-	&omap2430_l3__l4_core,
+static struct omap_hwmod_ocp_if *omap2430_l3_main_masters[] = {
+	&omap2430_l3_main__l4_core,
 };
 
 /* L3 */
-static struct omap_hwmod omap2430_l3_hwmod = {
+static struct omap_hwmod omap2430_l3_main_hwmod = {
 	.name		= "l3_main",
 	.class		= &l3_hwmod_class,
-	.masters	= omap2430_l3_masters,
-	.masters_cnt	= ARRAY_SIZE(omap2430_l3_masters),
-	.slaves		= omap2430_l3_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap2430_l3_slaves),
+	.masters	= omap2430_l3_main_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2430_l3_main_masters),
+	.slaves		= omap2430_l3_main_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_l3_main_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 	.flags		= HWMOD_NO_IDLEST,
 };
@@ -82,7 +82,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
 
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] = {
-	&omap2430_l3__l4_core,
+	&omap2430_l3_main__l4_core,
 };
 
 /* Master interfaces on the L4_CORE interconnect */
@@ -125,7 +125,7 @@ static struct omap_hwmod omap2430_l4_wkup_hwmod = {
 
 /* Master interfaces on the MPU device */
 static struct omap_hwmod_ocp_if *omap2430_mpu_masters[] = {
-	&omap2430_mpu__l3,
+	&omap2430_mpu__l3_main,
 };
 
 /* MPU */
@@ -139,7 +139,7 @@ static struct omap_hwmod omap2430_mpu_hwmod = {
 };
 
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
-	&omap2430_l3_hwmod,
+	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
 	&omap2430_l4_wkup_hwmod,
 	&omap2430_mpu_hwmod,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ec6a5f8..9d9cfb9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -32,50 +32,50 @@
  */
 
 static struct omap_hwmod omap3xxx_mpu_hwmod;
-static struct omap_hwmod omap3xxx_l3_hwmod;
+static struct omap_hwmod omap3xxx_l3_main_hwmod;
 static struct omap_hwmod omap3xxx_l4_core_hwmod;
 static struct omap_hwmod omap3xxx_l4_per_hwmod;
 
 /* L3 -> L4_CORE interface */
-static struct omap_hwmod_ocp_if omap3xxx_l3__l4_core = {
-	.master	= &omap3xxx_l3_hwmod,
+static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
+	.master	= &omap3xxx_l3_main_hwmod,
 	.slave	= &omap3xxx_l4_core_hwmod,
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* L3 -> L4_PER interface */
-static struct omap_hwmod_ocp_if omap3xxx_l3__l4_per = {
-	.master = &omap3xxx_l3_hwmod,
+static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_per = {
+	.master = &omap3xxx_l3_main_hwmod,
 	.slave	= &omap3xxx_l4_per_hwmod,
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* MPU -> L3 interface */
-static struct omap_hwmod_ocp_if omap3xxx_mpu__l3 = {
+static struct omap_hwmod_ocp_if omap3xxx_mpu__l3_main = {
 	.master = &omap3xxx_mpu_hwmod,
-	.slave	= &omap3xxx_l3_hwmod,
+	.slave	= &omap3xxx_l3_main_hwmod,
 	.user	= OCP_USER_MPU,
 };
 
 /* Slave interfaces on the L3 interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l3_slaves[] = {
-	&omap3xxx_mpu__l3,
+static struct omap_hwmod_ocp_if *omap3xxx_l3_main_slaves[] = {
+	&omap3xxx_mpu__l3_main,
 };
 
 /* Master interfaces on the L3 interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l3_masters[] = {
-	&omap3xxx_l3__l4_core,
-	&omap3xxx_l3__l4_per,
+static struct omap_hwmod_ocp_if *omap3xxx_l3_main_masters[] = {
+	&omap3xxx_l3_main__l4_core,
+	&omap3xxx_l3_main__l4_per,
 };
 
 /* L3 */
-static struct omap_hwmod omap3xxx_l3_hwmod = {
+static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 	.name		= "l3_main",
 	.class		= &l3_hwmod_class,
-	.masters	= omap3xxx_l3_masters,
-	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_masters),
-	.slaves		= omap3xxx_l3_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l3_slaves),
+	.masters	= omap3xxx_l3_main_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_main_masters),
+	.slaves		= omap3xxx_l3_main_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l3_main_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.flags		= HWMOD_NO_IDLEST,
 };
@@ -91,7 +91,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
 
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
-	&omap3xxx_l3__l4_core,
+	&omap3xxx_l3_main__l4_core,
 };
 
 /* Master interfaces on the L4_CORE interconnect */
@@ -113,7 +113,7 @@ static struct omap_hwmod omap3xxx_l4_core_hwmod = {
 
 /* Slave interfaces on the L4_PER interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_per_slaves[] = {
-	&omap3xxx_l3__l4_per,
+	&omap3xxx_l3_main__l4_per,
 };
 
 /* Master interfaces on the L4_PER interconnect */
@@ -155,7 +155,7 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
 
 /* Master interfaces on the MPU device */
 static struct omap_hwmod_ocp_if *omap3xxx_mpu_masters[] = {
-	&omap3xxx_mpu__l3,
+	&omap3xxx_mpu__l3_main,
 };
 
 /* MPU */
@@ -169,7 +169,7 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
 };
 
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
-	&omap3xxx_l3_hwmod,
+	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
 	&omap3xxx_l4_per_hwmod,
 	&omap3xxx_l4_wkup_hwmod,


