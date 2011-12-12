From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCHv7 5/7] mfd: twl-core: pass driver data from pdata to
 add_regulator for VDD1 and VDD2
Date: Mon, 12 Dec 2011 19:04:23 +0100
Message-ID: <20111212180423.GX13952@sortiz-mobl>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
 <1322492005-27741-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64362 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585Ab1LLR7S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 12:59:18 -0500
Content-Disposition: inline
In-Reply-To: <1322492005-27741-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

Hi Tero,


On Mon, Nov 28, 2011 at 04:53:23PM +0200, Tero Kristo wrote:
> This way, we can add custom flags for VDD1 and VDD2 regulators that
> get passed all the way to regulator init. This is needed for SMPS
> regulator support to select used controller mode for these regulators
> (either voltage processor or default.)
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/twl-core.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 01ecfee..af93fce 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -846,12 +846,14 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
>  			return PTR_ERR(child);
>  
>  		child = add_regulator(TWL4030_REG_VDD1, pdata->vdd1,
> -					features);
> +					features |
> +					(u32)pdata->vdd1->driver_data);
That looks hackish to me. Do you have any guarantee that your driver_data and
your features bitmaps have zero intersections ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
