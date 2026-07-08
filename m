Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0614D8D9B;
	Wed,  8 Jul 2026 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536058; cv=none; b=VPO78Iex0fY0NsSf3Ax21HynEPYMTI/eqW/IgXI9XRarTEkeLdg+sB5klgGLKGCNvjTLhjIlAbvN436Ec/rsRD2tHwBvMwV3+NunpXxfBQtvCEIlqJEuNwO9mxzz43P1TK2pynS/dCTOS+XBblPCPd0P++SUuj7fbT0LfCgICpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536058; c=relaxed/simple;
	bh=HcAZ9G2I1deRYqcfsMHjuujc24Y+isFvMv7aT0BiR+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRyOHgLa2nEgkSE09NbMF0DlezwS9d4Mke92IFaQOa3Le0hI0qdxMCXBkc/5TBzkzmZ3tNIuYzY4WImYuD94ZWigcxCFhuRb5hFFVSmj27wKA43QQ0c99DzIjUNBlPHlXKJV2pRodLsKMAOfEAkdNHYSMsxOQfcaEovfADpt1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRX2DdGW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRX2DdGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEA51F000E9;
	Wed,  8 Jul 2026 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536057;
	bh=9lHB+83FWbi0rI3eAzP4cfnznUnRmctJGZdJSoT+jlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HRX2DdGWUwQMVsFIzFsbfKJcOYa7D886ZbjcRtiCYzFvxMU6kIKAtWNHcShflD/SW
	 FY+IBr8hAiPOdQB4fvNsDiscg9vtZKJ06EEC9BmVcNmAf64JP1ezwbEOmJr6wxO5Si
	 Uz54vgY9rGcx9Gh1bYNf3aQBYsRWfc6cWD752v31joU01z/DgMxoSJx2Txt/Y+nnsg
	 TcBSoccJ3HdB+IPaesc4YeVJsI8CJchKZdW7WOTAn0ayk6+0bktIYwfWt6tENGeuYB
	 RUAoIshZk4q36QMKYbslNjXOM+T/nldeiP7593dNXF13ebjVCt2t7A8uMD2HRV/zkl
	 IQhtbdo3Z8cbA==
Date: Wed, 8 Jul 2026 19:40:52 +0100
From: Lee Jones <lee@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: twl-core: allocate modules with twl_private
Message-ID: <20260708184052.GJ2108533@google.com>
References: <20260630012958.1498689-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630012958.1498689-1-rosenp@gmail.com>

Please consider these reviews.

/* Sashiko Automation: Issues Found (3 Findings) */

On Mon, 29 Jun 2026, Rosen Penev wrote:

> Use a flexible array member to allocate the twl_client array together
> with struct twl_private. This removes a separate devm_kcalloc() and
> keeps the module data tied to the main private structure.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/mfd/twl-core.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index c024a28b057e..a7754b7ccae0 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -159,7 +159,7 @@ struct twl_private {
>  	unsigned int twl_id;
>  
>  	struct twl_mapping *twl_map;
> -	struct twl_client *twl_modules;
> +	struct twl_client twl_modules[];
>  };
>  
>  static struct twl_private *twl_priv;
> @@ -760,7 +760,8 @@ twl_probe(struct i2c_client *client)
>  		goto free;
>  	}
>  
> -	twl_priv = devm_kzalloc(&client->dev, sizeof(struct twl_private),
> +	num_slaves = twl_get_num_slaves();
> +	twl_priv = devm_kzalloc(&client->dev, struct_size(twl_priv, twl_modules, num_slaves),
>  				GFP_KERNEL);

[Severity: Critical]
Does evaluating num_slaves before twl_priv is allocated result in an
incorrect slave count for TWL4030 devices?

twl_get_num_slaves() calls twl_class_is_4030(), which checks
twl_priv->twl_id. Because twl_priv is NULL before this allocation, the check
fails and incorrectly defaults to 3 instead of 4.

During device removal, twl_get_num_slaves() will correctly evaluate to 4,
causing the removal loop to read and write out-of-bounds of this 3-element
flexible array.


>  	if (!twl_priv) {
>  		status = -ENOMEM;
> @@ -777,16 +778,6 @@ twl_probe(struct i2c_client *client)
>  		twl_regmap_config = twl4030_regmap_config;
>  	}
>  
> -	num_slaves = twl_get_num_slaves();
> -	twl_priv->twl_modules = devm_kcalloc(&client->dev,
> -					 num_slaves,
> -					 sizeof(struct twl_client),
> -					 GFP_KERNEL);
> -	if (!twl_priv->twl_modules) {
> -		status = -ENOMEM;
> -		goto free;
> -	}
> -
>  	for (i = 0; i < num_slaves; i++) {
>  		struct twl_client *twl = &twl_priv->twl_modules[i];

[Severity: High]
This is a pre-existing issue, but is there a missing cleanup step for the
global twl_priv pointer?

If twl_probe() fails or the driver is unbound, devres automatically frees
the twl_priv structure. However, the driver fails to set the global
twl_priv pointer back to NULL in twl_remove():

drivers/mfd/twl-core.c:twl_remove() {
    ...
    twl_priv->ready = false;
}

Subsequent attempts to bind the driver will hit the singleton check in
twl_probe():

    if (twl_priv) {
        dev_dbg(&client->dev, "only one instance of %s allowed\n",
            DRIVER_NAME);
        return -EBUSY;
    }

Can this leave a dangling pointer to devres-freed memory and permanently block
future probe attempts?




[Severity: High]
This isn't a bug introduced by this patch, but could this leave a dangling
function pointer on system shutdown?

During twl_probe(), pm_power_off is globally assigned to twl6030_power_off:

drivers/mfd/twl-core.c:twl_probe() {
    ...
    if (of_device_is_system_power_controller(node)) {
        if (!pm_power_off)
            pm_power_off = twl6030_power_off;
    ...
}

If the driver is later unbound or fails to probe after this assignment,
twl_remove() does not set pm_power_off back to NULL. 

When the system later shuts down, might it execute the dangling hook and
cause a kernel panic?

>  
> -- 
> 2.54.0
> 

-- 
Lee Jones
