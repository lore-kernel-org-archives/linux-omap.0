From: Sathya Prakash M R <sathyap-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/4] Add Display support for AM43xx
Date: Thu, 13 Mar 2014 14:28:25 +0530
Message-ID: <1394701109-6721-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
Cc: Sathya Prakash M R <sathyap-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch series adds DSS support to the AM43x. The DPI LCD
panel is supported on both am43x-epos-evm and am437x-gp-evm.
The LCD panel is from OSD model: OSD057T0559-34TS

Version 1 of this series can be found below[1]:
[1]: https://patchwork.kernel.org/patch/3274421/

Tested on am43x-epos-evm and am437x-gp-evm.

Dependent patches :
Sourav patches adding device nodes for epos [2] and gp [3] evm
[2]: https://patchwork.kernel.org/patch/3246701/
[3]: https://patchwork.kernel.org/patch/3246751/

AM43xx has a dedicated display pll. Hence tomi patch improving
func clock handling is needed [4]
[4]: https://patchwork.kernel.org/patch/3196221/

Tomi patch adding DT support to DSS [5]
[5]: https://patchwork.kernel.org/patch/3516341/

Changes from V1:
Rebased to latest DSS DT changes from Tomi which is under review [5]




Sathya Prakash M R (3):
  OMAPDSS: Add DSS features for AM43xx
  ARM: OMAP2+: AM43xx DSS Hwmod
  ARM: DTS: AM43x: Add DSS node

Tomi Valkeinen (1):
  ARM: AM43xx: fix dpll init in bypass mode

 arch/arm/boot/dts/am4372.dtsi              |   28 ++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts        |   77 ++++++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts       |   73 +++++++++++++++++++
 arch/arm/boot/dts/am43xx-clocks.dtsi       |    2 +
 arch/arm/mach-omap2/clkt_dpll.c            |    4 +-
 arch/arm/mach-omap2/display.c              |    2 +
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  104 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |    1 +
 drivers/video/omap2/dss/dispc.c            |    1 +
 drivers/video/omap2/dss/dpi.c              |    2 +
 drivers/video/omap2/dss/dsi.c              |    1 +
 drivers/video/omap2/dss/dss.c              |   11 +++
 drivers/video/omap2/dss/dss_features.c     |   67 ++++++++++++++++++
 include/video/omapdss.h                    |    1 +
 14 files changed, 372 insertions(+), 2 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
