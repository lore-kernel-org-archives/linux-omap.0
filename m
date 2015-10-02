From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [REPOST PATCH 4/4] ARM: dts: DRA74x: Add IOMMU nodes for DSP2
Date: Fri, 2 Oct 2015 18:23:25 -0500
Message-ID: <1443828205-18706-5-git-send-email-s-anna@ti.com>
References: <1443828205-18706-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443828205-18706-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The DRA74x family of SoCs have a second DSP, that also has
two MMUs just like the DSP1 subsystem. Add the IOMMU nodes
for this DSP2 subsystem in disabled state to the DRA74x
specific DTS file, the nodes would need to be enabled
appropriately in the respective board DTS files.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra74x.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index dfa29b7ba86a..2f7d313e91a0 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -81,6 +81,26 @@
 				dr_mode = "otg";
 			};
 		};
+
+		mmu0_dsp2: mmu@41501000 {
+			compatible = "ti,dra7-dsp-iommu";
+			reg = <0x41501000 0x100>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu0_dsp2";
+			#iommu-cells = <0>;
+			ti,syscon-mmuconfig = <&dsp2_system 0x0>;
+			status = "disabled";
+		};
+
+		mmu1_dsp2: mmu@41502000 {
+			compatible = "ti,dra7-dsp-iommu";
+			reg = <0x41502000 0x100>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu1_dsp2";
+			#iommu-cells = <0>;
+			ti,syscon-mmuconfig = <&dsp2_system 0x1>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.6.0
