From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [BUG/PATCH 4/4] gpiolib: spi-cs-high is checking the wrong node (the controller and not the SPI slave device)
Date: Sun, 31 Mar 2019 12:07:23 +0200
Message-ID: <d62f14663194f3a5fc967cd238e93846a563a4e2.1554026842.git.hns@goldelico.com>
References: <cover.1554026842.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1554026842.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Bindings say:

All slave nodes can contain the following optional properties:
- spi-cs-high     - Empty property indicating device requires chip select
		    active high.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpiolib-of.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index a22d2233458b..82e7a1f63b0a 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -143,16 +143,16 @@ static void of_gpio_flags_quirks(struct device_node *np,
 				 * conflict and the "spi-cs-high" flag will
 				 * take precedence.
 				 */
-				if (of_property_read_bool(np, "spi-cs-high")) {
+				if (of_property_read_bool(child, "spi-cs-high")) {
 					if (*flags & OF_GPIO_ACTIVE_LOW) {
 						pr_warn("%s GPIO handle specifies active low - ignored\n",
-							of_node_full_name(np));
+							of_node_full_name(child));
 						*flags &= ~OF_GPIO_ACTIVE_LOW;
 					}
 				} else {
 					if (!(*flags & OF_GPIO_ACTIVE_LOW))
 						pr_info("%s enforce active low on chipselect handle\n",
-							of_node_full_name(np));
+							of_node_full_name(child));
 					*flags |= OF_GPIO_ACTIVE_LOW;
 				}
 				break;
-- 
2.19.1
