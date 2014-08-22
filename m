From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/6] ARM: dts: OMAP5: switch to compatible pinctrl
Date: Fri, 22 Aug 2014 09:03:51 -0500
Message-ID: <1408716235-26164-3-git-send-email-nm@ti.com>
References: <1408716235-26164-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408716235-26164-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Now that ti,omap5-padconf is available, switch over to that compatible
property. Retain pinctrl-single for legacy support.

While at it, mark pinctrl as interrupt controller so that it can be
used with interrupts-extended property for wakeup events.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap5.dtsi |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index df0a09b..04acda6 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -188,18 +188,22 @@
 		};
 
 		omap5_pmx_core: pinmux@4a002840 {
-			compatible = "ti,omap4-padconf", "pinctrl-single";
+			compatible = "ti,omap5-padconf", "pinctrl-single";
 			reg = <0x4a002840 0x01b6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
 			pinctrl-single,register-width = <16>;
 			pinctrl-single,function-mask = <0x7fff>;
 		};
 		omap5_pmx_wkup: pinmux@4ae0c840 {
-			compatible = "ti,omap4-padconf", "pinctrl-single";
+			compatible = "ti,omap5-padconf", "pinctrl-single";
 			reg = <0x4ae0c840 0x0038>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
 			pinctrl-single,register-width = <16>;
 			pinctrl-single,function-mask = <0x7fff>;
 		};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
