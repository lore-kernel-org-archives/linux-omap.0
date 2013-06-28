From: Hebbar Gururaja <gururaja.hebbar@ti.com>
Subject: [PATCH 4/4] ARM: dts: AM33XX: update rtc node compatibility
Date: Fri, 28 Jun 2013 15:05:09 +0530
Message-ID: <1372412109-986-5-git-send-email-gururaja.hebbar@ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@linaro.org, tony@atomide.com, b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, vaibhav.bedia@ti.com, sudhakar.raj@ti.com, gururaja.hebbar@ti.com, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Since AM33xx  RTC IP has RTC_IRQWAKEEN to support Alarm Wake-up.

Update the rtc compatible property to "ti,am3352-rtc" to enable handling
of this feature inside rtc-omap driver.

Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: b-cousson@ti.com
---
:100644 100644 77aa1b0... dde180a... M	arch/arm/boot/dts/am33xx.dtsi
 arch/arm/boot/dts/am33xx.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 77aa1b0..dde180a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -297,7 +297,7 @@
 		};
 
 		rtc@44e3e000 {
-			compatible = "ti,da830-rtc";
+			compatible = "ti,am3352-rtc";
 			reg = <0x44e3e000 0x1000>;
 			interrupts = <75
 				      76>;
-- 
1.7.9.5
