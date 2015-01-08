From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2] ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL enabled on UART3
Date: Thu, 8 Jan 2015 17:22:04 +0530
Message-ID: <1420717924-3721-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, t-kristo@ti.com, nm@ti.com, nsekhar@ti.com, balbi@ti.com, lokeshvutla@ti.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

With commit '7dedd34: ARM: OMAP2+: hwmod: Fix a crash in _setup_reset()
with DEBUG_LL' we moved from parsing cmdline to identify uart used
for earlycon to using the requsite hwmod CONFIG_DEBUG_OMAPxUARTy FLAGS.

On DRA7 UART3 hwmod doesn't have this flag enabled, and atleast on
BeagleBoard-X15, where we use UART3 for console, boot fails with
DEBUG_LL enabled. Enable DEBUG_OMAP4UART3_FLAGS for UART3 hwmod.

For using DEBUG_LL, enable CONFIG_DEBUG_OMAP4UART3 in menuconfig.

Fixes: 90020c7b2c5e ("ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data")
Cc: <stable@vger.kernel.org> # v3.12+
Reviewed-by: Felipe Balbi <balbi@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v1:
	- Updated $subject and patch description.	
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index ffd6604..b6ea88f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2017,7 +2017,7 @@ static struct omap_hwmod dra7xx_uart3_hwmod = {
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.main_clk	= "uart3_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
+	.flags		= HWMOD_SWSUP_SIDLE_ACT | DEBUG_OMAP4UART3_FLAGS,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_UART3_CLKCTRL_OFFSET,
-- 
1.9.1
