From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] ARM: OMAP5: Add HWMOD_SWSUP_SIDLE_ACT flag for UART
Date: Wed, 18 Jan 2017 17:18:07 +0530
Message-ID: <20170118114807.9543-1-vigneshr@ti.com>
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
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

According to the commit ca43ea345de9 ("ARM: OMAP2+: hwmod: Add a new
flag to handle SIDLE in SWSUP only in active"), UART IP needs the sidle
mode to be controlled in SW only while they are active. Once inactive,
the IP needs to be put back in HW control so they are also wakeup
capable. The flag HWMOD_SWSUP_SIDLE takes care of this. So add this flag
to all instances of UART.

With this change, 8250 UART now gives out proper RX Timeout interrupts
and is usable as console.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

Tested on OMAP5 uEVM.

 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 8cdfd9b7ab4f..a2d763a4cc57 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -1748,6 +1748,7 @@ static struct omap_hwmod omap54xx_uart1_hwmod = {
 	.name		= "uart1",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1763,6 +1764,7 @@ static struct omap_hwmod omap54xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1778,7 +1780,7 @@ static struct omap_hwmod omap54xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.flags		= DEBUG_OMAP4UART3_FLAGS,
+	.flags		= DEBUG_OMAP4UART3_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1794,7 +1796,7 @@ static struct omap_hwmod omap54xx_uart4_hwmod = {
 	.name		= "uart4",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.flags		= DEBUG_OMAP4UART4_FLAGS,
+	.flags		= DEBUG_OMAP4UART4_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1810,6 +1812,7 @@ static struct omap_hwmod omap54xx_uart5_hwmod = {
 	.name		= "uart5",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1825,6 +1828,7 @@ static struct omap_hwmod omap54xx_uart6_hwmod = {
 	.name		= "uart6",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
-- 
2.11.0
