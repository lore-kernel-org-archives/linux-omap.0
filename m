From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: Re: omapfb: help from userspace
Date: Wed, 15 Oct 2008 15:04:51 +0300
Message-ID: <20081015120451.GF23395@pure.research.nokia.com>
References: <e5e6ade50810081136n2067600csf3c77195da0ef110@mail.gmail.com> <e5e6ade50810081321h6f638cafjbe00f4c8a3a50f2c@mail.gmail.com> <13B9B4C6EF24D648824FF11BE89671620365B58844@dlee02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301B0108CAB@dbde02.ent.ti.com> <20081009124357.GF26230@atomide.com> <e5e6ade50810091055se7af4aasc404eb92f176dfeb@mail.gmail.com> <alpine.DEB.2.00.0810150556140.14740@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49438 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbYJOMEx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 08:04:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0810150556140.14740@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: Nathan Monson <nmonson@gmail.com>, Tony Lindgren <tony@atomide.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, "TK, Pratheesh Gangadhar" <pratheesh@ti.com>

On 15/10/08 05:57 -0600, ext Paul Walmsley wrote:
> Hi Nathan,
> 
> On Thu, 9 Oct 2008, Nathan Monson wrote:
> 
> > On Thu, Oct 9, 2008 at 5:43 AM, Tony Lindgren <tony@atomide.com> wrote:
> > > Nathan, good to hear that the SO mode helps. But since you seem to
> > > have it easily reproducable..
> > 
> > Reproducing is as easy as applying the DSP Bridge kernel patches and
> > then running the 'ping.out' sample like this:  while true; do
> > ping.out; done
> > 
> > > Could you try the following patch based on RMK's earlier patch
> > > without the strongly ordered patch and see if that makes any
> > > difference?
> > 
> > Maybe it lasted a few seconds longer, or maybe it was luck, but in any
> > case it eventually went into an IRQ -33 loop even with this patch.
> 
> could you try Lauri's patch posted here:
> 
> http://marc.info/?l=linux-omap&m=122407150608770&w=2
> 
> without the strongly-ordered memory patches?

I would like TI or ARM to confirm if my assumption is correct that the IRQ
will be re-raised if it gets corrupted in this way (resulting in a spurious
irq -33, which seems to be the most common one ;). If not, then this patch
will cause us to drop interrupts which is not good. Of course it is still
better than ending in a permanent loop, but only marginally.

I also tried the SO patch, result wasn't able to boot up at all (sorry, don't
have the log to show where it died).

/lauri
