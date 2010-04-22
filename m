From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] OMAP: fix gpmc nand setup when no timings supplied
Date: Thu, 22 Apr 2010 13:29:04 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7B5A@dbde02.ent.ti.com>
References: <1271670618-5671-1-git-send-email-mike@compulab.co.il>
 <4BCFDC6F.6010801@compulab.co.il>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7ADD@dbde02.ent.ti.com>
 <4BCFF3C1.5070005@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37662 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858Ab0DVH7O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 03:59:14 -0400
In-Reply-To: <4BCFF3C1.5070005@compulab.co.il>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>



> -----Original Message-----
> From: Mike Rapoport [mailto:mike@compulab.co.il]
> Sent: 2010-04-22 12:29
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; Tony Lindgren
> Subject: Re: [PATCH] OMAP: fix gpmc nand setup when no timings supplied
> 
> Ghorai, Sukumar wrote:
> >
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Mike Rapoport
> >> Sent: 2010-04-22 10:50
> >> To: linux-omap@vger.kernel.org
> >> Cc: Tony Lindgren; Mike Rapoport
> >> Subject: Re: [PATCH] OMAP: fix gpmc nand setup when no timings supplied
> >>
> >> Any comments on this?
> >>
> >> Mike Rapoport wrote:
> >>> The gpmc nand infrastructure crashes when there no timing structure
> >>> supplied in the omap_nand_platform_data. Adding check for
> >>> gpmc_nand_data->gpmc_t pointer validity resolves the crash and allows
> to
> >>> continue nand initialization without modifying gpmc timings.
> >>>
> >>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> >>> ---
> >>>  arch/arm/mach-omap2/gpmc-nand.c |    5 +++++
> >>>  1 files changed, 5 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-
> omap2/gpmc-
> >> nand.c
> >>> index 64d74f0..3629da3 100644
> >>> --- a/arch/arm/mach-omap2/gpmc-nand.c
> >>> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> >>> @@ -83,6 +83,11 @@ static int gpmc_nand_setup(void)
> >>>  {
> >>>  	struct device *dev = &gpmc_nand_device.dev;
> >>>
> >>> +	if (!gpmc_nand_data->gpmc_t) {
> >>> +		dev_info(dev, "Keeping gpmc timings\n");
> >>> +		return 0;
> >>> +	}
> > [Ghorai] This is the only time its setup the gpmc timings for NAND. And
> it should return as error.
> 
> Somehow I was under the impression that X-Loader sets up the NAND
> timings even if booted from OneNAND or MMC. Apparently I'm wrong :).
> 
> What do you think about adding a flag to omap_nand_platform_data that
> will allow to keep timings if they were already configured by the
> bootloader? This is really useful when the board can be assembled with
> different kinds of NAND flashes.
[Ghorai] firstly we should not depend on u-boot/ x-loader for this GPMC configuration. I think each board will have only one device finally. 
> 
> >>> +
> >>>  	/* Set timings in GPMC */
> >>>  	if (omap2_nand_gpmc_retime() < 0) {
> >>>  		dev_err(dev, "Unable to set gpmc timings\n");
> >>
> >> --
> >> Sincerely yours,
> >> Mike.
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> Sincerely yours,
> Mike.
