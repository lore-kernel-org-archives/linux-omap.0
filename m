From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.5-rc3
Date: Thu, 21 Jun 2012 09:20:26 -0700
Message-ID: <20120621162026.GW12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:28924 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759724Ab2FUQUa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 12:20:30 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:

  Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-for-v3.5-rc3

for you to fetch changes up to aef2b89662b8a7506846d0dc0df672d196ddf8d0:

  ARM: OMAP: Fix Beagleboard DVI reset gpio (2012-06-20 07:18:21 -0700)

----------------------------------------------------------------
Here are a few fixes with the biggest one being fix for Beagle DVI
reset. All of them are regression fixes, except for the missing omap2
interrupt controller binding that somehow got missed earlier.

----------------------------------------------------------------
Jon Hunter (1):
      arm/dts: OMAP2: Fix interrupt controller binding

Russ Dill (1):
      ARM: OMAP: Fix Beagleboard DVI reset gpio

Tony Lindgren (2):
      ARM: OMAP2+: Fix MUSB ifdefs for platform init code
      ARM: OMAP2: Fix tusb6010 GPIO interrupt for n8x0

 arch/arm/boot/dts/omap2.dtsi            |    2 ++
 arch/arm/mach-omap2/board-n8x0.c        |    6 ++----
 arch/arm/mach-omap2/board-omap3beagle.c |   28 ++++++++++++----------------
 arch/arm/mach-omap2/omap_phy_internal.c |    6 ------
 arch/arm/mach-omap2/usb-musb.c          |    6 ++----
 arch/arm/mach-omap2/usb-tusb6010.c      |    2 +-
 6 files changed, 19 insertions(+), 31 deletions(-)
