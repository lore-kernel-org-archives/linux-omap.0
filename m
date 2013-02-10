From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 5/5] OMAP4: hwmod data: Update AESS data with memory
 bank area
Date: Sun, 10 Feb 2013 19:19:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302101917260.2672@utopia.booyaka.com>
References: <1357743792-13917-1-git-send-email-s-guiriec@ti.com> <1357743792-13917-6-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58041 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136Ab3BJTTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Feb 2013 14:19:10 -0500
In-Reply-To: <1357743792-13917-6-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

Hi

On Wed, 9 Jan 2013, Sebastien Guiriec wrote:

> Add AESS memory bank data in hwmod in order to provide memory
> address information to the driver.
> 
> Signed-off-by: sebastien Guiriec <s-guiriec@ti.com>

Due to the cleanup of the CLKCTRL leaf clocks, this one has been updated 
to change the AESS main clock to be aess_fclk, and it's also been moved to 
precede the patch that enables the AESS hwmod.


- Paul


From: Sebastien Guiriec <s-guiriec@ti.com>
Date: Sun, 10 Feb 2013 11:22:24 -0700
Subject: [PATCH] ARM: OMAP4: hwmod data: Update AESS data with memory bank
 area

Add AESS memory bank data in hwmod in order to provide memory address
information to the driver.

This version also changes the AESS main clock to use a
non-CLKCTRL-based functional clock.  These are being removed from the
clock data, since they should be handled by the IP block integration
code.  Without this change, the kernel crashes during boot.  Thanks to
Tony Lindgren for reporting this during a test merge.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
[paul@pwsan.com: updated to change the AESS main_clk]
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   44 +++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index c9c251e..a30c113 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -349,7 +349,7 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 	.clkdm_name	= "abe_clkdm",
 	.mpu_irqs	= omap44xx_aess_irqs,
 	.sdma_reqs	= omap44xx_aess_sdma_reqs,
-	.main_clk	= "aess_fck",
+	.main_clk	= "aess_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET,
@@ -4250,6 +4250,27 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp_wp_noc = {
 
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
@@ -4268,6 +4289,27 @@ static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess = {
 
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

