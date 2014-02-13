From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 03/16] Documentation: dt: add OMAP iommu bindings
Date: Thu, 13 Feb 2014 12:15:34 -0600
Message-ID: <1392315347-32967-4-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1392315347-32967-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>

This patch adds the iommu bindings for all OMAP2+ SoCs. Apart from
the standard bindings used by OMAP peripherals, this patch uses a
'dma-window' (already used by Tegra SMMU) and adds two OMAP custom
bindings - 'ti,#tlb-entries' and 'ti,iommu-bus-err-back'.

Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
[s-anna-l0cyMroinI0@public.gmane.org: split bindings document, add dra7 and bus error back]
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
new file mode 100644
index 0000000..116492d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
@@ -0,0 +1,28 @@
+OMAP2+ IOMMU
+
+Required properties:
+- compatible : Should be one of,
+		"ti,omap2-iommu" for OMAP2/OMAP3 IOMMU instances
+		"ti,omap4-iommu" for OMAP4/OMAP5 IOMMU instances
+		"ti,dra7-iommu" for DRA7xx IOMMU instances
+- ti,hwmods  : Name of the hwmod associated with the IOMMU instance
+- reg        : Address space for the configuration registers
+- interrupts : Interrupt specifier for the IOMMU instance
+- dma-window : IOVA start address and length
+
+Optional properties:
+- ti,#tlb-entries : Number of entries in the translation look-aside buffer.
+                    Should be either 8 or 32 (default: 32)
+- ti,iommu-bus-err-back : Indicates the IOMMU instance supports throwing
+		          back a bus error response on MMU faults.
+
+Example:
+	/* OMAP3 ISP MMU */
+	mmu_isp: mmu@480bd400 {
+		compatible = "ti,omap2-iommu";
+		reg = <0x480bd400 0x80>;
+		interrupts = <24>;
+		ti,hwmods = "mmu_isp";
+		ti,#tlb-entries = <8>;
+		dma-window = <0 0xfffff000>;
+	};
-- 
1.8.5.3
