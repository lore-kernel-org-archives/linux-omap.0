From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/15] clk: ti: cleanups / fixes for preparation of clkctrl clocks
Date: Mon, 13 Feb 2017 11:34:56 +0200
Message-ID: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series provides a number of cleanups and fixes for TI clock drivers.
There patches are mostly independent of anything else, but are required
for the upcoming clkctrl support also. Targeted for 4.12 merge window.

Main features provided by this series:
- Dropped a few obsolete definitions
- Cleanups for clock alias generation; after this most of the clock aliases
  can be removed from the drivers/clk/ti/clk-xyz.c files. As a sample,
  patch #08 is provided for cleaning up omap4 clock aliases, but this can
  be done for all.
- Convert mux/divider to use TI clock specific internal representation,
  instead of re-using the generic clk_divider / clk_mux. This allows
  better control over the contents of the struct and cleaning up the
  register access code to be more readable.
- Convert to use proper register definition instead of the overloaded
  void *ptr which is dynamically cast into a bitmask (Patch #15.)

Some of the patches touch mach-omap2 code, so Ack from Tony is needed for
patch #5, #6 and patch #15.

Boot tested on the omap2+ boards I have access to, no issues seen caused
by this series.

am335x-evm      : BOOT FAIL! (farm issue, failed to mount NFS rootfs)
am335x-evmsk    : boot ok
am37x-evm       : boot ok
am437x-sk       : boot ok
am437x-gp-evm   : boot ok
am57xx-evm      : boot ok
omap3-beagle-xm : boot ok
omap3-beagle    : boot ok
am335x-boneblack: boot ok
am335x-bone     : boot ok
craneboard      : boot ok
dra72x-evm      : BOOT FAIL! (farm issue, failed to mount NFS rootfs)
dra7xx-evm      : boot ok
ldp3430         : BOOT FAIL! (farm issue, bootloader ethernet failure)
omap3-n900      : boot ok
omap5-uevm      : boot ok
omap4-panda-es  : boot ok
omap4-panda     : boot ok
omap2430-sdp    : boot ok
omap3430-sdp    : boot ok
omap4-sdp-es23plus: boot ok

Branch available against 4.10-rc2 here:

tree: https://github.com/t-kristo/linux-pm.git
branch: 4.10-rc2-ti-clk-cleanup

-Tero

