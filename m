From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 00/15] clk: ti: cleanups for 4.12 merge window
Date: Sat, 11 Mar 2017 14:49:51 +0200
Message-ID: <1489236606-24023-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series is basically just a rebase of v1 of the same, with Tony's
acks added.

https://www.spinics.net/lists/arm-kernel/msg562362.html

Boot tested on the omap2+ boards I have access to, no issues seen caused
by this series.

am335x-evm      : boot ok
am335x-evmsk    : boot ok
am37x-evm       : boot ok
am437x-sk       : boot ok
am437x-gp-evm   : boot ok
am57xx-evm      : boot ok
omap3-beagle-xm : boot ok
omap3-beagle    : boot ok
am335x-boneblack: boot ok
am335x-bone     : boot ok
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

Branch available on top of 4.11-rc1 here:

tree: https://github.com/t-kristo/linux-pm.git
branch: for-4.12-ti-clk-cleanups

-Tero

