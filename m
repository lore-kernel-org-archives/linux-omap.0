From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/3] ARM: dts: da850: Add the cppi41 dma node
Date: Mon,  9 Jan 2017 17:24:47 +0100
Message-ID: <20170109162449.5012-2-abailon@baylibre.com>
References: <20170109162449.5012-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109162449.5012-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This adds the device tree node for the cppi41 dma
used by the usb otg controller present in the da850 family of SoC's.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 arch/arm/boot/dts/da850.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 104155d..d6b406a 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -403,6 +403,22 @@
 			phy-names = "usb-phy";
 			status = "disabled";
 		};
+		cppi41dma: dma-controller@201000 {
+			compatible = "ti,da8xx-cppi41";
+			reg =  <0x200000 0x1000
+				0x201000 0x1000
+				0x202000 0x1000
+				0x204000 0x4000>;
+			reg-names = "glue", "controller",
+				    "scheduler", "queuemgr";
+			interrupts = <58>;
+			interrupt-names = "glue";
+			#dma-cells = <2>;
+			#dma-channels = <4>;
+			#dma-requests = <256>;
+			status = "disabled";
+
+		};
 		mdio: mdio@224000 {
 			compatible = "ti,davinci_mdio";
 			#address-cells = <1>;
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
