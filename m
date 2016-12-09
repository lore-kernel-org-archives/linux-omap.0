From: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] dt-bindings: mfd: Update TPS65217 interrupts
Date: Fri,  9 Dec 2016 15:28:29 +0900
Message-ID: <20161209062833.5768-1-woogyom.kim@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch-set fixes wrong property name and uses TPS65217 HW interrupt 
number from the datasheet instead of the DT ABI. DT bindings are also 
updated.

Milo Kim (4):
  ARM: dts: am335x: Fix the interrupt name of TPS65217
  dt-bindings: mfd: Remove TPS65217 interrupts
  dt-bindings: power/supply: Update TPS65217 properties
  dt-bindings: input: Add interrupt number for TPS65217

 .../bindings/input/tps65218-pwrbutton.txt          |  4 +++-
 .../bindings/power/supply/tps65217_charger.txt     |  7 +++++-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |  8 +++----
 include/dt-bindings/mfd/tps65217.h                 | 26 ----------------------
 4 files changed, 12 insertions(+), 33 deletions(-)
 delete mode 100644 include/dt-bindings/mfd/tps65217.h

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
