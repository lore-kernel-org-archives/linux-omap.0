From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ARM: OMAP4: hwmod_data: Correct IDLEMODE for McPDM
Date: Thu, 3 Jan 2013 14:46:51 +0100
Message-ID: <1357220811-29904-3-git-send-email-peter.ujfalusi@ti.com>
References: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55777 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753503Ab3ACNrD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jan 2013 08:47:03 -0500
In-Reply-To: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Jon Hunter <jon-hunter@ti.com>

McPDM need to be configured to NO_IDLE mode when it is in used otherwise
vital clocks will be gated which results 'slow motion' audio playback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 129d508..584acf9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2133,7 +2133,7 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	 * available, so it doesn't seem that we have any choice in
 	 * the kernel other than to avoid resetting it.
 	 */
-	.flags		= HWMOD_EXT_OPT_MAIN_CLK,
+	.flags		= HWMOD_EXT_OPT_MAIN_CLK | HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= omap44xx_mcpdm_irqs,
 	.sdma_reqs	= omap44xx_mcpdm_sdma_reqs,
 	.main_clk	= "mcpdm_fck",
-- 
1.8.0.2

