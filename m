From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/1] ARM: dts: dra7x-evm: Enable dual-role mode for USB1
Date: Tue, 11 Apr 2017 16:16:15 +0300
Message-ID: <1491916575-16023-2-git-send-email-rogerq@ti.com>
References: <1491916575-16023-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491916575-16023-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

USB1 port is micro-AB type and can function as peripheral
as well as host. Enable dual-role mode for USB1.

We don't want to use the OTG controller block on this
platform as it limits host mode to high-speed. Instead
we rely on extcon framework to give us ID events for
dual-role mode detection.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7-evm.dts          | 3 ++-
 arch/arm/boot/dts/dra72-evm-common.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 4bc4b57..c408aaa 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -527,7 +527,8 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	extcon = <&extcon_usb1>;
 };
 
 &usb2 {
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index ad24544..8578054 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -392,7 +392,8 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	extcon = <&extcon_usb1>;
 };
 
 &usb2 {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
