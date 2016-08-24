From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 2/2] ARM: dts: am335x-icev2: Add nodes for gpio-decoder
Date: Wed, 24 Aug 2016 13:28:59 +0530
Message-ID: <20160824075859.30979-3-vigneshr@ti.com>
References: <20160824075859.30979-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160824075859.30979-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Daniel Hung-yu Wu <hywu@google.com>, Grant Grundler <grundler@chromium.org>, S Twiss <stwiss.opensource@diasemi.com>, Vignesh R <vigneshr@ti.com>, Moritz Fischer <moritz.fischer@ettus.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, John Stultz <john.stultz@linaro.org>, "Andrew F . Davis" <afd@ti.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

AM335x ICE board has a rotary-switch connected to PCA9536 I2C GPIO
expander. The position of the rotary-switch is reflected by status of
GPIO lines. Add gpio-decoder node to read these GPIO line status via
gpio-decoder driver and report it as an input event to the system.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v3: s/decoder,max-value/decoder-max-value

 arch/arm/boot/dts/am335x-icev2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index bc0190e4f10f..426022ee85c7 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -139,6 +139,15 @@
 			default-state = "off";
 		};
 	};
+	gpio-decoder {
+		compatible = "gpio-decoder";
+		gpios = <&pca9536 3 GPIO_ACTIVE_HIGH>,
+			<&pca9536 2 GPIO_ACTIVE_HIGH>,
+			<&pca9536 1 GPIO_ACTIVE_HIGH>,
+			<&pca9536 0 GPIO_ACTIVE_HIGH>;
+		linux,axis = <0>; /* ABS_X */
+		decoder-max-value = <9>;
+	};
 };
 
 &am33xx_pinmux {
-- 
2.9.2
