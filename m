From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 0/9] clk: ti: add support for clkctrl clocks
Date: Fri, 17 Mar 2017 11:09:32 +0200
Message-ID: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

>From functional code point of view, this is mostly just a rebase of v1 of the
series on top of 4.11-rc1:

https://www.spinics.net/lists/arm-kernel/msg562460.html

This series depends on the TI clock cleanup series I posted last week:

https://www.spinics.net/lists/arm-kernel/msg567920.html

Patch #5 has been changed to accommodate for the existence of multiple
hwmods under single DT node, for example the "ocp" node for omap4
contains 3 hwmods for the different buses; support for this is enabled
by accepting index for the clkctrl clocks also.

Patch #6 is a new one to properly assign the clock for timers. This is
needed as currently timer code only fetches the main clock info from
hwmod itself.

Patches #7, #8 and #9 add the DT data for omap4.

Boot tested on am335x-evm, am335x-evmsk, am47x-evm, am437x-sk, am437x-gp-evm,
  am57xx-evm, omap3-beagle-xm, omap3-beagle, am335x-boneblack, craneboard,
  dra72x-evm, dra7xx-evm, n900, omap5-uevm, omap4-panda-es, omap4-panda,
  omap2430-sdp, omap3430-sdp, omap4430-sdp.

Suspend-resume tested on omap4-panda-es.

Any additional testing on omap4 welcome as this series basically
tweaks every possible peripheral clock on the SoC.

Branch available on top of 4.11-rc1 (+ the cleanup series) here:

tree: https://github.com/t-kristo/linux-pm.git
branch: for-4.12-ti-clkctrl

-Tero

