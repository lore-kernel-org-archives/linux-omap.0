From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [RFC 3/8] ARM: twd: clock rate from DT (if no DT clk tree)
Date: Mon, 18 Feb 2013 12:00:21 +0530
Message-ID: <94cb377171f84ceefd667aead4602d70adab6619.1361166003.git.afzal@ti.com>
References: <cover.1361166003.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <cover.1361166003.git.afzal-l0cyMroinI0@public.gmane.org>
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
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Syed Mohammed Khasim <khasim-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add an optional property to find clock-frequency from DT. This helps
as a fallback mechanism in case there is no representation of clock
tree in DT.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/twd.txt | 7 ++++++-
 arch/arm/kernel/smp_twd.c                     | 8 ++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/twd.txt b/Documentation/devicetree/bindings/arm/twd.txt
index 75b8610..fdafa4f 100644
--- a/Documentation/devicetree/bindings/arm/twd.txt
+++ b/Documentation/devicetree/bindings/arm/twd.txt
@@ -7,8 +7,9 @@ and watchdog.
 The TWD is usually attached to a GIC to deliver its two per-processor
 interrupts.
 
-** Timer node required properties:
+** Timer node properties:
 
+Required properties:
 - compatible : Should be one of:
 	"arm,cortex-a9-twd-timer"
 	"arm,cortex-a5-twd-timer"
@@ -19,12 +20,16 @@ interrupts.
 - reg : Specify the base address and the size of the TWD timer
 	register window.
 
+Optional property:
+- clock-frequency : frequency(Hz) of peripheral clock fed to timer
+
 Example:
 
 	twd-timer@2c000600 {
 		compatible = "arm,arm11mp-twd-timer"";
 		reg = <0x2c000600 0x20>;
 		interrupts = <1 13 0xf01>;
+		clock-frequency = <300000000>;
 	};
 
 ** Watchdog node properties:
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 118f4f2..aac0f9f 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -247,7 +247,15 @@ static void twd_get_clock(struct device_node *np)
 		twd_clk = clk_get_sys("smp_twd", NULL);
 
 	if (IS_ERR(twd_clk)) {
+		u32 freq;
+
 		pr_err("smp_twd: clock not found %d\n", (int) PTR_ERR(twd_clk));
+
+		/* If there is no representation of clock tree in DT,
+		   provide a fallback option to obtain frequency
+		 */
+		if (np && !of_property_read_u32(np, "clock-frequency", &freq))
+			twd_timer_rate = freq;
 		return;
 	}
 
-- 
1.7.12
