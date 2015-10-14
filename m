From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2] ARM: dts: am437x-gp-evm: Add wakeup interrupt source for pixcir_i2c_ts
Date: Wed, 14 Oct 2015 19:24:25 +0530
Message-ID: <1444830865-30899-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Roger Quadros <rogerq@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

On am437x-gp-evm, pixcir_i2c_ts can wakeup the system from low power
state via pinctrl and IO daisy chain using generic wakeirq framework.
With commit 3fffd1283927 ("i2c: allow specifying separate wakeup
interrupt in device tree") i2c core allows optional wakeirq to be
specified via device tree. Add wakeup irq entry to enable pixcir_i2c_ts
to wake the system from low power state.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

Since v1:
 - correct interrupt flag.
 - add comment wrt wakeup interrupt.

 arch/arm/boot/dts/am437x-gp-evm.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 22038f21f228..9c324b5f09ac 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -581,8 +581,17 @@
 
 		attb-gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 
+		/*
+		 * 0x264 represents the offset of padconf register of
+		 * gpio3_22 from am43xx_pinmux base.
+		 */
+		interrupts-extended = <&gpio3 22 IRQ_TYPE_NONE>,
+				      <&am43xx_pinmux 0x264>;
+		interrupt-names = "tsc", "wakeup";
+
 		touchscreen-size-x = <1024>;
 		touchscreen-size-y = <600>;
+		wakeup-source;
 	};
 
 	ov2659@30 {
-- 
2.6.1
