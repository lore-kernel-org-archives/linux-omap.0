From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv7 6/7] regulator: twl: add support for external controller
Date: Mon, 28 Nov 2011 14:58:25 +0000
Message-ID: <20111128145824.GB18958@opensource.wolfsonmicro.com>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
 <1322492005-27741-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58581 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750921Ab1K1O6b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 09:58:31 -0500
Content-Disposition: inline
In-Reply-To: <1322492005-27741-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, lrg@ti.com, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

On Mon, Nov 28, 2011 at 04:53:24PM +0200, Tero Kristo wrote:

> +++ b/drivers/regulator/twl-regulator.c
> @@ -18,6 +18,7 @@
>  #include <linux/regulator/machine.h>
>  #include <linux/i2c/twl.h>
>  
> +#include <plat/voltage.h>

You shouldn't be including platform specific headers in generic code.

> +	/* voltagedomain, only used for VP controlled smps regulators */
> +	union {
> +		const char		*name;
> +		struct voltagedomain	*ptr;
> +	} voltdm;
> +

This looks pretty icky...  Why are you using a union of a pointer to a
struct and a name?  How do things know which to use?

> -	twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS_4030,
> -		vsel);
> +	if (info->voltdm.ptr)
> +		voltdm_scale(info->voltdm.ptr, min_uV);
> +	else {


Use braces on both branches.
