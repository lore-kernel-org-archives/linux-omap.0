From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] Add tps65921 chip
Date: Fri, 1 Jul 2011 00:35:58 -0700
Message-ID: <20110701073557.GF23145@atomide.com>
References: <1308066307-415-1-git-send-email-green@linuxhacker.ru>
 <1308066307-415-3-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:11120 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755254Ab1GAHgA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 03:36:00 -0400
Content-Disposition: inline
In-Reply-To: <1308066307-415-3-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, green@linuxhacker.ru

Samuel,

* green@linuxhacker.ru <green@linuxhacker.ru> [110614 08:42]:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> Very similar to TPS65920
> List of differences: http://www.ti.com/litv/pdf/swcu066b
> 
> CC: sameo@linux.intel.com
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>

Looks like this one can be merged independently of the rest of the
Nook patches via your mfd tree. Care to queue this?

Regards,

Tony


> ---
>  drivers/mfd/twl-core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index b8f2a4e..756f3eb 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -1284,6 +1284,8 @@ static const struct i2c_device_id twl_ids[] = {
>  	{ "tps65950", 0 },		/* catalog version of twl5030 */
>  	{ "tps65930", TPS_SUBSET },	/* fewer LDOs and DACs; no charger */
>  	{ "tps65920", TPS_SUBSET },	/* fewer LDOs; no codec or charger */
> +	{ "tps65921", TPS_SUBSET },	/* fewer LDOs; no codec, no LED
> +					   and vibrator. Charger in USB module*/
>  	{ "twl6030", TWL6030_CLASS },	/* "Phoenix power chip" */
>  	{ "twl6025", TWL6030_CLASS | TWL6025_SUBCLASS }, /* "Phoenix lite" */
>  	{ /* end of list */ },
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
