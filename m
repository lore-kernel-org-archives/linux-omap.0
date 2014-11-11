From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap non-urgent fixes for v3.19
Date: Tue, 11 Nov 2014 09:14:28 -0800
Message-ID: <388.98588759384$1415726143@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18040 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbaKKRPd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2014 12:15:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:

  Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/fixes-not-urgent-part1

for you to fetch changes up to 7aff221c5dbe4f88930a64531df2236f303e1851:

  ARM: OMAP: serial: remove last vestige of DTR_gpio support. (2014-11-10 09:06:44 -0800)

----------------------------------------------------------------
Fixes for omap3 that are not urgent. Mostly to remove unnecessary
noise during the boot with pointless errors and warnings.

----------------------------------------------------------------
Masanari Iida (1):
      ARM: OMAP2: Remove unnecessary KERN_* in omap_phy_internal.c

NeilBrown (1):
      ARM: OMAP: serial: remove last vestige of DTR_gpio support.

Roger Quadros (1):
      ARM: OMAP2+: gpmc: Get rid of "ti,elm-id not found" warning

Tony Lindgren (5):
      ARM: OMAP3: Fix errors for omap_l3_smx when booted with device tree
      ARM: dts: Fix NAND last partition size on LDP
      ARM: dts: Add twl keypad map for LDP
      ARM: dts: Add twl keypad map for omap3 EVM
      ARM: OMAP4+: Remove unused omap_l3_noc platform init

 arch/arm/boot/dts/omap3-evm-common.dtsi   | 21 ++++++++++++++++++
 arch/arm/boot/dts/omap3-ldp.dts           | 23 +++++++++++++++++++-
 arch/arm/boot/dts/omap3.dtsi              |  2 +-
 arch/arm/mach-omap2/devices.c             | 36 +------------------------------
 arch/arm/mach-omap2/gpmc.c                |  2 --
 arch/arm/mach-omap2/omap_phy_internal.c   |  8 ++++---
 arch/arm/mach-omap2/serial.c              |  3 ---
 drivers/bus/omap_l3_smx.c                 | 26 +++++++++++++++++-----
 include/linux/platform_data/serial-omap.h |  3 ---
 9 files changed, 71 insertions(+), 53 deletions(-)
