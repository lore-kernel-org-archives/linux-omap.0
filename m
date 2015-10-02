From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [REPOST PATCH 3/4] ARM: dts: DRA7: Add common IOMMU nodes
Date: Fri, 2 Oct 2015 18:23:24 -0500
Message-ID: <1443828205-18706-4-git-send-email-s-anna@ti.com>
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

The DRA7xx family of SOCs have two IPUs and one DSP processor
subsystems in common. The IOMMU DT nodes have been added for
these processor subsystems, and have been disabled by default.

These MMUs are very similar to those on OMAP4 and OMAP5, with
the only difference being the presence of a second MMU within
the DSP subsystem for the EDMA port. The DSP IOMMUs also need
an additional 'ti,syscon-mmuconfig' property compared to the
IPU IOMMUs.

NOTE: The enabling of these nodes is left to the respective
board dts files.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 62055094e8d5..9f6bafcad385 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -916,6 +916,46 @@
 			status = "disabled";
 		};
 
+		mmu0_dsp1: mmu@40d01000 {
+			compatible = "ti,dra7-dsp-iommu";
+			reg = <0x40d01000 0x100>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu0_dsp1";
+			#iommu-cells = <0>;
+			ti,syscon-mmuconfig = <&dsp1_system 0x0>;
+			status = "disabled";
+		};
+
+		mmu1_dsp1: mmu@40d02000 {
+			compatible = "ti,dra7-dsp-iommu";
+			reg = <0x40d02000 0x100>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu1_dsp1";
+			#iommu-cells = <0>;
+			ti,syscon-mmuconfig = <&dsp1_system 0x1>;
+			status = "disabled";
+		};
+
+		mmu_ipu1: mmu@58882000 {
+			compatible = "ti,dra7-iommu";
+			reg = <0x58882000 0x100>;
+			interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_ipu1";
+			#iommu-cells = <0>;
+			ti,iommu-bus-err-back;
+			status = "disabled";
+		};
+
+		mmu_ipu2: mmu@55082000 {
+			compatible = "ti,dra7-iommu";
+			reg = <0x55082000 0x100>;
+			interrupts = <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_ipu2";
+			#iommu-cells = <0>;
+			ti,iommu-bus-err-back;
+			status = "disabled";
+		};
+
 		abb_mpu: regulator-abb-mpu {
 			compatible = "ti,abb-v3";
 			regulator-name = "abb_mpu";
-- 
2.6.0
