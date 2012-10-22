From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 0/7] crypto: omap-sham updates
Date: Mon, 22 Oct 2012 12:46:46 -0700
Message-ID: <20121022194646.GD1708@animalcreek.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
 <50839614.1080607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:56833 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab2JVTqr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 15:46:47 -0400
Content-Disposition: inline
In-Reply-To: <50839614.1080607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@listse.infradead.orgp

On Sun, Oct 21, 2012 at 11:58:36AM +0530, Santosh Shilimkar wrote:
> Mark,

Hi Santosh.

> On Saturday 20 October 2012 03:23 AM, Mark A. Greer wrote:
> >From: "Mark A. Greer" <mgreer@animalcreek.com>
> >
> >This series updates the crypto omap-sham driver and supporting
> >infrastructure.
> >
> >Notes:
> >
> >a) Based on current k.o. c9623de (Merge branch 'v4l_for_linus'
> >    of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
> >
> >b) These have only been tested on an omap2420 h4 and an am37x evm.  If you
> >    have different hardware available and a few minutes, please test them.
> >    A quick and easy test is to enable tcrypt as a module
> >    (CONFIG_CRYPTO_TEST=m), boot, then run 'modprobe tcrypt sec=2 mode=403'.
> >    'CONFIG_CRYPTO_SHA1' and 'CONFIG_CRYPTO_DEV_OMAP_SHAM' also have to be
> >    enabled.  A quick 'grep omap-sham /proc/interrupts' will tell you if
> >    the omap-sham driver was really used.
> >
> >c) To test these patches, you will likely need...
> >    i) The patch included here:
> >	   http://marc.info/?l=kernel-janitors&m=134910841909057&w=2
> >    ii) This patch from linux-omap/master:
> >	   27615a9 (ARM: OMAP: Trivial driver changes to remove include
> >			   plat/cpu.h)
> >    iii) This patch from Paul Walmsley:
> >	   http://www.spinics.net/lists/linux-omap/msg79436.html
> >
> >d) If you prefer, a version you can test is available at
> >    git@github.com:mgreeraz/linux-mag.git mag/wip/crypto-test
> >
> >e) There is a reduction in DMA performance after switching to dmaengine
> >    (see http://www.spinics.net/lists/linux-omap/msg79855.html)
> >
> >f) Many thanks to Jon Hunter for testing on his omap2420 h4.
> >
> >Mark A. Greer (7):
> >   ARM: OMAP2xxx: hwmod: Convert SHAM crypto device data to hwmod
> >   ARM: OMAP2xxx: hwmod: Add DMA information for SHAM module
> >   ARM: OMAP3xxx: hwmod: Convert SHAM crypto device data to hwmod
> >   ARM: OMAP2+: Remove unnecessary message when no SHA IP is present
> >   crypto: omap-sham: Convert to use pm_runtime API
> >   crypto: omap-sham: Add code to use dmaengine API
> >   crypto: omap_sham: Remove usage of private DMA API
> >
> Thanks for the series and oveall its looks pretty good to me.
> The DMA performance is understandable with need of PREFETCH
> support in OMAP DMA engine driver. IIRC, crypto was the only
> driver used this feature.

That's correct.

> From the history mostly we need
> to restrict the prefetch usage to applicable client driver
> like crypto and hence adding such parameter/api support
> might be the direction to go forward. Lets see what Peter
> reports for audio as discussed on other thread.

I agree.  I'm looking forward to hearing from Peter on this too.

Mark
--
