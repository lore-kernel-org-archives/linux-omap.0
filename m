From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] omap_hsmmc: Remove unused state variable
Date: Thu, 10 Jun 2010 08:45:12 -0500
Message-ID: <A24693684029E5489D1D202277BE894455D3C890@dlee02.ent.ti.com>
References: <1276029700-27900-1-git-send-email-saaguirre@ti.com>
 <20100610064900.GQ32208@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32966 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421Ab0FJNpS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jun 2010 09:45:18 -0400
In-Reply-To: <20100610064900.GQ32208@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, June 10, 2010 1:49 AM
> To: Aguirre, Sergio
> Cc: linux-omap@vger.kernel.org; Matt Fleming
> Subject: Re: [PATCH] omap_hsmmc: Remove unused state variable
> 
> * Sergio Aguirre <saaguirre@ti.com> [100608 23:35]:
> > This fixes the following warning:
> >
> > drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_suspend':
> > drivers/mmc/host/omap_hsmmc.c:2275: warning: unused variable 'state'
> >
> > Introduced by commit ID:
> >
> >   commit 1a13f8fa76c880be41d6b1e6a2b44404bcbfdf9e
> >   Author: Matt Fleming <matt@console-pimps.org>
> >   Date:   Wed May 26 14:42:08 2010 -0700
> >
> >       mmc: remove the "state" argument to mmc_suspend_host()
> >
> > The unique usage of this var was removed there, and missed
> > removing the respective declaration aswell.
> 
> This should be sent to linux-mmc list.

Ok, No problem. I will do that now.

Thanks and Regards,
Sergio

> 
> Tony
> 
> 
> > Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> > ---
> >  drivers/mmc/host/omap_hsmmc.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/omap_hsmmc.c
> b/drivers/mmc/host/omap_hsmmc.c
> > index b032828..d50e917 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -2272,7 +2272,6 @@ static int omap_hsmmc_suspend(struct device *dev)
> >  	int ret = 0;
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
> > -	pm_message_t state = PMSG_SUSPEND; /* unused by MMC core */
> >
> >  	if (host && host->suspended)
> >  		return 0;
> > --
> > 1.6.3.3
> >
