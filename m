From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: Use resource_size
Date: Mon, 9 Nov 2009 13:08:12 -0800
Message-ID: <20091109210811.GE23952@atomide.com>
References: <1257788658-19824-1-git-send-email-tklauser@distanz.ch>
 <20091109210558.GD23952@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56307 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbZKIVIU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 16:08:20 -0500
Content-Disposition: inline
In-Reply-To: <20091109210558.GD23952@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [091109 13:05]:
> * Tobias Klauser <tklauser@distanz.ch> [091109 09:44]:
> > Use the resource_size function instead of manually calculating the
> > resource size. This reduces the chance of introducing off-by-one errors
> > and actually fixes one in mailbox.c.
> > 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Hmm, sorry though this was part of some larger series.. Added to
my omap-fixes queue.

Regards,

Tony
 
> > ---
> >  arch/arm/mach-omap2/gpmc.c    |    2 +-
> >  arch/arm/mach-omap2/mailbox.c |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> > index 004da69..67af370 100644
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -366,7 +366,7 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
> >  	if (r < 0)
> >  		goto out;
> >  
> > -	gpmc_cs_enable_mem(cs, res->start, res->end - res->start + 1);
> > +	gpmc_cs_enable_mem(cs, res->start, resource_size(res));
> >  	*base = res->start;
> >  	gpmc_cs_set_reserved(cs, 1);
> >  out:
> > diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> > index 46e1f2e..5ba3aa6 100644
> > --- a/arch/arm/mach-omap2/mailbox.c
> > +++ b/arch/arm/mach-omap2/mailbox.c
> > @@ -300,7 +300,7 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
> >  		dev_err(&pdev->dev, "invalid mem resource\n");
> >  		return -ENODEV;
> >  	}
> > -	mbox_base = ioremap(res->start, res->end - res->start);
> > +	mbox_base = ioremap(res->start, resource_size(res));
> >  	if (!mbox_base)
> >  		return -ENOMEM;
> >  
> > -- 
> > 1.6.3.3
> > 
