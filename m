From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/4] non-urgent omap fixes for v3.14 merge window
Date: Wed, 8 Jan 2014 17:19:40 -0800
Message-ID: <20140109011940.GI31323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63127 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaAIBTr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jan 2014 20:19:47 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 413541dd66d51f791a0b169d9b9014e4f56be13c:

  Linux 3.13-rc5 (2013-12-22 13:08:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/fixes-not-urgent-signed

for you to fetch changes up to bbc28cdbd003be5ceeaf644be3533e898c25da2b:

  ARM: OMAP2+: gpmc: Move legacy GPMC width setting (2014-01-08 09:49:47 -0800)

----------------------------------------------------------------
Some non-urgent fixes to enable am335x features, update documentation,
and to remove unnecessary double initialization for the GPMC code.

----------------------------------------------------------------
Ezequiel Garcia (4):
      ARM: OMAP2+: Select USB PHY for AM335x SoC
      ARM: OMAP2+: gpmc: Move initialization outside the gpmc_t condition
      ARM: OMAP2+: gpmc: Introduce gpmc_set_legacy()
      ARM: OMAP2+: gpmc: Move legacy GPMC width setting

Jyri Sarha (1):
      ARM: OMAP2+: enable AM33xx SOC EVM audio

Nishanth Menon (2):
      Documentation: dt: OMAP: explicitly state SoC compatible strings
      ARM: OMAP2+: board-generic: update SoC compatibility strings

 .../devicetree/bindings/arm/omap/omap.txt          | 53 ++++++++++++++++++++++
 arch/arm/configs/omap2plus_defconfig               |  3 ++
 arch/arm/mach-omap2/board-generic.c                |  7 +++
 arch/arm/mach-omap2/gpmc-nand.c                    | 50 +++++++++++---------
 4 files changed, 91 insertions(+), 22 deletions(-)
