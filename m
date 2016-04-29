From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
Date: Fri, 29 Apr 2016 13:21:37 +0300
Message-ID: <1461925297-9734-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

ldo7_reg should not work as regulator since it is set to 'disabled' state
in the omap5-board-common.dtsi and the state is not changed to 'okay'
this means that the ldo7_reg is not available to be used in the igep0050
DTS file.
ldo4_reg is used by all other OMAP5 boards and this is most likely the
correct regulator to use with hdmi.
The hdmi needs 1.8V, but the ldo7_reg, based on the dtsi is 2V only.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Tony,

I don't have access to the schematics, but I believe tha the ldo7_reg is not the
correct regulator to be used for hdmi.

If you have access and it is really ldo7_reg, then we should have this in the
omap5-igep0050.dts file:

&ldo5_reg {
	status = "okay";
	regulator-min-microvolt = <1800000>;
	regulator-max-microvolt = <1800000>;
};

Regards,
Peter

 arch/arm/boot/dts/omap5-igep0050.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
index 46ecb1dd3b5c..6c8d40327c68 100644
--- a/arch/arm/boot/dts/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/omap5-igep0050.dts
@@ -20,7 +20,7 @@
 };
 
 &hdmi {
-	vdda-supply = <&ldo7_reg>;
+	vdda-supply = <&ldo4_reg>;
 };
 
 &i2c4 {
-- 
2.8.1
