From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v8 7/8] can: c_can: Add support for TI DRA7 DCAN
Date: Fri, 14 Nov 2014 19:09:50 +0100
Message-ID: <1415988591-6032-8-git-send-email-mkl@pengutronix.de>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: wsa@the-dreams.de, linux-omap@vger.kernel.org, rogerq@ti.com, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

DRA7 SoC has 2 CAN IPs. Provide compatible IDs and RAMINIT
register data for both.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/c_can.txt |  1 +
 drivers/net/can/c_can/c_can_platform.c              | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
index a3ca3ee53546..f682fdb6d921 100644
--- a/Documentation/devicetree/bindings/net/can/c_can.txt
+++ b/Documentation/devicetree/bindings/net/can/c_can.txt
@@ -4,6 +4,7 @@ Bosch C_CAN/D_CAN controller Device Tree Bindings
 Required properties:
 - compatible		: Should be "bosch,c_can" for C_CAN controllers and
 			  "bosch,d_can" for D_CAN controllers.
+			  Can be "ti,dra7-d_can".
 - reg			: physical base address and size of the C_CAN/D_CAN
 			  registers map
 - interrupts		: property with a value describing the interrupt
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 41fa460c3592..570da5f56aae 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -190,6 +190,18 @@ static const struct c_can_driver_data d_can_drvdata = {
 	.id = BOSCH_D_CAN,
 };
 
+static const struct raminit_bits dra7_raminit_bits[] = {
+	[0] = { .start = 3, .done = 1, },
+	[1] = { .start = 5, .done = 2, },
+};
+
+static const struct c_can_driver_data dra7_dcan_drvdata = {
+	.id = BOSCH_D_CAN,
+	.raminit_num = ARRAY_SIZE(dra7_raminit_bits),
+	.raminit_bits = dra7_raminit_bits,
+	.raminit_pulse = true,
+};
+
 static struct platform_device_id c_can_id_table[] = {
 	{
 		.name = KBUILD_MODNAME,
@@ -210,6 +222,7 @@ MODULE_DEVICE_TABLE(platform, c_can_id_table);
 static const struct of_device_id c_can_of_table[] = {
 	{ .compatible = "bosch,c_can", .data = &c_can_drvdata },
 	{ .compatible = "bosch,d_can", .data = &d_can_drvdata },
+	{ .compatible = "ti,dra7-d_can", .data = &dra7_dcan_drvdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, c_can_of_table);
-- 
2.1.1

