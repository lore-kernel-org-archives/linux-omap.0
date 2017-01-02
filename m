From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/3] ARM: OMAP1: USB: tidy up logging output
Date: Mon,  2 Jan 2017 22:57:03 +0200
Message-ID: <20170102205705.19001-1-aaro.koskinen@iki.fi>
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
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

KERN_CONT/pr_cont is now required to continue log messages, use that.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/usb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 2506e59..d4aa118 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -95,17 +95,17 @@ omap_otg_init(struct omap_usb_config *config)
 
 	printk("USB: hmc %d", config->hmc_mode);
 	if (!alt_pingroup)
-		printk(", usb2 alt %d wires", config->pins[2]);
+		pr_cont(", usb2 alt %d wires", config->pins[2]);
 	else if (config->pins[0])
-		printk(", usb0 %d wires%s", config->pins[0],
+		pr_cont(", usb0 %d wires%s", config->pins[0],
 			is_usb0_device(config) ? " (dev)" : "");
 	if (config->pins[1])
-		printk(", usb1 %d wires", config->pins[1]);
+		pr_cont(", usb1 %d wires", config->pins[1]);
 	if (!alt_pingroup && config->pins[2])
-		printk(", usb2 %d wires", config->pins[2]);
+		pr_cont(", usb2 %d wires", config->pins[2]);
 	if (config->otg)
-		printk(", Mini-AB on usb%d", config->otg - 1);
-	printk("\n");
+		pr_cont(", Mini-AB on usb%d", config->otg - 1);
+	pr_cont("\n");
 
 	if (cpu_class_is_omap1()) {
 		u16 w;
@@ -573,13 +573,13 @@ static void __init omap_1510_usb_init(struct omap_usb_config *config)
 
 	printk("USB: hmc %d", config->hmc_mode);
 	if (config->pins[0])
-		printk(", usb0 %d wires%s", config->pins[0],
+		pr_cont(", usb0 %d wires%s", config->pins[0],
 			is_usb0_device(config) ? " (dev)" : "");
 	if (config->pins[1])
-		printk(", usb1 %d wires", config->pins[1]);
+		pr_cont(", usb1 %d wires", config->pins[1]);
 	if (config->pins[2])
-		printk(", usb2 %d wires", config->pins[2]);
-	printk("\n");
+		pr_cont(", usb2 %d wires", config->pins[2]);
+	pr_cont("\n");
 
 	/* use DPLL for 48 MHz function clock */
 	pr_debug("APLL %04x DPLL %04x REQ %04x\n", omap_readw(ULPD_APLL_CTRL),
-- 
2.9.2
