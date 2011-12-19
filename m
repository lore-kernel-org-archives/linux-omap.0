From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap ehci related changes for v3.3 merge window
Date: Mon, 19 Dec 2011 11:51:08 -0800
Message-ID: <20111219195107.GR6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39050 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab1LSTvO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 14:51:14 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull omap echi changes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap ehci

These are needed for runtime PM support for the usb *hci controllers
on omap. These depend on the fixes-non-critical-part2 + hwmod branches
posted earlier.

Regards,

Tony


The following changes since commit 986b0c256b3b7920502969641a1cb6d2c525b750:
  Tony Lindgren (1):
        Merge branch 'hwmod_data_devel_3.3' of git://git.pwsan.com/linux-2.6 into hwmod

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap ehci

Keshava Munegowda (4):
      ARM: OMAP: USB: register hwmods of usbhs
      ARM: OMAP: USB: device name change for the clk names of usbhs
      ARM: OMAP: USBHOST: Replace usbhs core driver APIs by Runtime pm APIs
      MFD: OMAP: USB: Runtime PM support

Tony Lindgren (1):
      Merge branch 'usbhost_runtime_pm_14_devel_3.3' of git://git.pwsan.com/linux-2.6 into ehci

 arch/arm/mach-omap2/clock3xxx_data.c  |   26 +-
 arch/arm/mach-omap2/clock44xx_data.c  |   10 +-
 arch/arm/mach-omap2/usb-host.c        |  100 ++---
 arch/arm/plat-omap/include/plat/usb.h |    3 -
 drivers/mfd/omap-usb-host.c           |  755 +++++++++++++--------------------
 drivers/usb/host/ehci-omap.c          |   17 +-
 drivers/usb/host/ohci-omap3.c         |   18 +-
 7 files changed, 369 insertions(+), 560 deletions(-)
