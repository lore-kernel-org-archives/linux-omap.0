From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH v3 6/6] arm/dts: OMAP3/4: Add iommu nodes
Date: Thu, 11 Oct 2012 20:06:16 -0500
Message-ID: <1350003977-32744-12-git-send-email-omar.luna@linaro.org>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Joerg Roedel <joerg.roedel@amd.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.luna@linaro.org>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-omap@vger.kernel.org

Add nodes for iommu DT, to interface with hwmods.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 arch/arm/boot/dts/omap3.dtsi |   12 +++++++++++-
 arch/arm/boot/dts/omap4.dtsi |   17 ++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index f38ea87..c76872e 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -37,12 +37,17 @@
 		};
 
 		iva {
-			compatible = "ti,iva2.2";
+			compatible = "ti,iva2.2", "simple-bus";
 			ti,hwmods = "iva";
 
 			dsp {
 				compatible = "ti,omap3-c64";
 			};
+
+			mmu_iva: mmu_iva@5d000000 {
+				compatible = "ti,omap3-iommu";
+				ti,hwmods = "mmu_iva";
+			};
 		};
 	};
 
@@ -227,6 +232,11 @@
 			ti,hwmods = "mmc3";
 		};
 
+		mmu_isp: mmu_isp@480bd400 {
+			compatible = "ti,omap3-iommu";
+			ti,hwmods = "mmu_isp";
+		};
+
 		wdt2: wdt@48314000 {
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 3883f94..f084418 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -71,8 +71,23 @@
 		};
 
 		dsp {
-			compatible = "ti,omap3-c64";
+			compatible = "ti,omap3-c64", "simple-bus";
 			ti,hwmods = "dsp";
+
+			mmu_dsp: mmu_dsp@4a066000 {
+				compatible = "ti,omap4-iommu";
+				ti,hwmods = "mmu_dsp";
+			};
+		};
+
+		ipu {
+			compatible = "ti,omap4-ipu", "simple-bus";
+			ti,hwmods = "ipu";
+
+			mmu_ipu: mmu_ipu@55082000 {
+				compatible = "ti,omap4-iommu";
+				ti,hwmods = "mmu_ipu";
+			};
 		};
 
 		iva {
-- 
1.7.9.5

