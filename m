From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] arm: dts: am4372: add pmu DT data
Date: Fri, 23 Jan 2015 17:11:44 -0600
Message-ID: <1422054704-14915-5-git-send-email-balbi@ti.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422054704-14915-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

with this patch, performance monitors work
and show sensible data on AM43xx devices:

~# perf stat sleep 5

 Performance counter stats for 'sleep 5':

          6.079585      task-clock (msec)         #    0.001 CPUs utilized
                 3      context-switches          #    0.493 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                35      page-faults               #    0.006 M/sec
           5888256      cycles                    #    0.969 GHz
           1458715      stalled-cycles-frontend   #   24.77% frontend cycles idle
           4632019      stalled-cycles-backend    #   78.67% backend  cycles idle
           1892556      instructions              #    0.32  insns per cycle
                                                  #    2.45  stalled cycles per insn
            141832      branches                  #   23.329 M/sec
             56093      branch-misses             #   39.55% of all branches

       5.018813000 seconds time elapsed

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 861f127dfead..ea103aa970f1 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -51,6 +51,14 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		reg = <0x4b000000 0x800000>;
+		interrutps = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+		ti,hwmods = "debugss";
+	};
+
 	gic: interrupt-controller@48241000 {
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
-- 
2.3.0-rc1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
