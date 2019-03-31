From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [BUG/PATCH 3/4] gpiolib: make legacy handling for spi-cs-high optional
Date: Sun, 31 Mar 2019 12:07:22 +0200
Message-ID: <83b5c3ddee26c6f5e4b3b21d8a4346da5956de11.1554026842.git.hns@goldelico.com>
References: <cover.1554026842.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1554026842.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

It is better to make legacy support a config option instead
of requiring non-legacy device tree files to be updated.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/Kconfig      | 8 ++++++++
 drivers/gpio/gpiolib-of.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3f50526a771f..1a82619727c1 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -39,6 +39,14 @@ config OF_GPIO
 	depends on OF
 	depends on HAS_IOMEM
 
+config SPI_CS_HIGH_LEGACY_HANDLING
+	def_bool n
+	depends on OF_GPIO
+	help
+	   This enables a legacy handler which decodes the boolean spi-cs-high
+	   property found in some DTS/DTB to correctly work with cs-gpios
+	   with GPIO_ACTIVE_HIGH.
+
 config GPIO_ACPI
 	def_bool y
 	depends on ACPI
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 8b9c3ab70f6e..a22d2233458b 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -114,6 +114,7 @@ static void of_gpio_flags_quirks(struct device_node *np,
 			of_node_full_name(np));
 	}
 
+#if defined(CONFIG_SPI_CS_HIGH_LEGACY_HANDLING)
 	/*
 	 * Legacy handling of SPI active high chip select. If we have a
 	 * property named "cs-gpios" we need to inspect the child node
@@ -158,6 +159,7 @@ static void of_gpio_flags_quirks(struct device_node *np,
 			}
 		}
 	}
+#endif
 }
 
 /**
-- 
2.19.1
