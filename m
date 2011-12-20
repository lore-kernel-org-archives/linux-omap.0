From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v3 02/11] i2c: OMAP: Add DT support for i2c controller
Date: Tue, 20 Dec 2011 10:42:43 -0600
Message-ID: <4EF0BB03.6040906@gmail.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com> <1324398444-23296-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56872 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab1LTQmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 11:42:45 -0500
Received: by yenm11 with SMTP id m11so4114302yen.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Dec 2011 08:42:45 -0800 (PST)
In-Reply-To: <1324398444-23296-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, Ben Dooks <ben-linux@fluff.org>, Kevin Hilman <khilman@ti.com>

On 12/20/2011 10:27 AM, Benoit Cousson wrote:
> Add initial DT support to retrieve the frequency using a
> DT attribute instead of the pdata pointer if of_node exist.
> 
> Add documentation for omap i2c controller binding.
> 
> Based on original patches from Manju and Grant.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kevin Hilman <khilman@ti.com>

One issue below, otherwise:

Reviewed-by: Rob Herring <rob.herring@calxeda.com>


> @@ -1001,15 +1019,24 @@ omap_i2c_probe(struct platform_device *pdev)
>  		goto err_release_region;
>  	}
>  
> -	if (pdata != NULL) {
> -		speed = pdata->clkrate;
> +	match = of_match_device(omap_i2c_of_match, &pdev->dev);
> +	if (match) {
> +		u32 freq = 100000; /* default to 100000 Hz */
> +
> +		pdata = match->data;
> +		dev->dtrev = pdata->rev;
> +		dev->flags = pdata->flags;
> +
> +		of_property_read_u32(node, "clock-frequency", &freq);
> +		/* convert DT freq value in Hz into kHz for speed */
> +		dev->speed = freq / 1000;
> +	} else if (pdata != NULL) {
> +		dev->speed = pdata->clkrate;
> +		dev->flags = pdata->flags;
>  		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
> -	} else {
> -		speed = 100;	/* Default speed */
> -		dev->set_mpu_wkup_lat = NULL;
> +		dev->dtrev = pdata->rev;

If you get here, pdata is NULL.

Rob
