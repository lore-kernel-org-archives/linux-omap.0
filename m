From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 01/11] pinctrl: exynos: Add BUS1 pin controller for exynos7
Date: Fri, 21 Nov 2014 19:05:44 +0530
Message-ID: <1416576954-11997-2-git-send-email-gautam.vivek@samsung.com>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, balbi@ti.com, kishon@ti.com
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, tomasz.figa@gmail.com, s.nawrocki@samsung.com, robh+dt@kernel.org, stern@rowland.harvard.edu, kgene.kim@samsung.com, Vivek Gautam <gautam.vivek@samsung.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

USB and Power regulator on Exynos7 require gpios available
in BUS1 pin controller block.
So adding the BUS1 pinctrl support.

Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index d5d4cfc..caca5b5 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -1300,6 +1300,13 @@ static const struct samsung_pin_bank_data exynos7_pin_banks7[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpr3", 0x0c),
 };
 
+/* pin banks of exynos7 pin-controller - BUS1 */
+static const struct samsung_pin_bank_data exynos7_pin_banks8[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpf0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpf4", 0x10),
+	EXYNOS_PIN_BANK_EINTG(6, 0x120, "gph1", 0x20),
+};
+
 const struct samsung_pin_ctrl exynos7_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 Alive data */
@@ -1342,5 +1349,10 @@ const struct samsung_pin_ctrl exynos7_pin_ctrl[] __initconst = {
 		.pin_banks	= exynos7_pin_banks7,
 		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks7),
 		.eint_gpio_init = exynos_eint_gpio_init,
+	}, {
+		/* pin-controller instance 8 BUS1 data */
+		.pin_banks	= exynos7_pin_banks8,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks8),
+		.eint_gpio_init = exynos_eint_gpio_init,
 	},
 };
-- 
1.7.10.4
