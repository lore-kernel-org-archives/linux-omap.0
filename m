From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]Correction to BQ27000 battery device name
Date: Tue, 6 May 2008 15:16:46 -0700
Message-ID: <20080506221646.GJ18682@atomide.com>
References: <006001c8a9d6$fb592cc0$b28818ac@ent.ti.com> <a7b9a4c152799d9f4e7c9ac7b578e648@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64879 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbYEFWQv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 18:16:51 -0400
Content-Disposition: inline
In-Reply-To: <a7b9a4c152799d9f4e7c9ac7b578e648@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080429 04:41]:
> 
> 
> On Tue, 29 Apr 2008 14:26:58 +0530, "Madhusudhan Chikkature Rajashekar"
> <madhu.cr@ti.com> wrote:
> > This patch changes the device name as the bq27000 chip is not omap
> > specific.
> 
> Sure this is not omap-specific. A more generic name is better ;-)

Pushing.

Tony

> 
> > 
> > Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> > 
> > ---
> >  drivers/w1/slaves/w1_bq27000.c |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-omap-2.6/drivers/w1/slaves/w1_bq27000.c
> > ===================================================================
> > --- linux-omap-2.6.orig/drivers/w1/slaves/w1_bq27000.c	2008-04-29
> > 11:22:42.000000000 +0530
> > +++ linux-omap-2.6/drivers/w1/slaves/w1_bq27000.c	2008-04-29
> > 11:25:17.963079042 +0530
> > @@ -59,7 +59,7 @@
> >  	int id = 1;
> >  	struct platform_device *pdev;
> > 
> > -	pdev = platform_device_alloc("omap-bq2700-battery", id);
> > +	pdev = platform_device_alloc("bq27000-battery", id);
> >  	if (!pdev) {
> >  		ret = -ENOMEM;
> >  		return ret;
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> -- 
> Best Regards,
> 
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
> 
