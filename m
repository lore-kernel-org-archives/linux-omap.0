From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv13 28/40] ARM: dts: AM35xx: use DT clock data
Date: Thu, 9 Jan 2014 16:00:39 +0200
Message-ID: <1389276051-1326-29-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

AM35xx now uses the clock data from device tree. Most of the data is
shared with OMAP3xxx, but as there is some delta, a new base .dtsi
file is also created for the SoC.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am3517.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 2fbe02f..788391f 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -61,3 +61,6 @@
 		};
 	};
 };
+
+/include/ "am35xx-clocks.dtsi"
+/include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
