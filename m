From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.10-rc1
Date: Fri, 17 May 2013 12:25:16 -0700
Message-ID: <20130517192515.GC5600@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37848 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725Ab3EQTZV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 15:25:21 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10-rc1/fixes

for you to fetch changes up to a6d25f4c951b8b28f2eaec6f891ff834622532f2:

  ARM: AM33XX: Add missing .clkdm_name to clkdiv32k_ick clock (2013-05-17 10:07:45 -0700)

----------------------------------------------------------------
Fixes for omaps:

- a section mismatch fix for hwmod
- boot fix for omap2plus_defconfig for omap2
- musb interrupt fix when using device tree
- am33xx clock fix that I missed earlier somehow
- omap1 dma return code error fix

----------------------------------------------------------------
Paul Walmsley (1):
      ARM: OMAP2+: Add missing CONFIG_ARCH_MULTI_V6=y to omap2plus_defconfig

Tony Lindgren (1):
      ARM: dts: Fix musb interrupt for device tree booting

Vaibhav Hiremath (1):
      ARM: AM33XX: Add missing .clkdm_name to clkdiv32k_ick clock

Wei Yongjun (1):
      ARM: OMAP: fix error return code in omap1_system_dma_init()

jean-philippe francois (1):
      ARM: OMAP: fix __init section mismatch for _enable_preprogram

 arch/arm/boot/dts/omap3.dtsi          |  2 +-
 arch/arm/configs/omap2plus_defconfig  |  1 +
 arch/arm/mach-omap1/dma.c             |  1 +
 arch/arm/mach-omap2/cclock33xx_data.c | 26 +++++++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod.c      |  2 +-
 5 files changed, 27 insertions(+), 5 deletions(-)
