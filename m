From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v8 8/8] can: c_can: Add support for TI am3352 DCAN
Date: Fri, 14 Nov 2014 19:09:51 +0100
Message-ID: <1415988591-6032-9-git-send-email-mkl@pengutronix.de>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: wsa@the-dreams.de, linux-omap@vger.kernel.org, rogerq@ti.com, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

AM3352 SoC has 2 DCAN modules. Add compatible id and
raminit driver data for am3352 DCAN.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/c_can.txt |  2 +-
 drivers/net/can/c_can/c_can_platform.c              | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
index f682fdb6d921..6731730eec0d 100644
--- a/Documentation/devicetree/bindings/net/can/c_can.txt
+++ b/Documentation/devicetree/bindings/net/can/c_can.txt
@@ -4,7 +4,7 @@ Bosch C_CAN/D_CAN controller Device Tree Bindings
 Required properties:
 - compatible		: Should be "bosch,c_can" for C_CAN controllers and
 			  "bosch,d_can" for D_CAN controllers.
-			  Can be "ti,dra7-d_can".
+			  Can be "ti,dra7-d_can" or "ti,am3352-d_can".
 - reg			: physical base address and size of the C_CAN/D_CAN
 			  registers map
 - interrupts		: property with a value describing the interrupt
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 570da5f56aae..f4488e5d5d68 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -202,6 +202,17 @@ static const struct c_can_driver_data dra7_dcan_drvdata = {
 	.raminit_pulse = true,
 };
 
+static const struct raminit_bits am3352_raminit_bits[] = {
+	[0] = { .start = 0, .done = 8, },
+	[1] = { .start = 1, .done = 9, },
+};
+
+static const struct c_can_driver_data am3352_dcan_drvdata = {
+	.id = BOSCH_D_CAN,
+	.raminit_num = ARRAY_SIZE(am3352_raminit_bits),
+	.raminit_bits = am3352_raminit_bits,
+};
+
 static struct platform_device_id c_can_id_table[] = {
 	{
 		.name = KBUILD_MODNAME,
@@ -223,6 +234,7 @@ static const struct of_device_id c_can_of_table[] = {
 	{ .compatible = "bosch,c_can", .data = &c_can_drvdata },
 	{ .compatible = "bosch,d_can", .data = &d_can_drvdata },
 	{ .compatible = "ti,dra7-d_can", .data = &dra7_dcan_drvdata },
+	{ .compatible = "ti,am3352-d_can", .data = &am3352_dcan_drvdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, c_can_of_table);
-- 
2.1.1

