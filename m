From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PULL REQUEST] arm omap patches for -next merge window
Date: Wed, 30 Dec 2009 02:00:13 +0200
Message-ID: <1262131213.28789.133.camel@gandalf>
References: <1262127697.28789.92.camel@gandalf>
	 <20091229235002.GP3512@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39856 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZL3AAU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 19:00:20 -0500
In-Reply-To: <20091229235002.GP3512@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2009-12-29 at 15:50 -0800, Tony Lindgren wrote:
> * Felipe Balbi <me@felipebalbi.com> [091229 14:59]:
> > After these, all the patches I have for you are
> > done, besides the CBUS stuff which I want to test
> > further. DSME is turning off my device right after
> > boot so I can't really test anything. If you have
> > some hint, I'd be glad to hear ;-)
> > 
> > The following changes since commit
> > bb65718ad7ed3c4231f67cf3f8b4a9a071bdfd53:
> >   Felipe Balbi (1):
> >         arm: omap: perseus: kill compile warning on board-perseus2.c
> > 
> > are available in the git repository at:
> > 
> >   git://gitorious.org/usb/usb.git for-tony-next
> 
> This too should be against Linus' -rc2. Also, please
> leave out the changes to drivers/usb/musb, I don't want
> to pull those into for-next as they'll go through Greg.
> We can add any patches like that to omap-testing branch
> temporarily. That way people using linux-omap tree can
> test them.

Ok all fixed now, here's a new pull request:

The following changes since commit
6b7b284958d47b77d06745b36bc7f36dab769d9b:
  Linus Torvalds (1):
        Linux 2.6.33-rc2

are available in the git repository at:

  git://gitorious.org/usb/usb.git for-tony-next

Felipe Balbi (8):
      arm: omap: musb: remove unused data
      arm: omap: musb: we can use clk framework
      arm: omap: musb: remove unused soft_con field
      arm: omap: musb: remove unused dma data
      arm: omap: musb: remove unnecessary return
      arm: omap: gpmc: avoid section definitions on headers
      arm: omap: musb: do not pass clock name to driver
      arm: omap: musb: get rid of dyn_fifo

 arch/arm/mach-omap2/usb-musb.c         |   71
+-------------------------------
 arch/arm/plat-omap/include/plat/gpmc.h |    2 +-
 2 files changed, 2 insertions(+), 71 deletions(-)


-- 
balbi

