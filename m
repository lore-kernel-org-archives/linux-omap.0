From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
Date: Wed, 23 Jan 2013 18:56:51 +0100
Message-ID: <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>
List-Id: linux-omap@vger.kernel.org

Convert the on-board LED connected to the TWL4030 (LEDB) to use
pwm-leds.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index 89808ce..800be29 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -14,12 +14,13 @@
 /include/ "omap3.dtsi"
 
 / {
-	leds {
-		compatible = "gpio-leds";
+	pwmleds {
+		compatible = "pwm-leds";
+
 		overo {
 			label = "overo:blue:COM";
-			gpios = <&twl_gpio 19 0>;
-			linux,default-trigger = "mmc0";
+			pwms = <&twl_pwmled 1 7812500>;
+			max-brightness = <127>;
 		};
 	};
 };
-- 
1.7.5.4
