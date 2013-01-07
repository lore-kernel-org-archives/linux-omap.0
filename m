From: Tony Lindgren <tony@atomide.com>
Subject: Re: Build failure with DMA_OMAP=m and a caller built-in
Date: Mon, 7 Jan 2013 12:21:06 -0800
Message-ID: <20130107202106.GG14149@atomide.com>
References: <1357449969.4324.25.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:16194 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751307Ab3AGUVL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jan 2013 15:21:11 -0500
Content-Disposition: inline
In-Reply-To: <1357449969.4324.25.camel@deadeye.wl.decadent.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-kbuild@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>

* Ben Hutchings <ben@decadent.org.uk> [130105 21:29]:
> Various drivers use omap_dma_filter_fn() but don't depend on DMA_OMAP.
> This is fine because there is a trivial inline definition in case
> DMA_OMAP is disabled... until the caller is built-in and DMA_OMAP=m.
> 
> I tried adding the rather weird 'select DMA_OMAP if DMA_OMAP!=n' to
> these drivers' kconfig symbols to promote it to built-in if necessary.
> This sort of works but kconfig complains about the circular dependency
> and it becomes impossible to disable DMA_OMAP in the 'make nconfig'
> menu.  So that's not the right thing to do.
> 
> Any ideas?

Hmm let's ask Russell and Vinod what they are envisioning. I believe
there was some talk about removing the filter functions?

For the short term fix, how about ifdef out the DMA usage in the
client drivers:

#if defined(CONFIG_DMA_OMAP_MODULE) && defined(CONFIG_MMC_OMAP_MODULE)
	...
#endif

Regards,

Tony
