From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH] ARM: OMAP4: hwmod data: Update AESS data with memory bank area
Date: Mon, 23 Apr 2012 22:25:47 +0200
Message-ID: <1335212747-8006-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52969 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab2DWUZy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 16:25:54 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q3NKPsq0020888
	for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 15:25:54 -0500
Received: from DFLE71.ent.ti.com (dfle71.ent.ti.com [128.247.5.62])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q3NKPsD8012683
	for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 15:25:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org
Cc: Sebastien Guiriec <s-guiriec@ti.com>

Add AESS memory bank data in hwmod in order to provide memory
address information to the driver. AESS is divided inside 5
memory banks than can be accessed directly by MPU or by L3.
- PMEM: Program memory bank.
- SMEM: Sample memory bank.
- CMEM: Coefficients memory bank
- DMEM: Data memory bank.
- MPU/DMA: Register of AESS IP.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   42 ++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 4906129..b0d333a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3999,6 +3999,27 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp_wp_noc = {
 
 static struct omap_hwmod_addr_space omap44xx_aess_addrs[] = {
 	{
+		.name		= "dmem",
+		.pa_start	= 0x40180000,
+		.pa_end		= 0x4018ffff
+	},
+	{
+		.name		= "cmem",
+		.pa_start	= 0x401a0000,
+		.pa_end		= 0x401a1fff
+	},
+	{
+		.name		= "smem",
+		.pa_start	= 0x401c0000,
+		.pa_end		= 0x401c5fff
+	},
+	{
+		.name		= "pmem",
+		.pa_start	= 0x401e0000,
+		.pa_end		= 0x401e1fff
+	},
+	{
+		.name		= "mpu",
 		.pa_start	= 0x401f1000,
 		.pa_end		= 0x401f13ff,
 		.flags		= ADDR_TYPE_RT
@@ -4017,6 +4038,27 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess = {
 
 static struct omap_hwmod_addr_space omap44xx_aess_dma_addrs[] = {
 	{
+		.name		= "dmem_dma",
+		.pa_start	= 0x49080000,
+		.pa_end		= 0x4908ffff
+	},
+	{
+		.name		= "cmem_dma",
+		.pa_start	= 0x490a0000,
+		.pa_end		= 0x490a1fff
+	},
+	{
+		.name		= "smem_dma",
+		.pa_start	= 0x490c0000,
+		.pa_end		= 0x490c5fff
+	},
+	{
+		.name		= "pmem_dma",
+		.pa_start	= 0x490e0000,
+		.pa_end		= 0x490e1fff
+	},
+	{
+		.name		= "dma",
 		.pa_start	= 0x490f1000,
 		.pa_end		= 0x490f13ff,
 		.flags		= ADDR_TYPE_RT
-- 
1.7.4.1

