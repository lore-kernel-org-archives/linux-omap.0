From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/2] ti-gpmc: Add support for AAD timings
Date: Mon, 28 Dec 2015 14:39:19 +0100
Message-ID: <1451309961-7247-1-git-send-email-narmstrong@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This serie add support for the GPMC Advanced AAD timings on hardware supporting
the feature like the AM335x and DM816X.

Neil Armstrong (2):
  memory: omap-gpmc: Add support for AAD timings
  dt-bindings: bus: ti-gpmc: Add AAD timings properties

 Documentation/devicetree/bindings/bus/ti-gpmc.txt |  5 ++++
 drivers/memory/omap-gpmc.c                        | 30 +++++++++++++++++++++++
 include/linux/omap-gpmc.h                         |  5 ++++
 3 files changed, 40 insertions(+)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
