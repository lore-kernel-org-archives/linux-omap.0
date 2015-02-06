From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ARM: DRA7: hwmod_data: Change locked_class for atl hwmod
Date: Fri, 6 Feb 2015 14:48:36 +0200
Message-ID: <1423226916-18804-3-git-send-email-peter.ujfalusi@ti.com>
References: <1423226916-18804-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423226916-18804-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The ATL hwmod can be used in nested way when it is selected to be the
functional clock for McASP. For this lockdep validator will trigger false
positive warning.
By assigning separate class to atl locking will sort this out.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index e8692e7675b8..87f259e8c574 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -185,6 +185,7 @@ static struct omap_hwmod dra7xx_atl_hwmod = {
 	.class		= &dra7xx_atl_hwmod_class,
 	.clkdm_name	= "atl_clkdm",
 	.main_clk	= "atl_gfclk_mux",
+	.lockdep_class	= HWMOD_LOCKDEP_SUBCLASS_CLASS1,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_ATL_ATL_CLKCTRL_OFFSET,
-- 
2.2.2
