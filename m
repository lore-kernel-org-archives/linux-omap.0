From: Vignesh R <vigneshr@ti.com>
Subject: [RFC PATCH 2/2] ARM: dts: am335x-icev2: Add rotary-encoder node
Date: Thu, 19 May 2016 14:34:01 +0530
Message-ID: <1463648641-6931-3-git-send-email-vigneshr@ti.com>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Moritz Fischer <moritz.fischer@ettus.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Vignesh R <vigneshr@ti.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Sylvain Rochet <sylvain.rochet@finsecur.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, Johan Hovold <johan@kernel.org>, Timo Teras <timo.teras@iki.fi>, Masanari Iida <standby24x7@gmail.com>, devicetree@vger.kernel.org, S Twiss <stwiss.opensource@diasemi.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Clifton Barnes <clifton.a.barnes@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-omap@vger.kernel.org, Guido Martinez <guido@vanguardiasur.com.ar>
List-Id: linux-omap@vger.kernel.org

AM335x ICE board has a rotary-encoder connected to PCA9536 I2C GPIO
expander. Add DT entry for the same.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

depends on patches to Add TI PCA9536 node posted to linux-gpio:
http://www.spinics.net/lists/arm-kernel/msg505194.html

 arch/arm/boot/dts/am335x-icev2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index 7d8b8fefdf08..672dccbf203d 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -139,6 +139,17 @@
 			default-state = "off";
 		};
 	};
+
+	rotary-in0 {
+		compatible = "rotary-encoder";
+		gpios = <&pca9536 3 GPIO_ACTIVE_HIGH>,
+			<&pca9536 2 GPIO_ACTIVE_HIGH>,
+			<&pca9536 1 GPIO_ACTIVE_HIGH>,
+			<&pca9536 0 GPIO_ACTIVE_HIGH>;
+		linux,axis = <0>; /* ABS_X */
+		rotary-encoder,steps = <10>;
+		rotary-encoder,absolute-encoder;
+	};
 };
 
 &am33xx_pinmux {
-- 
2.8.2
