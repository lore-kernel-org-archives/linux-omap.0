From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH v2 0/3] Adding DT support for TI HECC module
Date: Wed, 11 Jan 2017 15:05:18 +0100
Message-ID: <1484143521-4898-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org, andrej.skvortzov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

This is an attempt to revive DT support for TI HECC that was started in 2015.

I haven't changed much because not all questions could be fully answered:

* Should HECC use "am3505" as compatible?
* What should be done to the offsets (ti,scc-ram-offset, ti,hecc-ram-offset, ti,mbx-offset)?

Anton Glukhov (3):
  ARM: dts: AM35x: Add hecc node
  can: ti_hecc: Add TI HECC DT binding documentation
  can: ti_hecc: Add DT support for TI HECC module

 .../devicetree/bindings/net/can/ti_hecc.txt        | 31 +++++++++++++
 arch/arm/boot/dts/am3517.dtsi                      | 13 ++++++
 drivers/net/can/ti_hecc.c                          | 54 ++++++++++++++++++++--
 3 files changed, 94 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
