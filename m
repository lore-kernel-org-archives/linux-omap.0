From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [REPOST PATCH 1/2] Documentation: dt: Update OMAP iommu bindings for
	DRA7 DSPs
Date: Fri, 2 Oct 2015 18:02:43 -0500
Message-ID: <1443826964-10691-2-git-send-email-s-anna@ti.com>
References: <1443826964-10691-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443826964-10691-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The DSP processor sub-systems on DRA7xx have two MMU instances
each, one for the processor core and the other for an internal
EDMA block. These MMUs need an additional shared register to be
programmed in the DSP_SYSTEM sub-module to be enabled properly.

The OMAP IOMMU bindings is updated to account for this additional
syscon property required for these DSP IOMMU instances on DRA7xx
SoCs. A new compatible "ti,dra7-dsp-iommu" is also defined to
distinguish these devices specifically from other DRA7 IOMMU
devices.

An example of the DRA7 DSP IOMMU nodes is also added to the
document for clarity.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
index 869699925fd5..4bd10dd881b8 100644
--- a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible : Should be one of,
 		"ti,omap2-iommu" for OMAP2/OMAP3 IOMMU instances
 		"ti,omap4-iommu" for OMAP4/OMAP5 IOMMU instances
+		"ti,dra7-dsp-iommu" for DRA7xx DSP IOMMU instances
 		"ti,dra7-iommu" for DRA7xx IOMMU instances
 - ti,hwmods  : Name of the hwmod associated with the IOMMU instance
 - reg        : Address space for the configuration registers
@@ -19,6 +20,13 @@ Optional properties:
                     Should be either 8 or 32 (default: 32)
 - ti,iommu-bus-err-back : Indicates the IOMMU instance supports throwing
 		          back a bus error response on MMU faults.
+- ti,syscon-mmuconfig : Should be a pair of the phandle to the DSP_SYSTEM
+                        syscon node that contains the additional control
+                        register for enabling the MMU, and the MMU instance
+                        number (0-indexed) within the sub-system. This property
+                        is required for DSP IOMMU instances on DRA7xx SoCs. The
+                        instance number should be 0 for DSP MDMA MMUs and 1 for
+                        DSP EDMA MMUs.
 
 Example:
 	/* OMAP3 ISP MMU */
@@ -30,3 +38,22 @@ Example:
 		ti,hwmods = "mmu_isp";
 		ti,#tlb-entries = <8>;
 	};
+
+	/* DRA74x DSP2 MMUs */
+	mmu0_dsp2: mmu@41501000 {
+		compatible = "ti,dra7-dsp-iommu";
+		reg = <0x41501000 0x100>;
+		interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+		ti,hwmods = "mmu0_dsp2";
+		#iommu-cells = <0>;
+		ti,syscon-mmuconfig = <&dsp2_system 0x0>;
+	};
+
+	mmu1_dsp2: mmu@41502000 {
+		compatible = "ti,dra7-dsp-iommu";
+		reg = <0x41502000 0x100>;
+		interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+		ti,hwmods = "mmu1_dsp2";
+		#iommu-cells = <0>;
+		ti,syscon-mmuconfig = <&dsp2_system 0x1>;
+	};
-- 
2.6.0
