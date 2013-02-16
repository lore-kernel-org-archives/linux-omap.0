From: Anil Kumar <anilk4.v-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: omap3-devkit8000: add nand dt node
Date: Sat, 16 Feb 2013 17:08:28 +0530
Message-ID: <1361014708-1659-3-git-send-email-anilk4.v@gmail.com>
References: <1361014708-1659-1-git-send-email-anilk4.v@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1361014708-1659-1-git-send-email-anilk4.v-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, thomas-xePHB1Atl/Dsq35pWSNszA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add the needed sections to enable nand support on
Devkit8000.

Add nand partitions information.

Signed-off-by: Anil Kumar <anilk4.v-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
:100644 100644 6338993... 6c6decf... M	arch/arm/boot/dts/omap3-devkit8000.dts
 arch/arm/boot/dts/omap3-devkit8000.dts |   52 ++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 6338993..6c6decf 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -101,3 +101,55 @@
 &mcbsp5 {
 	status = "disabled";
 };
+
+&gpmc {
+	ranges = <0 0 0x30000000 0x04>;       /* CS0: NAND */
+
+	nand@0,0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+		nand-bus-width = <16>;
+
+		gpmc,sync-clk = <0>;
+		gpmc,cs-on = <0>;
+		gpmc,cs-rd-off = <44>;
+		gpmc,cs-wr-off = <44>;
+		gpmc,adv-on = <6>;
+		gpmc,adv-rd-off = <34>;
+		gpmc,adv-wr-off = <44>;
+		gpmc,we-off = <40>;
+		gpmc,oe-off = <54>;
+		gpmc,access = <64>;
+		gpmc,rd-cycle = <82>;
+		gpmc,wr-cycle = <82>;
+		gpmc,wr-access = <40>;
+		gpmc,wr-data-mux-bus = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		x-loader@0 {
+			label = "X-Loader";
+			reg = <0 0x80000>;
+		};
+
+		bootloaders@80000 {
+			label = "U-Boot";
+			reg = <0x80000 0x1e0000>;
+		};
+
+		bootloaders_env@260000 {
+			label = "U-Boot Env";
+			reg = <0x260000 0x20000>;
+		};
+
+		kernel@280000 {
+			label = "Kernel";
+			reg = <0x280000 0x400000>;
+		};
+
+		filesystem@680000 {
+			label = "File System";
+			reg = <0x680000 0xf980000>;
+		};
+	};
+};
-- 
1.7.0.4
