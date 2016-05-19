From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/2] gpio: pca953x: Add support for TI PCA9536
Date: Thu, 19 May 2016 12:17:29 +0530
Message-ID: <1463640450-16762-2-git-send-email-vigneshr@ti.com>
References: <1463640450-16762-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1463640450-16762-1-git-send-email-vigneshr@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

TI PCA9536 is 4-Bit I2C GPIO expander without interrupt support[1].
Add support for the same.

[1] TRM: http://www.ti.com/lit/ds/symlink/pca9536.pdf

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/gpio/gpio-pca953x.txt | 1 +
 drivers/gpio/gpio-pca953x.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
index 6b4a98f74be3..08dd15f89ba9 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
@@ -21,6 +21,7 @@ Required properties:
 	maxim,max7313
 	maxim,max7315
 	ti,pca6107
+	ti,pca9536
 	ti,tca6408
 	ti,tca6416
 	ti,tca6424
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 5e3be32ebb8d..763028562d22 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -861,6 +861,7 @@ static const struct of_device_id pca953x_dt_ids[] = {
 	{ .compatible = "maxim,max7315", .data = OF_953X( 8, PCA_INT), },
 
 	{ .compatible = "ti,pca6107", .data = OF_953X( 8, PCA_INT), },
+	{ .compatible = "ti,pca9536", .data = OF_953X( 4, 0), },
 	{ .compatible = "ti,tca6408", .data = OF_953X( 8, PCA_INT), },
 	{ .compatible = "ti,tca6416", .data = OF_953X(16, PCA_INT), },
 	{ .compatible = "ti,tca6424", .data = OF_953X(24, PCA_INT), },
-- 
2.8.2

