From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] dt-bindings: bus: ti-gpmc: Add AAD timings properties
Date: Mon, 28 Dec 2015 14:39:21 +0100
Message-ID: <1451309961-7247-3-git-send-email-narmstrong@baylibre.com>
References: <1451309961-7247-1-git-send-email-narmstrong@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451309961-7247-1-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

In order to support advanced AAD timings, add these properties to the DT
GPMC bindings.

Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/bus/ti-gpmc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
index 704be93..0168370 100644
--- a/Documentation/devicetree/bindings/bus/ti-gpmc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
@@ -46,6 +46,9 @@ Timing properties for child nodes. All are optional and default to 0.
  - gpmc,adv-on-ns:	Assertion time
  - gpmc,adv-rd-off-ns:	Read deassertion time
  - gpmc,adv-wr-off-ns:	Write deassertion time
+ - gpmc,adv-aad-mux-on-ns:	Assertion time for AAD
+ - gpmc,adv-aad-mux-rd-off-ns:	Read deassertion time for AAD
+ - gpmc,adv-aad-mux-wr-off-ns:	Write deassertion time for AAD
 
  WE signals timings (in nanoseconds) corresponding to GPMC_CONFIG4:
  - gpmc,we-on-ns	Assertion time
@@ -54,6 +57,8 @@ Timing properties for child nodes. All are optional and default to 0.
  OE signals timings (in nanoseconds) corresponding to GPMC_CONFIG4:
  - gpmc,oe-on-ns:	Assertion time
  - gpmc,oe-off-ns:	Deassertion time
+ - gpmc,oe-aad-mux-on-ns:	Assertion time for AAD
+ - gpmc,oe-aad-mux-off-ns:	Deassertion time for AAD
 
  Access time and cycle time timings (in nanoseconds) corresponding to
  GPMC_CONFIG5:
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
