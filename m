From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 01/11] Documentation: dt: Add #iommu-cells info to OMAP iommu
	bindings
Date: Mon, 20 Jul 2015 17:33:23 -0500
Message-ID: <1437431613-55656-2-git-send-email-s-anna@ti.com>
References: <1437431613-55656-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437431613-55656-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OMAP IOMMU bindings is updated to reflect the required #iommu-cells
property.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
index 42531dc387aa..869699925fd5 100644
--- a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
@@ -8,6 +8,11 @@ Required properties:
 - ti,hwmods  : Name of the hwmod associated with the IOMMU instance
 - reg        : Address space for the configuration registers
 - interrupts : Interrupt specifier for the IOMMU instance
+- #iommu-cells : Should be 0. OMAP IOMMUs are all "single-master" devices,
+                 and needs no additional data in the pargs specifier. Please
+                 also refer to the generic bindings document for more info
+                 on this property,
+                     Documentation/devicetree/bindings/iommu/iommu.txt
 
 Optional properties:
 - ti,#tlb-entries : Number of entries in the translation look-aside buffer.
@@ -18,6 +23,7 @@ Optional properties:
 Example:
 	/* OMAP3 ISP MMU */
 	mmu_isp: mmu@480bd400 {
+		#iommu-cells = <0>;
 		compatible = "ti,omap2-iommu";
 		reg = <0x480bd400 0x80>;
 		interrupts = <24>;
-- 
2.4.4
