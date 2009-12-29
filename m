From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PULL REQUEST] arm omap patches for -next merge window
Date: Tue, 29 Dec 2009 15:50:02 -0800
Message-ID: <20091229235002.GP3512@atomide.com>
References: <1262127697.28789.92.camel@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52216 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbZL2XuE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 18:50:04 -0500
Content-Disposition: inline
In-Reply-To: <1262127697.28789.92.camel@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [091229 14:59]:
> After these, all the patches I have for you are
> done, besides the CBUS stuff which I want to test
> further. DSME is turning off my device right after
> boot so I can't really test anything. If you have
> some hint, I'd be glad to hear ;-)
> 
> The following changes since commit
> bb65718ad7ed3c4231f67cf3f8b4a9a071bdfd53:
>   Felipe Balbi (1):
>         arm: omap: perseus: kill compile warning on board-perseus2.c
> 
> are available in the git repository at:
> 
>   git://gitorious.org/usb/usb.git for-tony-next

This too should be against Linus' -rc2. Also, please
leave out the changes to drivers/usb/musb, I don't want
to pull those into for-next as they'll go through Greg.
We can add any patches like that to omap-testing branch
temporarily. That way people using linux-omap tree can
test them.

Regards,

Tony
 
> Felipe Balbi (9):
>       arm: omap: musb: remove unused data
>       arm: omap: musb: we can use clk framework
>       arm: omap: musb: remove unused soft_con field
>       arm: omap: musb: remove unused dma data
>       arm: omap: musb: remove unnecessary return
>       arm: omap: gpmc: avoid section definitions on headers
>       usb: musb: use only clk framework for clk handling
>       arm: omap: musb: do not pass clock name to driver
>       arm: omap: musb: get rid of dyn_fifo
> 
>  arch/arm/mach-omap2/usb-musb.c         |   71
> +-------------------------------
>  arch/arm/plat-omap/include/plat/gpmc.h |    2 +-
>  drivers/usb/musb/musb_core.c           |   48 +++++++--------------
>  drivers/usb/musb/musb_core.h           |    2 -
>  drivers/usb/musb/omap2430.c            |   10 +----
>  drivers/usb/musb/tusb6010.c            |   16 +++----
>  include/linux/usb/musb.h               |    4 +-
>  7 files changed, 28 insertions(+), 125 deletions(-)
> 
> -- 
> balbi
> 
