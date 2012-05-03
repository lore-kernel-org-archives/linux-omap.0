From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 07/13] ARM: OMAP5: l3: Add l3 error handler support for omap5.
Date: Thu, 3 May 2012 12:56:16 +0530
Message-ID: <1336029982-31898-8-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46885 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755719Ab2ECH0o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 03:26:44 -0400
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com

The l3 interconnect ip is same for OMAP4 and OMAP5.
So reuse the l3 error handler error code for OMAP5
as well. Also a few targets has been newly added for
OMAP5. So updating the driver for that here.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    1 +
 arch/arm/mach-omap2/devices.c     |    2 +-
 arch/arm/mach-omap2/omap_l3_noc.h |   22 ++++++++++++++++++----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fbb6b3d..9f554e3 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -183,6 +183,7 @@ obj-$(CONFIG_OMAP3_EMU)			+= emu.o
 # L3 interconnect
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_l3_smx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_l3_noc.o
+obj-$(CONFIG_ARCH_OMAP5)                += omap_l3_noc.o
 
 obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
 mailbox_mach-objs			:= mailbox.o
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index e433603..a1b539a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -85,7 +85,7 @@ static int __init omap4_l3_init(void)
 	 * To avoid code running on other OMAPs in
 	 * multi-omap builds
 	 */
-	if (!(cpu_is_omap44xx()))
+	if ((!(cpu_is_omap44xx())) && (!cpu_is_omap54xx()))
 		return -ENODEV;
 
 	for (i = 0; i < L3_MODULES; i++) {
diff --git a/arch/arm/mach-omap2/omap_l3_noc.h b/arch/arm/mach-omap2/omap_l3_noc.h
index 90b5098..a6ce34d 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.h
+++ b/arch/arm/mach-omap2/omap_l3_noc.h
@@ -51,7 +51,9 @@ static u32 l3_targ_inst_clk1[] = {
 	0x200, /* DMM2 */
 	0x300, /* ABE */
 	0x400, /* L4CFG */
-	0x600  /* CLK2 PWR DISC */
+	0x600,  /* CLK2 PWR DISC */
+	0x0,	/* Host CLK1 */
+	0x900	/* L4 Wakeup */
 };
 
 static u32 l3_targ_inst_clk2[] = {
@@ -72,11 +74,16 @@ static u32 l3_targ_inst_clk2[] = {
 	0xE00, /* missing in TRM corresponds to AES2*/
 	0xC00, /* L4 PER3 */
 	0xA00, /* L4 PER1*/
-	0xB00 /* L4 PER2*/
+	0xB00, /* L4 PER2*/
+	0x0, /* HOST CLK2 */
+	0x1800, /* CAL */
+	0x1700 /* LLI */
 };
 
 static u32 l3_targ_inst_clk3[] = {
-	0x0100	/* EMUSS */
+	0x0100	/* EMUSS */,
+	0x0300, /* DEBUGSS_CT_TBR */
+	0x0 /* HOST CLK3 */
 };
 
 static struct l3_masters_data {
@@ -110,13 +117,15 @@ static struct l3_masters_data {
 	{ 0xC8, "USBHOSTFS"}
 };
 
-static char *l3_targ_inst_name[L3_MODULES][18] = {
+static char *l3_targ_inst_name[L3_MODULES][21] = {
 	{
 		"DMM1",
 		"DMM2",
 		"ABE",
 		"L4CFG",
 		"CLK2 PWR DISC",
+		"HOST CLK1",
+		"L4 WAKEUP"
 	},
 	{
 		"CORTEX M3" ,
@@ -137,9 +146,14 @@ static char *l3_targ_inst_name[L3_MODULES][18] = {
 		"L4 PER3",
 		"L4 PER1",
 		"L4 PER2",
+		"HOST CLK2",
+		"CAL",
+		"LLI"
 	},
 	{
 		"EMUSS",
+		"DEBUG SOURCE",
+		"HOST CLK3"
 	},
 };
 
-- 
1.7.1

