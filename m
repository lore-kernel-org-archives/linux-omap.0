From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2]omap: mux.c warning removal
Date: Mon, 10 May 2010 15:30:29 -0700
Message-ID: <20100510223029.GL16460@atomide.com>
References: <0680EC522D0CC943BC586913CF3768C003B31655C3@dbde02.ent.ti.com>
 <874oiflos4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53074 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972Ab0EJWaa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 18:30:30 -0400
Content-Disposition: inline
In-Reply-To: <874oiflos4.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Kevin Hilman <khilman@deeprootsystems.com> [100510 09:07]:
> "Munegowda, Keshava" <keshava_mgowda@ti.com> writes:
> 
> > From: Keshava Munegowda <a0393220@ti.com>
> >
> > This patch removes the below warning 
> > arch/arm/mach-omap2/mux.c:52: warning: 'mux_phys' defined but not used
> > The definition of variable mux_phys should be enclosed in the macro CONFIG_ARCH_OMAP3 
> >
> > Signed-off-by: Keshava Munegowda <a0393220@ti.com>
> 
> Thanks, this version looks better.

Nothing wrong with this patch. But it will need to be reverted
as soon as omap24xx mux code is updated. And that's going to
happen as soon as I have a chance.

So let's just keep the warning for now.

Regards,

Tony
