From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: Enable earlycon stdout path for duovero
Date: Mon, 22 May 2017 09:13:46 -0700
Message-ID: <20170522161346.10591-2-tony@atomide.com>
References: <20170522161346.10591-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170522161346.10591-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

As long as the kernel cmdline has "earlycon" in it, this allows
seeing debug messages earlier and does not require DEBUG_LL to
be enabled.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4-duovero.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-duovero.dtsi b/arch/arm/boot/dts/omap4-duovero.dtsi
--- a/arch/arm/boot/dts/omap4-duovero.dtsi
+++ b/arch/arm/boot/dts/omap4-duovero.dtsi
@@ -12,6 +12,10 @@
 	model = "Gumstix Duovero";
 	compatible = "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
 
+	chosen {
+		stdout-path = &uart3;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
-- 
2.13.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
