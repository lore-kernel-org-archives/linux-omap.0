From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 4/8] ARM: dts: am335x-sl50: set dr_mode to otg
Date: Wed,  6 Jun 2018 17:54:09 +0200
Message-ID: <20180606155413.23542-4-enric.balletbo@collabora.com>
References: <20180606155413.23542-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606155413.23542-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The board can be either a host, or a peripheral, so set the controller as
OTG mode to reflect this.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm/boot/dts/am335x-sl50.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index ea047b85b726..1eabea4507aa 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -473,7 +473,7 @@
 
 &usb0 {
 	status = "okay";
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 };
 
 &usb1 {
-- 
2.17.1
