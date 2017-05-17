From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 0/4] clk: ti: add support for clkctrl clocks
Date: Wed, 17 May 2017 18:50:05 +0300
Message-ID: <1495036209-11298-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Basically a rebase on top of 4.12-rc1, with some minor fixes.
This series is now against the clock driver only, and should be ready
to pull in.

Changes compared to v2:

Patch #1: fixed the typo for #clock-cells property in the example
Patch #2: fixed a compile bug detected by kbuild bot, basically added
	  default clkctrl data, and moved the registration of omap4
	  version of the same to patch #4
Patch #3: grouped the macro definitions based on clock instance and
	  added header rows before the clock instances
Patch #4: Moved the registration of the clkctrl data under this patch

Dropped rest of the patches from series to be reviewed / pulled separately
by Tony, as they are all against mach-omap2 / omap DTS. I will post the
remaining patches separately on linux-omap list only.

Boot testing done against:
am335x-evm, am335x-evmsk, am37x-evm, am437x-sk, am43x-epos-evm,
am437x-gp-evm, omap3-beagle-xm, omap3-beagle, am335x-boneblack,
am335x-bone, craneboard, dra72x-evm, dra7xx-evm, omap3-n900,
omap5-uevm, omap4-panda-es, omap4-panda, omap2430-sdp,
omap3430-sdp, omap4-sdp-es23plus

Boot failures detected on:
am335x-evm, am43x-epos-evm, dra72x-evm, dra7xx-evm

  => all board fail to mount NFS rootfs but are otherwise fine
  => same failure seen on same boards on plain 4.12-rc1 also

Basic suspend-resume test done on omap4-panda-es.

Public branch:
tree: https://github.com/t-kristo/linux-pm.git
branch: 4.12-rc1-clkctrl

-Tero

