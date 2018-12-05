From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: dts: am437x: Move l4 child devices to probe
 them with ti-sysc
Date: Wed, 5 Dec 2018 15:02:42 -0800
Message-ID: <20181205230242.GH6707@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <20180925000545.22931-3-tony@atomide.com>
 <f890f989-bfd0-47eb-66e0-5a8573e398b7@ti.com>
 <20181204181121.GC6707@atomide.com>
 <20181204231833.GF6707@atomide.com>
 <3feb7078-5690-abf6-2a9d-a65807ee701a@ti.com>
 <20181205190019.GG6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181205190019.GG6707@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [181205 19:00]:
> I think we're missing the top level ranges for mcasp l3 port
> and the translation goes wrong there, I'll fix it hopefully
> today.

Below is a fix for am473x that works for me as tested with
am473x-sk-evm. Care to test please?

I'll send also a similar fix for am335x separately. And
then for dra7. Looks like for dra7 we're also missing the
mcasp optional clocks too.

Regards,

Tony

8< ------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 5 Dec 2018 14:08:21 -0800
Subject: [PATCH] ARM: dts: Add missing ranges for am437x mcasp l3 ports

We need to add mcasp l3 port ranges for mcasp to use a correct l3
data port address for dma.

Fixes: d95adfd45853 ("ARM: dts: am437x: Move l4 child devices to
probe them with ti-sysc")
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am437x-l4.dtsi | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -613,7 +613,9 @@
 	ranges = <0x00000000 0x48000000 0x100000>,	/* segment 0 */
 		 <0x00100000 0x48100000 0x100000>,	/* segment 1 */
 		 <0x00200000 0x48200000 0x100000>,	/* segment 2 */
-		 <0x00300000 0x48300000 0x100000>;	/* segment 3 */
+		 <0x00300000 0x48300000 0x100000>,	/* segment 3 */
+		 <0x46000000 0x46000000 0x400000>,	/* l3 data port */
+		 <0x46400000 0x46400000 0x400000>;	/* l3 data port */
 
 	segment@0 {					/* 0x48000000 */
 		compatible = "simple-bus";
@@ -664,7 +666,9 @@
 			 <0x00034000 0x00034000 0x001000>,	/* ap 80 */
 			 <0x00035000 0x00035000 0x001000>,	/* ap 81 */
 			 <0x00036000 0x00036000 0x001000>,	/* ap 84 */
-			 <0x00037000 0x00037000 0x001000>;	/* ap 85 */
+			 <0x00037000 0x00037000 0x001000>,	/* ap 85 */
+			 <0x46000000 0x46000000 0x400000>,	/* l3 data port */
+			 <0x46400000 0x46400000 0x400000>;	/* l3 data port */
 
 		target-module@8000 {			/* 0x48008000, ap 6 10.0 */
 			compatible = "ti,sysc";
@@ -826,7 +830,8 @@
 			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x38000 0x2000>;
+			ranges = <0x0 0x38000 0x2000>,
+				 <0x46000000 0x46000000 0x400000>;
 
 			mcasp0: mcasp@0 {
 				compatible = "ti,am33xx-mcasp-audio";
@@ -857,7 +862,8 @@
 			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x3c000 0x2000>;
+			ranges = <0x0 0x3c000 0x2000>,
+				 <0x46400000 0x46400000 0x400000>;
 
 			mcasp1: mcasp@0 {
 				compatible = "ti,am33xx-mcasp-audio";
-- 
2.19.2
