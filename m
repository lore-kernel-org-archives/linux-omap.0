From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] reworked omap usb pdata changes for v3.9 merge window
Date: Thu, 14 Feb 2013 16:35:44 -0800
Message-ID: <20130215003543.GF11806@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:59390 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759753Ab3BOAfx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 19:35:53 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Roger Quadros reworked the OMAP USB patches that were causing
a conflict in Linux next and we requested to be dropped from
Linux next and reworked to remove the dependencies between
core SoC code and the driver code.

Below is a pull request for the mach-omap2 specific parts, the
rest is driver specific and queued by Samuel in the MFD tree
and Greg for the USB changes.

I've left it unresolved so you can merge it into one of your
branches as a dependency so we can avoid the merge conflict
in Linux next. A link to the merge resolution done by Stephen
is in the pull request. Let me know if you want me to resolve
it instead. 

Regards,

Tony


The following changes since commit 836dc9e3fbbab0c30aa6e664417225f5c1fb1c39:

  Linux 3.8-rc7 (2013-02-09 08:20:39 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/usb-signed

for you to fetch changes up to 64ff1673332a1109780d731ca08dcd4f8ad33097:

  Merge branch 'usbhost17-for-arm-soc' of git://github.com/rogerq/linux into omap-for-v3.9/usb (2013-02-14 08:36:17 -0800)

----------------------------------------------------------------

These changes contain the OMAP USB related platform data changes
that were dropped from linux next because of the merge conflicts
as requested by me and Olof. The reason was that at this point
we really should be able to do the arch/arm related changes
separately from driver changes to avoid dependencies between
branches.

These patches were initially part of the USB related MFD patches.
Based on our comments, Roger Quadros quickly reworked these
patches into a shared branch between ARM SoC tree and the MFD
tree, then separate patches for the OMAP platform data and
MFD driver.

Note that this branch will conflict with c1d1cd597fc7
("ARM: OMAP2+: omap_device: remove obsolete pm_lats and
early_device code"). Please see http://lkml.org/lkml/2013/2/11/16
for the merge resolution.

----------------------------------------------------------------
Roger Quadros (2):
      ARM: OMAP: Consolidate OMAP USB-HS platform data (part 1/3)
      ARM: OMAP: Consolidate OMAP USB-HS platform data (part 3/3)

Tony Lindgren (1):
      Merge branch 'usbhost17-for-arm-soc' of git://github.com/rogerq/linux into omap-for-v3.9/usb

 arch/arm/mach-omap2/board-3430sdp.c        |  2 +-
 arch/arm/mach-omap2/board-3630sdp.c        |  2 +-
 arch/arm/mach-omap2/board-am3517crane.c    |  2 +-
 arch/arm/mach-omap2/board-am3517evm.c      |  2 +-
 arch/arm/mach-omap2/board-cm-t35.c         |  2 +-
 arch/arm/mach-omap2/board-cm-t3517.c       |  2 +-
 arch/arm/mach-omap2/board-devkit8000.c     |  2 +-
 arch/arm/mach-omap2/board-igep0020.c       |  4 ++--
 arch/arm/mach-omap2/board-omap3beagle.c    |  2 +-
 arch/arm/mach-omap2/board-omap3evm.c       |  2 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |  2 +-
 arch/arm/mach-omap2/board-omap3stalker.c   |  2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |  2 +-
 arch/arm/mach-omap2/board-omap4panda.c     |  2 +-
 arch/arm/mach-omap2/board-overo.c          |  2 +-
 arch/arm/mach-omap2/board-zoom.c           |  2 +-
 arch/arm/mach-omap2/usb-host.c             | 29 +++++------------------------
 arch/arm/mach-omap2/usb.h                  | 20 +-------------------
 include/linux/platform_data/usb-omap.h     |  8 ++++++--
 19 files changed, 29 insertions(+), 62 deletions(-)
