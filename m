From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/4] clk: Add clock driver for DRA7 ATL (Audio Tracking Logic)
Date: Wed, 7 May 2014 13:20:44 +0300
Message-ID: <1399458048-28213-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v1:
- ATL binding documentation and driver has been separated.

Audio Tracking Logic is designed to be used by HD Radio applications to
synchronize the audio output clocks to the baseband clock. ATL can be also
used to track errors between two reference clocks (BWS, AWS) and generate a modulated
clock output which averages to some desired frequency.
In essence ATL is generating a clock to be used by an audio codec and also
to be used by the SoC as MCLK.

The series will correct atl related clock names, adds binding documentation and
corresponding driver for the ATL and integrates the ATL clock into the clock
tree.

V1 of the ATL series:
https://lkml.org/lkml/2014/4/2/238

Regards,
Peter
---
Peter Ujfalusi (4):
  ARM: dts: dra7xx-clocks: Correct name for atl clkin3 clock
  dt:/bindings: DRA7 ATL (Audio Tracking Logic) clock bindings
  clk: ti: Driver for DRA7 ATL (Audio Tracking Logic)
  ARM: DTS: dra7/dra7xx-clocks: ATL related changes

 .../devicetree/bindings/clock/ti/dra7-atl.txt      |  97 +++++++
 arch/arm/boot/dts/dra7.dtsi                        |  11 +
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  38 +--
 drivers/clk/ti/Makefile                            |   3 +-
 drivers/clk/ti/clk-7xx.c                           |   2 +-
 drivers/clk/ti/clk-dra7-atl.c                      | 313 +++++++++++++++++++++
 include/dt-bindings/clk/ti-dra7-atl.h              |  40 +++
 7 files changed, 483 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/dra7-atl.txt
 create mode 100644 drivers/clk/ti/clk-dra7-atl.c
 create mode 100644 include/dt-bindings/clk/ti-dra7-atl.h

-- 
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
