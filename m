From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH] ARM: dts: am335x-sancloud-bbe: fix phy mode
Date: Sun,  1 Dec 2019 17:07:06 +0000
Message-ID: <20191201170706.7173-1-mans@mansr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The phy mode should be rgmii-id.  For some reason, it used to work with
rgmii-txid but doesn't any more.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/boot/dts/am335x-sancloud-bbe.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-sancloud-bbe.dts b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
index 8678e6e35493..e5fdb7abb0d5 100644
--- a/arch/arm/boot/dts/am335x-sancloud-bbe.dts
+++ b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
@@ -108,7 +108,7 @@
 
 &cpsw_emac0 {
 	phy-handle = <&ethphy0>;
-	phy-mode = "rgmii-txid";
+	phy-mode = "rgmii-id";
 };
 
 &i2c0 {
-- 
2.24.0
