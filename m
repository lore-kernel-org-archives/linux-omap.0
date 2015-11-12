From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] extcon: palmas: add support for using VBUSDET output
Date: Thu, 12 Nov 2015 11:57:14 -0600
Message-ID: <1447351034-21150-1-git-send-email-balbi@ti.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447350781-20649-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

TPS659038 can remux its GPIO_1 as VBUSDET output,
which can be tied to a SoC GPIO and used as a VBUS
interrupt.

Beagle X15 uses that, in fact, and without it, I
could not get USB peripheral working with that
board.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/extcon/extcon-palmas.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 93c30a885740..7985d092c069 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -296,10 +296,28 @@ static int palmas_usb_probe(struct platform_device *pdev)
 	}
 
 	if (palmas_usb->enable_vbus_detection) {
+		int irq = platform_get_irq(pdev, 0);
+
+		if (irq > 0) {
+			/* remux GPIO_1 as VBUSDET */
+			status = palmas_update_bits(palmas, PALMAS_PU_PD_OD_BASE,
+					PALMAS_PRIMARY_SECONDARY_PAD1,
+					PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_MASK,
+					(1 << 3));
+			if (status < 0) {
+				dev_err(&pdev->dev, "can't remux GPIO1\n");
+				return status;
+			}
+
+			palmas_usb->vbus_irq = irq;
+		} else {
+			irq = regmap_irq_get_virq(palmas->irq_data,
+					PALMAS_VBUS_IRQ);
+			palmas_usb->vbus_irq = irq;
+		}
+
 		palmas_usb->vbus_otg_irq = regmap_irq_get_virq(palmas->irq_data,
 						       PALMAS_VBUS_OTG_IRQ);
-		palmas_usb->vbus_irq = regmap_irq_get_virq(palmas->irq_data,
-							   PALMAS_VBUS_IRQ);
 		status = devm_request_threaded_irq(palmas_usb->dev,
 				palmas_usb->vbus_irq, NULL,
 				palmas_vbus_irq_handler,
-- 
2.6.2
