From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] OMAP: fix gpmc nand setup when no timings supplied
Date: Thu, 22 Apr 2010 12:11:25 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7ADD@dbde02.ent.ti.com>
References: <1271670618-5671-1-git-send-email-mike@compulab.co.il>
 <4BCFDC6F.6010801@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46838 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134Ab0DVGle convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 02:41:34 -0400
In-Reply-To: <4BCFDC6F.6010801@compulab.co.il>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Mike Rapoport
> Sent: 2010-04-22 10:50
> To: linux-omap@vger.kernel.org
> Cc: Tony Lindgren; Mike Rapoport
> Subject: Re: [PATCH] OMAP: fix gpmc nand setup when no timings supplied
> 
> Any comments on this?
> 
> Mike Rapoport wrote:
> > The gpmc nand infrastructure crashes when there no timing structure
> > supplied in the omap_nand_platform_data. Adding check for
> > gpmc_nand_data->gpmc_t pointer validity resolves the crash and allows to
> > continue nand initialization without modifying gpmc timings.
> >
> > Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> > ---
> >  arch/arm/mach-omap2/gpmc-nand.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-
> nand.c
> > index 64d74f0..3629da3 100644
> > --- a/arch/arm/mach-omap2/gpmc-nand.c
> > +++ b/arch/arm/mach-omap2/gpmc-nand.c
> > @@ -83,6 +83,11 @@ static int gpmc_nand_setup(void)
> >  {
> >  	struct device *dev = &gpmc_nand_device.dev;
> >
> > +	if (!gpmc_nand_data->gpmc_t) {
> > +		dev_info(dev, "Keeping gpmc timings\n");
> > +		return 0;
> > +	}
[Ghorai] This is the only time its setup the gpmc timings for NAND. And it should return as error.

> > +
> >  	/* Set timings in GPMC */
> >  	if (omap2_nand_gpmc_retime() < 0) {
> >  		dev_err(dev, "Unable to set gpmc timings\n");
> 
> 
> --
> Sincerely yours,
> Mike.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
