From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP1: Fix section mismatch warnings for omap_cfg_reg
Date: Thu, 21 May 2015 11:42:07 -0700
Message-ID: <1432233727-14311-1-git-send-email-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is cleary used after init time too for example for
configuring UART wake-up events during runtime.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/mux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 667ce50..599490a 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -36,7 +36,7 @@
 static struct omap_mux_cfg arch_mux_cfg;
 
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-static struct pin_config __initdata_or_module omap7xx_pins[] = {
+static struct pin_config omap7xx_pins[] = {
 MUX_CFG_7XX("E2_7XX_KBR0",        12,   21,    0,   20,   1, 0)
 MUX_CFG_7XX("J7_7XX_KBR1",        12,   25,    0,   24,   1, 0)
 MUX_CFG_7XX("E1_7XX_KBR2",        12,   29,    0,   28,   1, 0)
@@ -82,7 +82,7 @@ MUX_CFG_7XX("UART_7XX_2",          8,    1,    6,    0,   0, 0)
 #endif	/* CONFIG_ARCH_OMAP730 || CONFIG_ARCH_OMAP850 */
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
-static struct pin_config __initdata_or_module omap1xxx_pins[] = {
+static struct pin_config omap1xxx_pins[] = {
 /*
  *	 description		mux  mode   mux	 pull pull  pull  pu_pd	 pu  dbg
  *				reg  offset mode reg  bit   ena	  reg
@@ -343,7 +343,7 @@ MUX_CFG("Y14_1610_CCP_DATAM",	 9,   21,    6,   2,   3,   1,    2,     0,  0)
 #define OMAP1XXX_PINS_SZ	0
 #endif	/* CONFIG_ARCH_OMAP15XX || CONFIG_ARCH_OMAP16XX */
 
-static int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
+static int omap1_cfg_reg(const struct pin_config *cfg)
 {
 	static DEFINE_SPINLOCK(mux_spin_lock);
 	unsigned long flags;
@@ -469,7 +469,7 @@ int __init omap_mux_register(struct omap_mux_cfg *arch_mux_cfg)
 /*
  * Sets the Omap MUX and PULL_DWN registers based on the table
  */
-int __init_or_module omap_cfg_reg(const unsigned long index)
+int omap_cfg_reg(const unsigned long index)
 {
 	struct pin_config *reg;
 
-- 
2.1.4
