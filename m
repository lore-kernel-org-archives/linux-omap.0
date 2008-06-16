From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/02] ARM: OMAP: DMA: Don't mark channel active in
	omap_enable_channel_irq
Date: Mon, 16 Jun 2008 12:59:41 +0300
Message-ID: <20080616095941.GH7885@atomide.com>
References: <1212801708-17599-1-git-send-email-tony@atomide.com> <20080614080222.GE32122@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59809 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758561AbYFPJ7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2008 05:59:15 -0400
Content-Disposition: inline
In-Reply-To: <20080614080222.GE32122@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080614 11:02]:
> On Fri, Jun 06, 2008 at 06:21:47PM -0700, Tony Lindgren wrote:
> > From: Jarkko Nikula <jarkko.nikula@nokia.com>
> > 
> > Channel should be marked active only when DMA is really started. Otherwise
> > just omap_request_dma, omap_dma_link_lch and omap_dma_unlink_lch will cause
> > incorrect dump_stack().
> > 
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> BTW, this looks like something for -rc kernels.

Yes these two are intended for the -rc kernel. The 0/2 header email got
separated as specifying git-send-email Reply-to option did not quite work..

Can you please pull these two patches from omap-fixes branch:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes

Thanks,

Tony
