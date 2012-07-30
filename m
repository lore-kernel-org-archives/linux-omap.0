From: Tony Lindgren <tony@atomide.com>
Subject: Re: rmk back but still recovering (was Re: Reminder - rmk still on
 vacation)
Date: Mon, 30 Jul 2012 10:02:53 -0700
Message-ID: <20120730170252.GB11011@atomide.com>
References: <20120727165049.GB7405@n2100.arm.linux.org.uk>
 <CAMQu2gyTgkswS1tYY=0g1oF7u=RGdQKEw0C3m3r3Jr+j_k9dsQ@mail.gmail.com>
 <CANfBPZ_qzXgm0bX8XDnKLwoYTtcARPj+8MHpsSEWy0=G5f9qAA@mail.gmail.com>
 <CAMQu2gzAcJBCxC5VtmyUOPMhc7D5P_MKCczdrxdeR0GNqMFYUg@mail.gmail.com>
 <20120730143323.GE7405@n2100.arm.linux.org.uk>
 <CAMQu2gyxODJb2Kc_AtYPrhwoOvEwQNLkYHvbk3e=UPdgvxdWng@mail.gmail.com>
 <20120730144443.GG7405@n2100.arm.linux.org.uk>
 <CANfBPZ9H9D-HGu2YT5hp-OXPqY4M6BZcH2qhUfHO203RokZ0Aw@mail.gmail.com>
 <CABxcv=msMZ7ufh2ROeEry1eY7HbXU8GRB5RkZx1x6asAx3CZ=w@mail.gmail.com>
 <20120730152541.GI7405@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53731 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab2G3RDP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 13:03:15 -0400
Content-Disposition: inline
In-Reply-To: <20120730152541.GI7405@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, "S, Venkatraman" <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120730 08:31]:
> On Mon, Jul 30, 2012 at 05:19:06PM +0200, Javier Martinez Canillas wrote:
> > >
> > > I think Santosh meant this patch..
> > > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commitdiff;h=55936cdfaaf11ac352b56bc58e42d6661e65ee13
> > 
> > That is the patch that fixes the DMA issue with the OMAP MMC and OMAP
> > MMC HS drivers when OMAP_DMA option is not set, since they still don't
> > support poll mode without DMA.
> > 
> > Russell, are you going to take the patch from Tony's linux-omap/master
> > tree or do I have to add the patch to the patch system also?
> 
> It'd be better to have it via the patch system, because pulling it out
> of a URL isn't an easy task.

Javier, can you please submit it to Russell's patch tracking system?
Please just replace my Signed-off-by with my Acked-by for that patch.

Regards,

Tony
