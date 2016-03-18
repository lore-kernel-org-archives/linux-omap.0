From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Fri, 18 Mar 2016 16:23:24 +0200
Message-ID: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Chanes since v1:
- removed the ASoC patch as Mark has applied it already
- Added my signed-off to the hwmod patch
- New patch to handle the case when the sidetone hwmod has been removed for
  legacy boot.

The series addresses a long standing issue with McBSP2/3 regarding to hwmod
setup. When booting with DT a warning is printed that mcbsp2/3 is using two
hwmod.
The root of the issue is the way how the hwmod data was constructed in the first
place for OMAP3 McBSP2/3.
After re-reading the TRM it is clear that the sidetone should not have it's
own hwmod data as it is not a separate IP, it is part of the McBSP module. It
can not affect PRCM either since it's SYSCONFIG register's AUTOIDLE bit is only
sets the autoidle from the internal McBSP_iclk clock to the sidetone block of
the same McBSP.

Regards,
Peter
---
Peter Ujfalusi (3):
  ARM: DTS: omap3: Remove mcbsp2/3_sidetone hwmod reference for McBSP2/3
  ARM: OMAP2+: mcbsp: Prepare the device build code for sidetone hwmod
    removal
  ARM: OMAP3: hwmod data: Merge and remove the McBSP sidetone related
    data

 arch/arm/boot/dts/omap3.dtsi               |   4 +-
 arch/arm/mach-omap2/mcbsp.c                |  28 ++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 120 ++++-------------------------
 3 files changed, 43 insertions(+), 109 deletions(-)

-- 
2.7.3
