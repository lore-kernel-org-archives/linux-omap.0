From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 4/4] ARM: omap: pass minimal SoC/board data for UART from dt
Date: Tue, 22 Nov 2011 19:14:16 +0530
Message-ID: <1321969456-24266-5-git-send-email-rnayak@ti.com>
References: <1321969456-24266-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1321969456-24266-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: khilman-l0cyMroinI0@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, govindraj.raja-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Pass minimal data needed for console boot, from dt, for
OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
static initialization from generic board file.

Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3.dtsi        |   31 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi        |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c |    1 -
 3 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index d202bb5..216c331 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -13,6 +13,13 @@
 / {
 	compatible = "ti,omap3430", "ti,omap3";
 
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+	};
+
 	cpus {
 		cpu@0 {
 			compatible = "arm,cortex-a8";
@@ -59,5 +66,29 @@
 			interrupt-controller;
 			#interrupt-cells = <1>;
 		};
+
+		uart1: serial@0x4806a000 {
+			compatible = "ti,omap3-uart";
+			ti,hwmods = "uart1";
+			clock-frequency = <48000000>;
+		};
+
+		uart2: serial@0x4806c000 {
+			compatible = "ti,omap3-uart";
+			ti,hwmods = "uart2";
+			clock-frequency = <48000000>;
+		};
+
+		uart3: serial@0x49020000 {
+			compatible = "ti,omap3-uart";
+			ti,hwmods = "uart3";
+			clock-frequency = <48000000>;
+		};
+
+		uart4: serial@0x49042000 {
+			compatible = "ti,omap3-uart";
+			ti,hwmods = "uart4";
+			clock-frequency = <48000000>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4c61c82..e8fe75f 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -21,6 +21,10 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
 	};
 
 	cpus {
@@ -99,5 +103,29 @@
 			reg = <0x48241000 0x1000>,
 			      <0x48240100 0x0100>;
 		};
+
+		uart1: serial@0x4806a000 {
+			compatible = "ti,omap4-uart";
+			ti,hwmods = "uart1";
+			clock-frequency = <48000000>;
+		};
+
+		uart2: serial@0x4806c000 {
+			compatible = "ti,omap4-uart";
+			ti,hwmods = "uart2";
+			clock-frequency = <48000000>;
+		};
+
+		uart3: serial@0x48020000 {
+			compatible = "ti,omap4-uart";
+			ti,hwmods = "uart3";
+			clock-frequency = <48000000>;
+		};
+
+		uart4: serial@0x4806e000 {
+			compatible = "ti,omap4-uart";
+			ti,hwmods = "uart4";
+			clock-frequency = <48000000>;
+		};
 	};
 };
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index fb55fa3..bb72809 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -70,7 +70,6 @@ static void __init omap_generic_init(void)
 	if (node)
 		irq_domain_add_simple(node, 0);
 
-	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
-- 
1.7.1
