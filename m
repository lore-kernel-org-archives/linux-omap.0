From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] ARM: dts: OMAP4: Add #iommu-cells property to IOMMUs
Date: Fri, 10 Jul 2015 12:28:55 -0500
Message-ID: <1436549336-33456-2-git-send-email-s-anna@ti.com>
References: <1436549336-33456-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436549336-33456-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add missing #iommu-cells property to the DSP and IPU IOMMU nodes
for OMAP4 platforms. This property is required as per the generic
iommu binding.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index f884d6adb71e..7d31c6ff246f 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -551,6 +551,7 @@
 			reg = <0x4a066000 0x100>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmu_dsp";
+			#iommu-cells = <0>;
 		};
 
 		mmu_ipu: mmu@55082000 {
@@ -558,6 +559,7 @@
 			reg = <0x55082000 0x100>;
 			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmu_ipu";
+			#iommu-cells = <0>;
 			ti,iommu-bus-err-back;
 		};
 
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
