From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 3/5] ARM: dts: am43xx-epos-evm: Add matrix keypad as wakeup source
Date: Fri, 29 Mar 2019 12:53:34 -0500
Message-ID: <20190329175336.19824-3-afd@ti.com>
References: <20190329175336.19824-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329175336.19824-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

Mark matrix-keypad as a wakeup source.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 606b848d809f..9b8b132b04e1 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -80,6 +80,7 @@
 		pinctrl-names = "default", "sleep";
 		pinctrl-0 = <&matrix_keypad_default>;
 		pinctrl-1 = <&matrix_keypad_sleep>;
+		wakeup-source;
 
 		row-gpios = <&gpio0 12 GPIO_ACTIVE_HIGH		/* Bank0, pin12 */
 			     &gpio0 13 GPIO_ACTIVE_HIGH		/* Bank0, pin13 */
-- 
2.21.0
