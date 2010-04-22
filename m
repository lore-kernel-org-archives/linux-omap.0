From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] OMAP: fix gpmc nand setup when no timings supplied
Date: Thu, 22 Apr 2010 08:19:43 +0300
Message-ID: <4BCFDC6F.6010801@compulab.co.il>
References: <1271670618-5671-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:48914 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720Ab0DVFUr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Apr 2010 01:20:47 -0400
In-Reply-To: <1271670618-5671-1-git-send-email-mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mike Rapoport <mike@compulab.co.il>

Any comments on this?

Mike Rapoport wrote:
> The gpmc nand infrastructure crashes when there no timing structure
> supplied in the omap_nand_platform_data. Adding check for
> gpmc_nand_data->gpmc_t pointer validity resolves the crash and allows to
> continue nand initialization without modifying gpmc timings.
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  arch/arm/mach-omap2/gpmc-nand.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index 64d74f0..3629da3 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -83,6 +83,11 @@ static int gpmc_nand_setup(void)
>  {
>  	struct device *dev = &gpmc_nand_device.dev;
>  
> +	if (!gpmc_nand_data->gpmc_t) {
> +		dev_info(dev, "Keeping gpmc timings\n");
> +		return 0;
> +	}
> +
>  	/* Set timings in GPMC */
>  	if (omap2_nand_gpmc_retime() < 0) {
>  		dev_err(dev, "Unable to set gpmc timings\n");


-- 
Sincerely yours,
Mike.
