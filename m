From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 8/8] ARM: dts: am57xx-idk: Enable dual-role mode for USB2
Date: Mon, 23 Jan 2017 13:19:41 +0200
Message-ID: <1485170381-32110-9-git-send-email-rogerq@ti.com>
References: <1485170381-32110-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485170381-32110-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, tony@atomide.com
Cc: peter.chen@freescale.com, vivek.gautam@codeaurora.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

USB port is micro-AB type and can function as peripheral
as well as host. Enable dual-role mode for USB2.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 814a720..14bdb24 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -376,7 +376,7 @@
 };
 
 &usb2 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 };
 
 &mmc2 {
-- 
2.7.4
