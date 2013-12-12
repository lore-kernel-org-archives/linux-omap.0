From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL
Date: Thu, 12 Dec 2013 15:22:49 +0530
Message-ID: <1386841969-765-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>, lokeshvutla@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With commit '7dedd34: ARM: OMAP2+: hwmod: Fix a crash in _setup_reset() with
 DEBUG_LL' we moved from parsing cmdline to identify uart used for earlycon
to using the requsite hwmod CONFIG_DEBUG_OMAPxUARTy FLAGS.

On DRA7 though, we seem to be missing this flag, and atleast on the DRA7 EVM
where we use uart1 for console, boot fails with DEBUG_LL enabled.

Reported-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index db32d53..18f333c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1637,7 +1637,7 @@ static struct omap_hwmod dra7xx_uart1_hwmod = {
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.main_clk	= "uart1_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
+	.flags		= HWMOD_SWSUP_SIDLE_ACT | DEBUG_OMAP2UART1_FLAGS,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_UART1_CLKCTRL_OFFSET,
-- 
1.7.9.5
