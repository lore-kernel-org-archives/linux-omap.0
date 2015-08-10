From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/6]  ARM: AM4372: Enable RTC
Date: Mon, 10 Aug 2015 14:58:20 +0530
Message-ID: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org
Cc: galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The series brings multiple fixes needed to get rtc ticking
on am437x-gp-evm.

This is tested on top of omap-for-v4.3/dt-v2 branch. Boot tested on
AM437X-GP-EVM also tested rtc ticking via sysfs nodes. 

The series is on top of this patch:
http://comments.gmane.org/gmane.linux.drivers.devicetree/131026

Keerthy (6):
  ARM: dts: AM43XX: Add clk_32k_rtc node
  rtc: omap: Add external clock enabling support
  ARM: AM43xx: Introduce a separate soc_is function for am438x series of
    SoCs
  ARM: dts: am43x-epos-evm: Add the am438 compatible string
  ARM: AM43XX: HWMOD: Add rtc hwmod
  ARM: dts: AM437X-GP-EVM: Enable rtc

Changes in v2:

  * Couple of patches already pulled in.
  * Removed dt ext-clk-src and made use of clocks property to determine
    presence of external clock source.

 .../devicetree/bindings/arm/omap/omap.txt          |  3 +++
 arch/arm/boot/dts/am4372.dtsi                      |  2 ++
 arch/arm/boot/dts/am437x-gp-evm.dts                |  4 +++
 arch/arm/boot/dts/am43x-epos-evm.dts               |  2 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi               |  6 +++++
 arch/arm/mach-omap2/board-generic.c                |  1 +
 arch/arm/mach-omap2/id.c                           |  2 ++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 16 ++++++++++--
 arch/arm/mach-omap2/soc.h                          |  7 +++--
 drivers/rtc/rtc-omap.c                             | 30 ++++++++++++++++++++++
 10 files changed, 68 insertions(+), 5 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
