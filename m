From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/7] ARM/ASoC: OMAP3: Fix McBSP2/3 sidetone support
Date: Fri, 29 Apr 2016 13:53:15 +0300
Message-ID: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Based on the ongoing discussion on v2 (ARM: OMAP3: Fix McBSP2/3 hwmod setup for
sidetone) I have dropped the removal of the sidetone hwmod and only corrected
it. The series now includes all related changes needed to have correct sidetone
support whenever we boot in legacy or in DT mode.

This time the ASoC part have dependency on earlier patches so they can not be
applied separately.

Regards,
Peter
---
Peter Ujfalusi (7):
  ARM: OMAP3: hwmod data: Fix McBSP2/3 sidetone data
  ARM: dts: omap3: Add clocks to McBSP nodes
  ARM: OMAP3: McBSP: New callback for McBSP2/3 ICLK idle configuration
  ARM: OMAP3: pdata-quirks: Add support for McBSP2/3 sidetone handling
  ASoc: omap-mcbsp: Rename omap_mcbsp_sysfs_remove() to
    omap_mcbsp_cleanup()
  ASoC: omap-mcbsp: sidetone: Use the new callback for iclk handling
  ARM: OMAP2+: McBSP: Remove the old iclk allow/deny idle code

 arch/arm/boot/dts/omap3.dtsi                | 10 ++++++++++
 arch/arm/mach-omap2/mcbsp.c                 | 31 ++++++++++++++++-------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  | 24 ++++------------------
 arch/arm/mach-omap2/pdata-quirks.c          | 18 +++++++++++++++++
 include/linux/platform_data/asoc-ti-mcbsp.h |  4 +++-
 sound/soc/omap/mcbsp.c                      | 21 +++++++++++++------
 sound/soc/omap/mcbsp.h                      |  3 ++-
 sound/soc/omap/omap-mcbsp.c                 |  5 ++++-
 8 files changed, 73 insertions(+), 43 deletions(-)

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
