From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: fix gpmc nand setup when no timings supplied
Date: Tue, 27 Apr 2010 07:47:35 -0700
Message-ID: <20100427144734.GX7225@atomide.com>
References: <1271670618-5671-1-git-send-email-mike@compulab.co.il>
 <4BCFDC6F.6010801@compulab.co.il>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7ADD@dbde02.ent.ti.com>
 <4BCFF3C1.5070005@compulab.co.il>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7B5A@dbde02.ent.ti.com>
 <4BD00C9A.8050601@compulab.co.il>
 <20100426181448.GG7225@atomide.com>
 <4BD695BC.3080109@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50326 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab0D0Org (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 10:47:36 -0400
Content-Disposition: inline
In-Reply-To: <4BD695BC.3080109@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Mike Rapoport <mike@compulab.co.il> [100427 00:40]:
> Tony Lindgren wrote:
> >* Mike Rapoport <mike@compulab.co.il> [100422 01:41]:
> >>Ghorai, Sukumar wrote:
> >>
> >>CM-T35, for instance can be assembled with different NAND flash
> >>chips. Besides, boards that use NAND as primary boot device, we
> >>anyway depend on proper GPMC configuration in the bootloader chain.
> >>Having ability to define GPMC timings in the kernel and keep the
> >>settings made by the bootloader adds flexibility level for board
> >>designers.
> >
> >Not implementing the retime function for GPMC will cause issues
> >with PM as you cannot scale the L3 frequency without breaking
> >your GPMC timings.
> 
> I agree that without retime function scaling the frequency will
> break the GPMC timings. But my point was that there should be an
> _option_ to keep the timings defined by the bootloader rather than
> enforce board files to specify timings.

Sure. Can you please check one more time your patch and what is
still missing after Stanley's fix? That's now in omap-fixes and master
branches as commit 11e1ef2d105900a302b7ca92bcaf96a96d0274a1.

> Since skipping the retime function will break gpmc timings in
> PM-enabled  kernel, we need to implement this option in smarter way.
> E.g. something like:

Yeah we should print some warning if the retime function is not
implemented as it can cause mysterious bugs later on. I guess
implementing a dummy retime function would be best as then the
warning would be related to the actual L3 rate change.

Regards,

Tony
 
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c
> b/arch/arm/mach-omap2/gpmc-nand.c
> index 64d74f0..65ac0d0 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -34,6 +34,12 @@ static struct platform_device gpmc_nand_device = {
>  	.resource	= &gpmc_nand_resource,
>  };
> 
> +static int gpmc_nand_detect_timings(void)
> +{
> +	/* FIXME: implement timings detection */
> +	return -EINVAL;
> +}
> +
>  static int omap2_nand_gpmc_retime(void)
>  {
>  	struct gpmc_timings t;
> @@ -109,6 +115,14 @@ int __init gpmc_nand_init(struct
> omap_nand_platform_data *_nand_data)
>  		return err;
>  	}
> 
> +	if (gpmc_nand_data->keep_timings) {
> +		err = gpmc_nand_detect_timings();
> +		if (err < 0) {
> +			dev_err(dev, "Cannot detect GPMC timings\n");
> +			return err;
> +		}
> +	}
> +
>  	err = gpmc_nand_setup();
>  	if (err < 0) {
>  		dev_err(dev, "NAND platform setup failed: %d\n", err);
> diff --git a/arch/arm/plat-omap/include/plat/nand.h
> b/arch/arm/plat-omap/include/plat/nand.h
> index 6ba88d2..cf05d2d 100644
> --- a/arch/arm/plat-omap/include/plat/nand.h
> +++ b/arch/arm/plat-omap/include/plat/nand.h
> @@ -24,6 +24,7 @@ struct omap_nand_platform_data {
>  	void __iomem		*gpmc_cs_baseaddr;
>  	void __iomem		*gpmc_baseaddr;
>  	int			devsize;
> +	bool			keep_timings;
>  };
> 
>  /* size (4 KiB) for IO mapping */
> 
> 
> 
> >Tony
> 
> 
> -- 
> Sincerely yours,
> Mike.
