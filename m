From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [GIT] pull request: DMA hwmod changes
Date: Tue, 21 Dec 2010 07:41:52 +0530
Message-ID: <20101221021152.GA18883@manju-desktop>
References: <20101219035948.GC15568@GLPP-machine>
 <4D0F33C9.40402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:56862 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933294Ab0LUCME (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 21:12:04 -0500
Received: by yxs7 with SMTP id 7so1509642yxs.10
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 18:12:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D0F33C9.40402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Sawant, Anand" <sawant@ti.com>

Hi Tony,
Benoit comments are taken care and new pull request is generated as
below. The omap4 hwmod database for dma is rearranged as per Benoit's
convention + no idlest flag entry is removed + sysc_flags are barrowed
from latest omap4 hwmod data base.

The changes are aligned and benoit has agreed for these changes.

Tested again on OMAP4 SDP(boot and DMA tests) and here is pull request
against linux omap master branch.

The following changes since commit 205e4d6e8d892176d791b77a974efe7f561ca4c3:

  Merge branch 'for-next' (2010-12-17 19:32:47 -0800)

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git dma_for_2.6.38

Benoit Cousson (1):
      OMAP4: hwmod data: add system DMA

G, Manjunath Kondaiah (8):
      OMAP: DMA: Replace read/write macros with functions
      OMAP: DMA: Introduce errata handling feature
      OMAP2420: hwmod data: add system DMA
      OMAP2430: hwmod data: add system DMA
      OMAP3: hwmod data: add system DMA
      OMAP1: DMA: Implement in platform device model
      OMAP2+: DMA: hwmod: Device registration
      OMAP: DMA: Convert DMA library into platform driver

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/dma.c                  |  390 ++++++++++++++++
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/dma.c                  |  297 ++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   86 ++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   86 ++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   97 ++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  102 ++++
 arch/arm/plat-omap/dma.c                   |  697 ++++++++++++----------------
 arch/arm/plat-omap/include/plat/dma.h      |  232 ++++------
 10 files changed, 1451 insertions(+), 540 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dma.c
 create mode 100644 arch/arm/mach-omap2/dma.c

-Manjunath

On Mon, Dec 20, 2010 at 11:45:29AM +0100, Cousson, Benoit wrote:
> Hi Manju,
> 
> I still have 2 comments on the patch #6: OMAP4: hwmod data: add system DMA.
> 
> I'll sent them in a couple of minutes.
> 
> Regards,
> Benoit
> 
> On 12/19/2010 4:59 AM, G, Manjunath Kondaiah wrote:
> >Hi Tony,
> >Please pull the following dma hwmod changes into linux omap master
> >branch.
> >
> >This pull request includes
> >v2[http://thread.gmane.org/gmane.linux.ports.arm.omap/48695]
> >+
> >paul's sidle mode comments incorporated
> >+
> >acks for patch 3 and 4.
> >
> >The final series is boot tested on:
> >OMAP3530(Beagle)
> >N800
> >SDP2430
> >OMAP4430SDP(ES2.1)
> >
> >Full testing is done once again for SDP2430 and logs can be accessed at:
> >http://pastebin.com/aJZGjdar
> >
> >The following changes since commit
> >205e4d6e8d892176d791b77a974efe7f561ca4c3:
> >
> >   Merge branch 'for-next' (2010-12-17 19:32:47 -0800)
> >
> >are available in the git repository at:
> >
> >   git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git dma_hwmod
> >
> >Benoit Cousson (1):
> >       OMAP4: hwmod data: add system DMA
> >
> >G, Manjunath Kondaiah (8):
> >       OMAP: DMA: Replace read/write macros with functions
> >       OMAP: DMA: Introduce errata handling feature
> >       OMAP2420: hwmod data: add system DMA
> >       OMAP2430: hwmod data: add system DMA
> >       OMAP3: hwmod data: add system DMA
> >       OMAP1: DMA: Implement in platform device model
> >       OMAP2+: DMA: hwmod: Device registration
> >       OMAP: DMA: Convert DMA library into platform driver
> >
> >  arch/arm/mach-omap1/Makefile               |    2 +-
> >  arch/arm/mach-omap1/dma.c                  |  390 ++++++++++++++++
> >  arch/arm/mach-omap2/Makefile               |    2 +-
> >  arch/arm/mach-omap2/dma.c                  |  297 ++++++++++++
> >  arch/arm/mach-omap2/omap_hwmod_2420_data.c |   86 ++++
> >  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   86 ++++
> >  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   97 ++++
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  101 ++++
> >  arch/arm/plat-omap/dma.c                   |  697
> >++++++++++++----------------
> >  arch/arm/plat-omap/include/plat/dma.h      |  232 ++++------
> >  10 files changed, 1450 insertions(+), 540 deletions(-)
> >  create mode 100644 arch/arm/mach-omap1/dma.c
> >  create mode 100644 arch/arm/mach-omap2/dma.c
> 
