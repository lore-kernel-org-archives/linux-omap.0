From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Introduce support for AM35xx
Date: Tue, 10 Nov 2009 19:02:33 -0800
Message-ID: <20091111030233.GD1386@atomide.com>
References: <1256652138-5669-1-git-send-email-premi@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DE3B7205@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56751 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486AbZKKDC3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 22:02:29 -0500
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE3B7205@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Premi, Sanjeev <premi@ti.com> [091110 05:41]:
> > -----Original Message-----
> > From: Premi, Sanjeev 
> > Sent: Tuesday, October 27, 2009 7:32 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Premi, Sanjeev
> > Subject: [PATCH 0/2] Introduce support for AM35xx
> > 
> > This patch adds support for the recently announced
> > AM3505 and AM3517 devices from Texas Instruments.
> > 
> > It also defines the AM3517 EVM board. Detailed
> > support will follow in subsequent patches.
> > 
> >   [1] http://www.ti.com/sitara 
> >   [2] http://www.ti.com/arm 
> >   [3] 
> > http://tiexpressdsp.com/index.php?title=Applications_Processor
> > s_Crossreference 
> >   [4] http://marc.info/?l=linux-omap&m=125615009412281&w=2
> >   
> > The patches have been created against omap-next branch.
> > 
> > Sanjeev Premi (2):
> >   AM35xx: Runtime detection of the device
> >   AM35xx: Define the AM3517EVM board
> > 
> >  arch/arm/mach-omap2/Kconfig           |    4 +++
> >  arch/arm/mach-omap2/id.c              |   43 
> > ++++++++++++++++++++++++++++----
> >  arch/arm/plat-omap/include/plat/cpu.h |   12 +++++++++
> >  3 files changed, 53 insertions(+), 6 deletions(-)
> > 
> > 
> Tony,
> 
> Where does this stand in your queue?

Cpu detection merged now, can you please check?

Tony
