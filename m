From: Tony Lindgren <tony@atomide.com>
Subject: Re: MMC related patches
Date: Thu, 12 Nov 2009 14:53:48 -0800
Message-ID: <20091112225348.GI24837@atomide.com>
References: <00b401ca632b$8c84d6e0$544ff780@am.dhcp.ti.com>
 <20091112022931.GV24837@atomide.com>
 <009601ca63e6$8390c010$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55559 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbZKLWxp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 17:53:45 -0500
Content-Disposition: inline
In-Reply-To: <009601ca63e6$8390c010$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

* Madhusudhan <madhu.cr@ti.com> [091112 14:21]:
> 
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Wednesday, November 11, 2009 8:30 PM
> > To: Madhusudhan
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: MMC related patches
> > 
> > * Madhusudhan <madhu.cr@ti.com> [091111 16:02]:
> > > Hi Tony,
> > >
> > > Just a ping on the below patches. I did not see any comments on them.
> > Are
> > > you planning to push them?
> > >
> > > Regards,
> > > Madhu
> > >
> > > http://marc.info/?l=linux-omap&m=125668573422479&w=2
> > > http://marc.info/?l=linux-omap&m=125624185318767&w=2
> > 
> > OK, adding.
> > 
> > > http://marc.info/?l=linux-omap&m=125623349405262&w=2
> > 
> > This needs to be refreshed against board-zoom-peripherals.c now
> > in omap for-next. But if it depends on 3630 mux patch,
> > let's wait on that until we have the new mux framework.
> > 
> Sure, I will rebase and send a new patch. It should not have any dependency
> on 3630 mux patch.

OK, thanks.
 
> > > http://marc.info/?l=linux-omap&m=125623339105103&w=2
> > > http://marc.info/?l=linux-omap&m=125623327504912&w=2
> > 
> > Adding.
> > 
> > Also, this needs to be refreshed:
> > 
> > http://patchwork.kernel.org/patch/45196/
> > 
> This one is an omap4 mmc patch which is already in the tree. Why does this
> need to be refreshed?

Oops, never mind, I'm out of date again :)

Tony
