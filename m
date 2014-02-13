From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/4] ARM: dts: OMAP3: Update ISP IOMMU node
Date: Thu, 13 Feb 2014 12:22:53 -0600
Message-ID: <1392315776-33197-2-git-send-email-s-anna@ti.com>
References: <1392315776-33197-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1392315776-33197-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>

Update the IOMMU node for the camera subsystem as per the
OMAP IOMMU bindings.

Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
[s-anna-l0cyMroinI0@public.gmane.org: corrected interrupt number]
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index a5fc83b..ac91cc3 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -411,10 +411,12 @@
 		};
 
 		mmu_isp: mmu@480bd400 {
-			compatible = "ti,omap3-mmu-isp";
-			ti,hwmods = "mmu_isp";
+			compatible = "ti,omap2-iommu";
 			reg = <0x480bd400 0x80>;
-			interrupts = <8>;
+			interrupts = <24>;
+			ti,hwmods = "mmu_isp";
+			ti,#tlb-entries = <8>;
+			dma-window = <0 0xfffff000>;
 		};
 
 		wdt2: wdt@48314000 {
-- 
1.8.5.3
