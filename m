From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] clk: Add clock driver for DRA7 ATL (Audio Tracking Logic)
Date: Wed, 2 Apr 2014 16:55:04 +0300
Message-ID: <1396446907-20383-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Audio Tracking Logic is designed to be used by HD Radio
applications to synchronize the audio output clocks to the
baseband clock. ATL can be also used to track errors between
two reference clocks (BWS, AWS) and generate a modulated
clock output which averages to some desired frequency.

To be able to integrate the ATL provided clocks to the clock tree we need
two types of DT binding:
- DT clock nodes to represent the ATL clocks towards the CCF
- binding for the ATL IP itself which is going to handle the hw
  configuration

The reason for this type of setup is that ATL itself is a separate device
in the SoC, it has it's own address space and clock domain. Other IPs can
use the ATL generated clock as their functional clock (McASPs for example)
and external components like audio codecs can also use the very same clock
as their MCLK.

With setup pm_runtime can handle the ATL clock on demand of it's use and
all the IP which needs ATL clock can be sure that it is enabled for them.

The first patch fixes the name of atl clkin3 node in dtsi file.

Regards,
Peter
---
Peter Ujfalusi (3):
  ARM: dts: dra7xx-clocks: Correct name for atl clkin3 clock
  clk: Driver for DRA7 ATL (Audio Tracking Logic)
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
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
