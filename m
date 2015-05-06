From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 01/10] arm/dts: dra7xx: add 'ti,set-rate-parent' for dss_dss_clk
Date: Wed, 6 May 2015 13:08:49 +0300
Message-ID: <1430906938-26128-2-git-send-email-tomi.valkeinen@ti.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430906938-26128-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We need set-rate-parent flags for the display's clock path so that the
DSS driver can change the clock rate of the PLL.

This patchs adds the ti,set-rate-parent flag to 'dss_dss_clk' clock
node, which is only a gate clock, allowing the setting of the clock rate
to propagate to the PLL.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 3b933f74d000..940dc8987adb 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1531,6 +1531,7 @@
 		clocks = <&dpll_per_h12x2_ck>;
 		ti,bit-shift = <8>;
 		reg = <0x1120>;
+		ti,set-rate-parent;
 	};
 
 	dss_hdmi_clk: dss_hdmi_clk {
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
