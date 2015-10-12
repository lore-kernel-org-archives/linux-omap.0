From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] ARM: DTS: am335x: fix cd-gpios definition as per hardware design and dt binding docs
Date: Mon, 12 Oct 2015 14:37:10 +0530
Message-ID: <1444640832-7396-2-git-send-email-mugunthanvnm@ti.com>
References: <1444640832-7396-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444640832-7396-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

As per mmc device tree binding documentation card detect gpio has
to be active low signal. When a hardware is designed with active
high card detect, gpio polarity has to be changed with
cd-inverted dt property.

In AM335x the card detect gpio is designed as active low gpio.
So correcting the dt card detect gpio definition.

Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 3 +--
 arch/arm/boot/dts/am335x-evm.dts          | 2 +-
 arch/arm/boot/dts/am335x-evmsk.dts        | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index fec7834..5d370d5 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -383,8 +383,7 @@
 	bus-width = <0x4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 };
 
 &aes {
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 1942a5c..d9d00ab 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -737,7 +737,7 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 };
 
 &mmc3 {
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 315bb02..89442e9 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -647,7 +647,7 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 };
 
 &sham {
-- 
2.6.1.133.gf5b6079

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
