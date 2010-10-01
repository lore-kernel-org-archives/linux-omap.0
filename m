From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
 finish
Date: Fri, 1 Oct 2010 16:23:42 -0700
Message-ID: <20101001232342.GK3117@atomide.com>
References: <1285936577-14881-1-git-send-email-peter.ujfalusi@nokia.com>
 <1285936577-14881-3-git-send-email-peter.ujfalusi@nokia.com>
 <20101001165542.GS3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61273 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab0JAXXr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 19:23:47 -0400
Content-Disposition: inline
In-Reply-To: <20101001165542.GS3117@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

* Tony Lindgren <tony@atomide.com> [101001 09:47]:
> 
> Thinking about moving to use dmaengine.c, we should not use
> cpu_is_omapxxxx except during the platform init.
> 
> Can you please change this to be in u32 flags in dma.c that get set during
> the init only for omap3? Then we can have something like:
> 
> #define OMAP_DMA_ERRATA_AAA	(1 << 2)
> #define OMAP_DMA_ERRATA_BBB	(1 << 0)
> ...

BTW, can you also please Cc linux-arm-kernel on your patches?
That way I don't need to repost them.

Also, we might be able to get these two in as fixes.

Regards,

Tony
