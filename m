From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: gpmc: Remove unneeded of_node_put()
Date: Fri, 1 Feb 2013 13:59:17 -0800
Message-ID: <20130201215916.GX22517@atomide.com>
References: <1359116387-32613-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <51029423.2040106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:56591 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757856Ab3BAV7U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 16:59:20 -0500
Content-Disposition: inline
In-Reply-To: <51029423.2040106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, zonque@gmail.com, matthias.bgg@googlemail.com

* Jon Hunter <jon-hunter@ti.com> [130125 06:21]:
> 
> On 01/25/2013 06:19 AM, Ezequiel Garcia wrote:
> > for_each_node_by_name() automatically calls of_node_put() on each
> > node passed; so don't do it explicitly unless there's an error.
> > 
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/mach-omap2/gpmc.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> > index 01ce462..c6255f7 100644
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -1271,9 +1271,10 @@ static int gpmc_probe_dt(struct platform_device *pdev)
> >  
> >  	for_each_node_by_name(child, "nand") {
> >  		ret = gpmc_probe_nand_child(pdev, child);
> > -		of_node_put(child);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			of_node_put(child);
> >  			return ret;
> > +		}
> >  	}
> >  
> >  	return 0;
> > 
> 
> Acked-by: Jon Hunter <jon-hunter@ti.com>

Thanks applying into omap-for-v3.9/gpmc.

Tony
