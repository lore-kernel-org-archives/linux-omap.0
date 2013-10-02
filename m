From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] ARM: dts: AM33XX: add ethernet alias's for am33xx
Date: Wed, 2 Oct 2013 12:58:33 -0500
Message-ID: <1380736713-24678-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mugunthanvnm@ti.com, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

Set the alias for ethernet0 and ethernet1 so that uBoot
can set the MAC address appropriately.

Currently uBoot cannot find the alias and there for does not set the
MAC address.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 553adc6..8aabaa0 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -30,6 +30,8 @@
 		usb1 = &usb1;
 		phy0 = &usb0_phy;
 		phy1 = &usb1_phy;
+		ethernet0 = &cpsw_emac0;
+		ethernet1 = &cpsw_emac1;
 	};
 
 	cpus {
-- 
1.7.9.5
