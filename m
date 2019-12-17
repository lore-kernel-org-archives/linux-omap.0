From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/3] ARM: dts: am571x-idk: Fix gpios property to have the correct  gpio number
Date: Tue, 17 Dec 2019 14:21:23 +0530
Message-ID: <20191217085124.22480-3-kishon@ti.com>
References: <20191217085124.22480-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217085124.22480-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

commit d23f3839fe97d8dce03d ("ARM: dts: DRA7: Add pcie1 dt node for
EP mode") while adding the dt node for EP mode for DRA7 platform,
added rc node for am571x-idk and populated gpios property with
"gpio3 23". However the GPIO_PCIE_SWRST line is actually connected
to "gpio5 18". Fix it here. (The patch adding "gpio3 23" was tested
with another am57x board in EP mode which doesn't rely on reset from
host).

Fixes: d23f3839fe97d8dce03d ("ARM: dts: DRA7: Add pcie1 dt node for
EP mode")
Cc: stable <stable@vger.kernel.org> # 4.14+

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index 67239f7c22b8..669559c9c95b 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -167,7 +167,7 @@
 
 &pcie1_rc {
 	status = "okay";
-	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+	gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
 };
 
 &mmc1 {
-- 
2.17.1
