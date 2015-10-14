From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] ARM: OMAP2+ McASP(3) support for DRA7xx family
Date: Wed, 14 Oct 2015 12:23:26 +0300
Message-ID: <1444814608-20908-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

This is the followup series for the hwmod changes needed to get audio working
on DRA7xx family based boards.
The DTS patches has been applied by Tony from the original series:
http://www.spinics.net/lists/linux-omap/msg121473.html

I have addressed your comments in the hwmod data and did some research also
regarding to the use of ahclkx as fclk in the original submission.
It turned out that McASP _needs_ all clocks to be enabled (fclk, iclk and
ahclkx/r) to be able to access registers. The original patch where we handled
the ahclkx as fclk worked, because the fclk clock got enabled in the HW w/o
any SW interaction.
All in all, the McASP found in DRA7 needs all clocks to be enabled.
To satisfy this I have introduced a new flag to hwmod, which means that the
listed optional clocks need to be handled alongside with the fclk clock.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: OMAP2+: hwmod: Add hwmod flag for HWMOD_OPT_CLKS_NEEDED
  ARM: OMAP: DRA7: hwmod: Add data for McASP3

 arch/arm/mach-omap2/omap_hwmod.c          | 66 +++++++++++++++++--------------
 arch/arm/mach-omap2/omap_hwmod.h          |  3 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 56 ++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 30 deletions(-)

-- 
2.6.1
