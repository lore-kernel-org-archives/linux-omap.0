From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH v2 5/5] OMAP4: hwmod data: Update AESS data with memory bank area
Date: Wed, 9 Jan 2013 16:03:11 +0100
Message-ID: <1357743792-13917-6-git-send-email-s-guiriec@ti.com>
References: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42951 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758022Ab3AIPDc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jan 2013 10:03:32 -0500
In-Reply-To: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

Add AESS memory bank data in hwmod in order to provide memory
address information to the driver.

Signed-off-by: sebastien Guiriec <s-guiriec@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6d22fd0..631611c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4246,6 +4246,27 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp_wp_noc = {
 
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
@@ -4264,6 +4285,27 @@ static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess = {
 
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
1.7.10.4

