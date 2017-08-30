From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 02/17] ARM: dts: Configure pmu without interrupt for omap4430
Date: Wed, 30 Aug 2017 08:19:38 -0700
Message-ID: <20170830151953.30856-3-tony@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830151953.30856-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On omap4430, the PMU is not configure unlike on omap4460 because
of the missing handling.

The missing pmu node with the missing ti,hwmods entry will cause
boot time errors when the legacy platform data is removed as
the SoC interconnect code needs it.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

Let's fix the issue by configuring PMU but without the interrupts.
Then when cross trigger interface (CTI) is supported, we can add
interrupts also for omap4430.

Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -51,6 +51,17 @@
 		};
 	};
 
+	/*
+	 * Note that 4430 needs cross trigger interface (CTI) supported
+	 * before we can configure the interrupts. This means sampling
+	 * events are not supported for pmu. Note that 4460 does not use
+	 * CTI, see also 4460.dtsi.
+	 */
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		ti,hwmods = "debugss";
+	};
+
 	gic: interrupt-controller@48241000 {
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
