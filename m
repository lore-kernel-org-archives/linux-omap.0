From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [PATCH 1/1] MMC: OMAP: Fix HSMMC driver name at host driver.
Date: Mon, 24 Mar 2008 10:37:58 +0530
Message-ID: <005901c88d6d$08f932c0$ca8818ac@ent.ti.com>
References: <47E2C7FE.9020908@indt.org.br> <20080320225441.GA4373@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:51863 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbYCXFIS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Mar 2008 01:08:18 -0400
In-Reply-To: <20080320225441.GA4373@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com, 'Carlos Aguiar' <carlos.aguiar@indt.org.br>
Cc: 'Tony Lindgren' <tony@atomide.com>, linux-omap@vger.kernel.org

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Friday, March 21, 2008 4:25 AM
> To: Carlos Aguiar
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/1] MMC: OMAP: Fix HSMMC driver name at 
> host driver.
> 
> On Thu, Mar 20, 2008 at 04:24:30PM -0400, Carlos Aguiar wrote:
> > From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> > 
> > This patch fixes the HSMMC driver name at host driver.
> > 
> > Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> > ---
> >  drivers/mmc/host/omap_hsmmc.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/omap_hsmmc.c 
> b/drivers/mmc/host/omap_hsmmc.c
> > index 047c64d..0e7ee20 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -92,7 +92,7 @@
> >  #define OMAP_MMC_DATADIR_WRITE	2
> >  #define MMC_TIMEOUT_MS		20
> >  #define OMAP_MMC_MASTER_CLOCK	96000000
> > -#define DRIVER_NAME		"mmci-omap"
> > +#define DRIVER_NAME		"hsmmc-omap"
> 
> stupid question :-p
> what does the 'i' means?
I think it is a simple mistake. The change you have done makes sense for the HSMMC driver.

> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

