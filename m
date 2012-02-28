From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/9] ARM: OMAP3: hwmod data: GPTIMER12 is attached to a
 separate interconnect
Date: Tue, 28 Feb 2012 04:10:54 -0700
Message-ID: <20120228111053.808.87403.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35175 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965153Ab2B1LLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 06:11:34 -0500
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

GPTIMER12 is attached to the L4 SEC interconnect, not directly to L4 WKUP.
Add the L4 SEC interconnect and attach GPTIMER12 to it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 48b6a88..417a007 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -170,6 +170,7 @@ static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 };
 
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
+static struct omap_hwmod omap3xxx_l4_sec_hwmod;
 static struct omap_hwmod omap3xxx_uart1_hwmod;
 static struct omap_hwmod omap3xxx_uart2_hwmod;
 static struct omap_hwmod omap3xxx_uart3_hwmod;
@@ -521,6 +522,13 @@ static struct omap_hwmod omap3xxx_l4_per_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
+/* L4_WKUP -> L4_SEC interface */
+static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__l4_sec = {
+	.master = &omap3xxx_l4_wkup_hwmod,
+	.slave	= &omap3xxx_l4_sec_hwmod,
+	.user	= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* Slave interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_slaves[] = {
 	&omap3xxx_l4_core__l4_wkup,
@@ -535,6 +543,20 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
+/* Slave interfaces on the L4_SEC interconnect */
+static struct omap_hwmod_ocp_if *omap3xxx_l4_sec_slaves[] = {
+	&omap3xxx_l4_wkup__l4_sec,
+};
+
+/* L4 SEC */
+static struct omap_hwmod omap3xxx_l4_sec_hwmod = {
+	.name		= "l4_sec",
+	.class		= &l4_hwmod_class,
+	.slaves		= omap3xxx_l4_sec_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_sec_slaves),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 /* Master interfaces on the MPU device */
 static struct omap_hwmod_ocp_if *omap3xxx_mpu_masters[] = {
 	&omap3xxx_mpu__l3_main,
@@ -1130,8 +1152,8 @@ static struct omap_hwmod_addr_space omap3xxx_timer12_addrs[] = {
 };
 
 /* l4_core -> timer12 */
-static struct omap_hwmod_ocp_if omap3xxx_l4_core__timer12 = {
-	.master		= &omap3xxx_l4_core_hwmod,
+static struct omap_hwmod_ocp_if omap3xxx_l4_sec__timer12 = {
+	.master		= &omap3xxx_l4_sec_hwmod,
 	.slave		= &omap3xxx_timer12_hwmod,
 	.clk		= "gpt12_ick",
 	.addr		= omap3xxx_timer12_addrs,
@@ -1140,7 +1162,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__timer12 = {
 
 /* timer12 slave port */
 static struct omap_hwmod_ocp_if *omap3xxx_timer12_slaves[] = {
-	&omap3xxx_l4_core__timer12,
+	&omap3xxx_l4_sec__timer12,
 };
 
 /* timer12 hwmod */


