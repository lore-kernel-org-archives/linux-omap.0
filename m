From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/8] ARM: AM4372: Enable RTC
Date: Wed, 5 Aug 2015 16:19:44 +0530
Message-ID: <1438771792-12604-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The series brings multiple fixes needed to get rtc ticking
on am437x-gp-evm.

This is tested on latest 4.2-rc5. Boot tested on AM437X-GP-EVM
also tested rtc ticking via sysfs nodes. 

Dave Gerlach (1):
  ARM: dts: am437x-gp-evm: Add regulator-always-on and regulator-boot-on
    for RTC DCDCs

Keerthy (7):
  ARM: dts: AM4372: Append the rtc compatible string
  rtc: omap: Add external clock enabling support
  ARM: dts: AM4372: Add external clock flag
  ARM: AM43xx: Introduce a separate soc_is function for am438x series of
    SoCs
  ARM: dts: am43x-epos-evm: Add the am438 compatible string
  ARM: AM43XX: HWMOD: Add rtc hwmod
  ARM: dts: AM437x-gp-evm: Enable RTC

 Documentation/devicetree/bindings/arm/omap/omap.txt |  3 +++
 Documentation/devicetree/bindings/rtc/rtc-omap.txt  |  2 ++
 arch/arm/boot/dts/am4372.dtsi                       |  2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                 |  9 +++++++++
 arch/arm/boot/dts/am437x-idk-evm.dts                |  1 +
 arch/arm/boot/dts/am437x-sk-evm.dts                 |  1 +
 arch/arm/boot/dts/am43x-epos-evm.dts                |  2 +-
 arch/arm/mach-omap2/board-generic.c                 |  1 +
 arch/arm/mach-omap2/id.c                            |  2 ++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c          | 16 ++++++++++++++--
 arch/arm/mach-omap2/soc.h                           |  7 +++++--
 drivers/rtc/rtc-omap.c                              | 10 ++++++++++
 12 files changed, 50 insertions(+), 6 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
