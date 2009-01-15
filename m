From: Tony Lindgren <tony@atomide.com>
Subject: Re: git-pull request for omap-fixes for 2.6.29-rc1 (Re: [PATCH
	00/10] Omap fixes for 2.6.29-rc1)
Date: Thu, 15 Jan 2009 15:37:47 +0200
Message-ID: <20090115133746.GE4128@atomide.com>
References: <20090112143405.24205.52151.stgit@localhost> <20090113143528.GP7344@atomide.com> <20090115103716.GL2162@n2100.arm.linux.org.uk> <20090115112611.GX29324@atomide.com> <20090115124016.GA20409@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vv4Sf/kQfcwinyKX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56885 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757562AbZAONhv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 08:37:51 -0500
Content-Disposition: inline
In-Reply-To: <20090115124016.GA20409@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090115 14:40]:
> On Thu, Jan 15, 2009 at 01:26:12PM +0200, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090115 12:37]:
> > > On Tue, Jan 13, 2009 at 04:35:29PM +0200, Tony Lindgren wrote:
> > > > * Tony Lindgren <tony@atomide.com> [090112 16:37]:
> > > > > Hi,
> > > > > 
> > > > > Here are some omap fixes for review. Some of these patches
> > > > > were posted earlier.
> > > > 
> > > > If no other comments, here's the pull request:
> > > 
> > > Unfortunately, this breaks stuff.  Whereas before pulling this I get:
> > > 
> > >   CC      drivers/usb/core/hub.o
> > > drivers/usb/core/hub.c: In function `usb_configure_device_otg':
> > > drivers/usb/core/hub.c:1557: error: too few arguments to function `usb_port_suspend'
> > 
> > Hmm, I thought I build all the defconfigs before posting the series.
> > Will update in just few mins.
> 
> Thanks.  It would also be nice if the USB error could be fixed by USB
> folk as well - it's been broken since 2.6.28-git12.  (Maybe people
> should check kautobuild's errors summary page?)
> 
> http://armlinux.simtec.co.uk/kautobuild/<version>/errors.html
> 
> where <version> should be replaced by, eg, 2.6.29-rc1-git4

Regarding the USB hub.c issue, sounds like Dave and Felipe are
already looking into it.

I think I missed the other build errors because I probably forgot
to manually try to rebuild the boards that failed on the usb.c
error..

Here's the updated pull request for the other omap fixes.

Tony


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pull.txt"

The following changes since commit 5393f780277165f282a37ed82dd878159ec9dad5:
  Linus Torvalds (1):
        Merge branch 'merge' of git://git.kernel.org/.../benh/powerpc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes

Anand Gadiyar (1):
      ARM: OMAP: Fix DMA CCR programming for request line > 63, v3

Arun KS (1):
      ARM: OMAP: Fix OSK ASoC by registering I2C board info for tlvaic23

Huang Weiyi (1):
      ARM: OMAP: remove duplicated #include's

Jarkko Nikula (1):
      ARM: OMAP: Fix gpio by switching to generic gpio calls, v2

Tony Lindgren (7):
      ARM: OMAP: Fix compile for various McBSP
      ARM: OMAP: Fix compile for palmte
      ARM: OMAP: Fix compile for beagle
      ARM: OMAP: Fix gpio.c compile on 15xx with CONFIG_DEBUGFS
      ARM: OMAP: Fix ASoC by enabling writes to XCCR and RCCR McBSP registers, v3
      ARM: OMAP: Remove unused platform devices, v3
      ARM: OMAP: Fix compile for h3 MMC

 arch/arm/mach-omap1/board-h2.c             |   45 +-----------
 arch/arm/mach-omap1/board-h3.c             |   50 ------------
 arch/arm/mach-omap1/board-innovator.c      |   39 ---------
 arch/arm/mach-omap1/board-nokia770.c       |    8 ++-
 arch/arm/mach-omap1/board-osk.c            |   43 +----------
 arch/arm/mach-omap1/board-palmte.c         |   29 -------
 arch/arm/mach-omap1/board-palmtt.c         |   41 ----------
 arch/arm/mach-omap1/board-palmz71.c        |   37 ---------
 arch/arm/mach-omap1/board-sx1.c            |   39 +--------
 arch/arm/mach-omap1/board-voiceblue.c      |    1 -
 arch/arm/mach-omap1/mcbsp.c                |    1 +
 arch/arm/mach-omap2/board-apollon.c        |   64 ++--------------
 arch/arm/mach-omap2/board-ldp.c            |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    9 +-
 arch/arm/mach-omap2/mcbsp.c                |    1 +
 arch/arm/plat-omap/dma.c                   |   13 +--
 arch/arm/plat-omap/gpio.c                  |    3 +
 arch/arm/plat-omap/include/mach/aic23.h    |  116 ----------------------------
 arch/arm/plat-omap/include/mach/board-h3.h |    4 +-
 arch/arm/plat-omap/include/mach/gpio.h     |   10 ---
 arch/arm/plat-omap/include/mach/mcbsp.h    |   11 +++
 arch/arm/plat-omap/mcbsp.c                 |    4 +
 drivers/mtd/onenand/omap2.c                |    6 +-
 23 files changed, 58 insertions(+), 518 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/aic23.h

--vv4Sf/kQfcwinyKX--
