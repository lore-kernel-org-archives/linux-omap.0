From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] Urgent omap4 legacy interrupt regression fix for v3.19-rc
 series
Date: Mon, 19 Jan 2015 15:09:51 -0800
Message-ID: <20150119230950.GA7718@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39316 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbbASXNU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 18:13:20 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 7ac72746aa9bb305fa74b44ec73eae99bbbe9b66:

  ARM: dts: Revert disabling of smc91x for n900 (2015-01-06 08:49:57 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/gic-regression-v2

for you to fetch changes up to 0fb22a8fb7f3bc1b00a36d4a97ce4f93191f7559:

  ARM: OMAP: Work around hardcoded interrupts (2015-01-17 08:56:12 -0800)

----------------------------------------------------------------
A rather urgent pull request to fix omap4 legacy interrupts.

The legacy interrupts on omap4 got broken when gic got changed to
use irq_domain_add_linear() instead of the irq_domain_add_legacy(). We
still have the hardcoded legacy IRQ numbers in use in several places,
most notably the in the legacy DMA. It took a while to figure out
what the problem was and how it should be fixed for the -rc series.

Also include is a regression fix for the dra7 dwc3 suspend.

----------------------------------------------------------------
Felipe Balbi (1):
      arm: boot: dts: dra7: enable dwc3 suspend PHY quirk

Marc Zyngier (1):
      ARM: OMAP: Work around hardcoded interrupts

 arch/arm/boot/dts/dra7.dtsi                |  6 ++++++
 arch/arm/mach-omap2/common.h               |  1 +
 arch/arm/mach-omap2/omap4-common.c         | 32 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c           | 10 ++++++++--
 arch/arm/mach-omap2/omap_hwmod.h           |  1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  5 +++++
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  1 +
 arch/arm/mach-omap2/prcm-common.h          |  1 +
 arch/arm/mach-omap2/prm44xx.c              |  5 ++++-
 arch/arm/mach-omap2/prm_common.c           | 14 +++++++++++--
 arch/arm/mach-omap2/twl-common.c           |  7 ++++++-
 11 files changed, 77 insertions(+), 6 deletions(-)
