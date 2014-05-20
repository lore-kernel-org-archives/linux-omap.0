From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/4] omap board changes for v3.16 merge window
Date: Mon, 19 May 2014 18:31:08 -0700
Message-ID: <20140520013107.GG15793@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17054 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbaETBbP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 21:31:15 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd:

  Linux 3.15-rc4 (2014-05-04 18:14:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/board-signed

for you to fetch changes up to 77c2f02edbeda9409a7cf3fd66233015820c213a:

  ARM: OMAP: replace checks for CONFIG_USB_GADGET_OMAP (2014-05-16 14:14:25 -0700)

----------------------------------------------------------------
Board related changes for omaps.

----------------------------------------------------------------
Paul Bolle (5):
      ARM: OMAP: omap3stalker: remove two Kconfig macros
      ARM: OMAP: remove some dead code
      ARM: OMAP: SX1: remove check for CONFIG_SX1_OLD_FLASH
      ARM: OMAP: AM3517EVM: remove check for CONFIG_PANEL_SHARP_LQ043T1DG01
      ARM: OMAP: replace checks for CONFIG_USB_GADGET_OMAP

Sebastian Reichel (1):
      ARM: OMAP2+: Add support for RNG on DT booted N900

 arch/arm/mach-omap1/board-h2.c           |  2 +-
 arch/arm/mach-omap1/board-h3.c           |  2 +-
 arch/arm/mach-omap1/board-innovator.c    |  2 +-
 arch/arm/mach-omap1/board-osk.c          |  2 +-
 arch/arm/mach-omap1/board-sx1.c          | 26 --------------------------
 arch/arm/mach-omap1/pm.c                 | 13 +------------
 arch/arm/mach-omap2/board-am3517evm.c    |  5 -----
 arch/arm/mach-omap2/board-omap3stalker.c |  4 ----
 arch/arm/mach-omap2/pdata-quirks.c       | 12 ++++++++++++
 drivers/usb/phy/phy-isp1301-omap.c       |  2 +-
 10 files changed, 18 insertions(+), 52 deletions(-)
