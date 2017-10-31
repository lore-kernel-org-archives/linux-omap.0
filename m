From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] ARM: dts: dra7: Disable USB metastability workaround for USB2
Date: Tue, 31 Oct 2017 15:26:00 +0200
Message-ID: <1509456360-2638-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: balbi@kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The metastability workaround causes Erratic errors [1]
on the HighSpeed USB PHY which can cause upto 2 seconds
delay in enumerating to a USB host while in Gadget mode.

Disable the Run/Stop metastability workaround to avoid this
ill effect. We are aware that this opens up the opportunity
for Run/Stop metastability, however this issue has never been
observed in TI releases so we think that Run/Stop metastability
is a lesser evil than the PHY Erratic errors. So disable it.

[1] USB controller trace during gadget enumeration
    irq/90-dwc3-969   [000] d...    52.323145: dwc3_event: event (00000901): Erratic Error [U0]
    irq/90-dwc3-969   [000] d...    52.560646: dwc3_event: event (00000901): Erratic Error [U0]
    irq/90-dwc3-969   [000] d...    52.798144: dwc3_event: event (00000901): Erratic Error [U0]

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 02a136a..1264e39 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1540,6 +1540,7 @@
 				dr_mode = "otg";
 				snps,dis_u3_susphy_quirk;
 				snps,dis_u2_susphy_quirk;
+				snps,dis_metastability_quirk;
 			};
 		};
 
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
