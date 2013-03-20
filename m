From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 07/21] ARM: OMAP: AM3517crane: Adapt to ehci-omap changes
Date: Wed, 20 Mar 2013 17:44:46 +0200
Message-ID: <1363794300-31526-8-git-send-email-rogerq@ti.com>
References: <1363794300-31526-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1363794300-31526-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Use usbhs_init_phys() to register the PHY's VCC and RESET
regulators and the NOP PHY device.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 7d3358b..fc53911 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -47,15 +47,17 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
+static struct usbhs_phy_data phy_data[] __initdata = {
+	{
+		.port = 1,
+		.reset_gpio = GPIO_USB_NRESET,
+		.vcc_gpio = GPIO_USB_POWER,
+		.vcc_polarity = 1,
+	},
+};
+
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
-	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
-	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
-
-	.phy_reset  = true,
-	.reset_gpio_port[0]  = GPIO_USB_NRESET,
-	.reset_gpio_port[1]  = -EINVAL,
-	.reset_gpio_port[2]  = -EINVAL
 };
 
 static struct mtd_partition crane_nand_partitions[] = {
@@ -131,13 +133,7 @@ static void __init am3517_crane_init(void)
 		return;
 	}
 
-	ret = gpio_request_one(GPIO_USB_POWER, GPIOF_OUT_INIT_HIGH,
-			       "usb_ehci_enable");
-	if (ret < 0) {
-		pr_err("Can not request GPIO %d\n", GPIO_USB_POWER);
-		return;
-	}
-
+	usbhs_init_phys(phy_data, ARRAY_SIZE(phy_data));
 	usbhs_init(&usbhs_bdata);
 	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1);
 }
-- 
1.7.4.1
