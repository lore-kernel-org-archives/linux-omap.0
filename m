From: Tony Lindgren <tony@atomide.com>
Subject: git-pull request for omap-fixes for 2.6.29-rc1 (Re: [PATCH 00/10]
	Omap fixes for 2.6.29-rc1)
Date: Tue, 13 Jan 2009 16:35:29 +0200
Message-ID: <20090113143528.GP7344@atomide.com>
References: <20090112143405.24205.52151.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UPT3ojh+0CqEDtpF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61473 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021AbZAMOfb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 09:35:31 -0500
Content-Disposition: inline
In-Reply-To: <20090112143405.24205.52151.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090112 16:37]:
> Hi,
> 
> Here are some omap fixes for review. Some of these patches
> were posted earlier.

If no other comments, here's the pull request:


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pull.txt"

The following changes since commit c59765042f53a79a7a65585042ff463b69cb248c:
  Linus Torvalds (1):
        Linux 2.6.29-rc1

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

Tony Lindgren (6):
      ARM: OMAP: Fix compile for various McBSP
      ARM: OMAP: Fix compile for palmte
      ARM: OMAP: Fix compile for beagle
      ARM: OMAP: Fix gpio.c compile on 15xx with CONFIG_DEBUGFS
      ARM: OMAP: Fix ASoC by enabling writes to XCCR and RCCR McBSP registers
      ARM: OMAP: Remove unused platform devices for old ALSA code

 arch/arm/mach-omap1/board-h2.c          |   38 ----------
 arch/arm/mach-omap1/board-h3.c          |   38 ----------
 arch/arm/mach-omap1/board-innovator.c   |   39 ----------
 arch/arm/mach-omap1/board-nokia770.c    |    7 ++
 arch/arm/mach-omap1/board-osk.c         |   43 +-----------
 arch/arm/mach-omap1/board-palmte.c      |   29 --------
 arch/arm/mach-omap1/board-palmtt.c      |   41 -----------
 arch/arm/mach-omap1/board-palmz71.c     |   37 ----------
 arch/arm/mach-omap1/board-sx1.c         |   38 +---------
 arch/arm/mach-omap1/board-voiceblue.c   |    1 -
 arch/arm/mach-omap1/mcbsp.c             |    1 +
 arch/arm/mach-omap2/board-apollon.c     |   64 ++---------------
 arch/arm/mach-omap2/board-ldp.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c |    9 ++-
 arch/arm/mach-omap2/mcbsp.c             |    1 +
 arch/arm/plat-omap/dma.c                |   13 ++--
 arch/arm/plat-omap/gpio.c               |    3 +
 arch/arm/plat-omap/include/mach/aic23.h |  116 -------------------------------
 arch/arm/plat-omap/include/mach/gpio.h  |   10 ---
 arch/arm/plat-omap/include/mach/mcbsp.h |    7 ++
 arch/arm/plat-omap/mcbsp.c              |    4 +
 drivers/mtd/onenand/omap2.c             |    6 +-
 22 files changed, 49 insertions(+), 498 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/aic23.h

--UPT3ojh+0CqEDtpF--
