From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 2/2] ARM: dts: am335x-icev2: Add nodes for gpio-decoder
Date: Tue, 23 Aug 2016 11:46:49 +0530
Message-ID: <20160823061649.3394-3-vigneshr@ti.com>
References: <20160823061649.3394-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160823061649.3394-1-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <moritz.fischer@ettus.com>, John Stultz <john.stultz@linaro.org>, Vignesh R <vigneshr@ti.com>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Daniel Hung-yu Wu <hywu@google.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Grant Grundler <grundler@chromium.org>, Rob Herring <robh+dt@kernel.org>, S Twiss <stwiss.opensource@diasemi.com>, linux-input@vger.kernel.org, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

AM335x ICE board has a rotary-switch connected to PCA9536 I2C GPIO
expander. The position of the rotary-switch is reflected by status of
GPIO lines. Add gpio-decoder node to read these GPIO line status via
gpio-decoder driver and report it as an input event to the system.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v2: Update DT node name.

 arch/arm/boot/dts/am335x-icev2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index bc0190e4f10f..d3c53e5910c4 100644
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
+		decoder,max-value = <9>;
+	};
 };
 
 &am33xx_pinmux {
-- 
2.9.2
