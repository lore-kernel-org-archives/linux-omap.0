Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9983F54BB;
	Wed, 29 Apr 2026 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463910; cv=none; b=X1f8qxYPZxCoruRdTh1qYJWzFNRpua/qdIpKt6NA0rhJYWJ53Lnj+UO7h4nIywHDwEjOqvVdy1YnSccPfup0bO7WKXHK0kfeF8uVr9bJIqZ2oDlKz1NrLYPH68Owu+RJoP8A+XLAUGG7nVodN85vDWbnLQF21wUJAXQyAjXtXV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463910; c=relaxed/simple;
	bh=ImkyKLFtN/1vxOuQh2Z8V5psink+u58NmG29EGtcceg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMTskjnllo8kV1HyfnpZEUuVdS/aww3W1uszOWjKs3urb4Gn3sjTNcXHJ4RYeDVOffvPRUTVaAwottNDQgQzS6yet3eUpP+uZm057RKqfF99fw1jF8eAg5VUXAhn3nNu90uiFtf+Goq93zYpDKgF8AcIuigD4+e2X5y46LjIbLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgAirL3R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgAirL3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1803CC19425;
	Wed, 29 Apr 2026 11:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777463909;
	bh=ImkyKLFtN/1vxOuQh2Z8V5psink+u58NmG29EGtcceg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgAirL3RD2yoN019hFwf6D7qRWhPiQ+LoCusRE9mo+cml2FRZ5kI7lbMVA6yKpCop
	 ULK3WhdL6gepOJG24P9vUnY48IwACx6sDycPwWMmZ5L7Fr+gVDKBZC4Wuytq6TBQYm
	 14joobILN3m50EJ0F4KMjzi4az/YWeLgq0AHeZ4rxbzC7pFD0vLGm6rLfXom8zxThw
	 8wGGpEmOWpxh8DQQ4D9ZnCxXMFh7pxblN/6dSOD378pkP+nulloWzSFfbQwHPsE4QO
	 mN1SGmRSD5QBGTbjUo1Y3s1bFdTV3p9XdniHcTgkp+a3amJBWBY/UyM8uoUTFhhB9B
	 EmPRJynKoV7Xg==
Date: Wed, 29 Apr 2026 12:58:24 +0100
From: Lee Jones <lee@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 06/11] mfd: omap-usb-host: Sanitize error path in the
 probe()
Message-ID: <20260429115824.GB1806155@google.com>
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
 <20260330-omap4-fix-usb-support-v2-6-1c1e11b190dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-omap4-fix-usb-support-v2-6-1c1e11b190dc@bootlin.com>

On Mon, 30 Mar 2026, Thomas Richard wrote:

> Use dev_err_probe() to simplify the code and standardize the error output.
> Remove -ENOMEM messages, there's already enough output.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/mfd/omap-usb-host.c | 81 +++++++++++++++++++--------------------------
>  1 file changed, 34 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 4e066a17cef0..ac974285be34 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -546,22 +546,17 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  		dev->platform_data = pdata;
>  	}
>  
> -	if (!pdata) {
> -		dev_err(dev, "Missing platform data\n");
> -		return -ENODEV;
> -	}
> +	if (!pdata)
> +		return dev_err_probe(dev, -ENODEV, "Missing platform data\n");
>  
> -	if (pdata->nports > OMAP3_HS_USB_PORTS) {
> -		dev_info(dev, "Too many num_ports <%d> in platform_data. Max %d\n",
> -				pdata->nports, OMAP3_HS_USB_PORTS);
> -		return -ENODEV;
> -	}
> +	if (pdata->nports > OMAP3_HS_USB_PORTS)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Too many num_ports <%d> in platform_data. Max %d\n",
> +				     pdata->nports, OMAP3_HS_USB_PORTS);
>  
>  	omap = devm_kzalloc(dev, sizeof(*omap), GFP_KERNEL);
> -	if (!omap) {
> -		dev_err(dev, "Memory allocation failed\n");
> +	if (!omap)
>  		return -ENOMEM;
> -	}
>  
>  	omap->uhh_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(omap->uhh_base))
> @@ -614,7 +609,6 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  	omap->hsic60m_clk = devm_kzalloc(dev, i, GFP_KERNEL);
>  
>  	if (!omap->utmi_clk || !omap->hsic480m_clk || !omap->hsic60m_clk) {
> -		dev_err(dev, "Memory allocation failed\n");
>  		ret = -ENOMEM;
>  		goto err_mem;
>  	}
> @@ -648,9 +642,8 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  			omap->ehci_logic_fck = devm_clk_get(dev,
>  							    "usbhost_120m_fck");
>  			if (IS_ERR(omap->ehci_logic_fck)) {
> -				ret = PTR_ERR(omap->ehci_logic_fck);
> -				dev_err(dev, "usbhost_120m_fck failed:%d\n",
> -					ret);
> +				ret = dev_err_probe(dev, PTR_ERR(omap->ehci_logic_fck),
> +						    "usbhost_120m_fck failed\n");

Can we take this opportunity to make this a bit more user friendly?

"Failed to get usbhost_120m_fck clock

Same throughout please.

>  				goto err_mem;
>  			}
>  		}
> @@ -660,36 +653,36 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  	/* for OMAP4+ i.e. USBHS REV2+ */
>  	omap->utmi_p1_gfclk = devm_clk_get(dev, "utmi_p1_gfclk");
>  	if (IS_ERR(omap->utmi_p1_gfclk)) {
> -		ret = PTR_ERR(omap->utmi_p1_gfclk);
> -		dev_err(dev, "utmi_p1_gfclk failed error:%d\n", ret);
> +		ret = dev_err_probe(dev, PTR_ERR(omap->utmi_p1_gfclk),
> +				    "utmi_p1_gfclk failed error\n");
>  		goto err_mem;
>  	}
>  
>  	omap->utmi_p2_gfclk = devm_clk_get(dev, "utmi_p2_gfclk");
>  	if (IS_ERR(omap->utmi_p2_gfclk)) {
> -		ret = PTR_ERR(omap->utmi_p2_gfclk);
> -		dev_err(dev, "utmi_p2_gfclk failed error:%d\n", ret);
> +		ret = dev_err_probe(dev, PTR_ERR(omap->utmi_p2_gfclk),
> +				    "utmi_p2_gfclk failed error\n");
>  		goto err_mem;
>  	}
>  
>  	omap->xclk60mhsp1_ck = devm_clk_get(dev, "refclk_60m_ext_p1");
>  	if (IS_ERR(omap->xclk60mhsp1_ck)) {
> -		ret = PTR_ERR(omap->xclk60mhsp1_ck);
> -		dev_err(dev, "refclk_60m_ext_p1 failed error:%d\n", ret);
> +		ret = dev_err_probe(dev, PTR_ERR(omap->xclk60mhsp1_ck),
> +				    "refclk_60m_ext_p1 failed error\n");
>  		goto err_mem;
>  	}
>  
>  	omap->xclk60mhsp2_ck = devm_clk_get(dev, "refclk_60m_ext_p2");
>  	if (IS_ERR(omap->xclk60mhsp2_ck)) {
> -		ret = PTR_ERR(omap->xclk60mhsp2_ck);
> -		dev_err(dev, "refclk_60m_ext_p2 failed error:%d\n", ret);
> +		ret = dev_err_probe(dev, PTR_ERR(omap->xclk60mhsp2_ck),
> +				    "refclk_60m_ext_p2 failed error\n");
>  		goto err_mem;
>  	}
>  
>  	omap->init_60m_fclk = devm_clk_get(dev, "refclk_60m_int");
>  	if (IS_ERR(omap->init_60m_fclk)) {
> -		ret = PTR_ERR(omap->init_60m_fclk);
> -		dev_err(dev, "refclk_60m_int failed error:%d\n", ret);
> +		ret = dev_err_probe(dev, PTR_ERR(omap->init_60m_fclk),
> +				    "refclk_60m_int failed error\n");
>  		goto err_mem;
>  	}
>  
> @@ -706,9 +699,9 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  		 */
>  		omap->utmi_clk[i] = devm_clk_get(dev, clkname);
>  		if (IS_ERR(omap->utmi_clk[i])) {
> -			ret = PTR_ERR(omap->utmi_clk[i]);
> -			dev_err(dev, "Failed to get clock : %s : %d\n",
> -				clkname, ret);
> +			ret = dev_err_probe(dev, PTR_ERR(omap->utmi_clk[i]),
> +					    "Failed to get clock : %s\n",
> +					    clkname);
>  			goto err_mem;
>  		}
>  
> @@ -716,9 +709,9 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  				"usb_host_hs_hsic480m_p%d_clk", i + 1);
>  		omap->hsic480m_clk[i] = devm_clk_get(dev, clkname);
>  		if (IS_ERR(omap->hsic480m_clk[i])) {
> -			ret = PTR_ERR(omap->hsic480m_clk[i]);
> -			dev_err(dev, "Failed to get clock : %s : %d\n",
> -				clkname, ret);
> +			ret = dev_err_probe(dev, PTR_ERR(omap->hsic480m_clk[i]),
> +					    "Failed to get clock : %s\n",
> +					    clkname);
>  			goto err_mem;
>  		}
>  
> @@ -726,9 +719,9 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  				"usb_host_hs_hsic60m_p%d_clk", i + 1);
>  		omap->hsic60m_clk[i] = devm_clk_get(dev, clkname);
>  		if (IS_ERR(omap->hsic60m_clk[i])) {
> -			ret = PTR_ERR(omap->hsic60m_clk[i]);
> -			dev_err(dev, "Failed to get clock : %s : %d\n",
> -				clkname, ret);
> +			ret = dev_err_probe(dev, PTR_ERR(omap->hsic60m_clk[i]),
> +					    "Failed to get clock : %s\n",
> +					    clkname);
>  			goto err_mem;
>  		}
>  	}
> @@ -737,16 +730,14 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  		ret = clk_set_parent(omap->utmi_p1_gfclk,
>  					omap->xclk60mhsp1_ck);
>  		if (ret != 0) {
> -			dev_err(dev, "xclk60mhsp1_ck set parent failed: %d\n",
> -				ret);
> +			dev_err_probe(dev, ret, "xclk60mhsp1_ck set parent failed\n");
>  			goto err_mem;
>  		}
>  	} else if (is_ehci_tll_mode(pdata->port_mode[0])) {
>  		ret = clk_set_parent(omap->utmi_p1_gfclk,
>  					omap->init_60m_fclk);
>  		if (ret != 0) {
> -			dev_err(dev, "P0 init_60m_fclk set parent failed: %d\n",
> -				ret);
> +			dev_err_probe(dev, ret, "P0 init_60m_fclk set parent failed\n");
>  			goto err_mem;
>  		}
>  	}
> @@ -755,16 +746,14 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  		ret = clk_set_parent(omap->utmi_p2_gfclk,
>  					omap->xclk60mhsp2_ck);
>  		if (ret != 0) {
> -			dev_err(dev, "xclk60mhsp2_ck set parent failed: %d\n",
> -				ret);
> +			dev_err_probe(dev, ret, "xclk60mhsp2_ck set parent failed\n");
>  			goto err_mem;
>  		}
>  	} else if (is_ehci_tll_mode(pdata->port_mode[1])) {
>  		ret = clk_set_parent(omap->utmi_p2_gfclk,
>  						omap->init_60m_fclk);
>  		if (ret != 0) {
> -			dev_err(dev, "P1 init_60m_fclk set parent failed: %d\n",
> -				ret);
> +			dev_err_probe(dev, ret, "P1 init_60m_fclk set parent failed\n");
>  			goto err_mem;
>  		}
>  	}
> @@ -775,17 +764,15 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  	if (dev->of_node) {
>  		ret = of_platform_populate(dev->of_node,
>  				usbhs_child_match_table, NULL, dev);
> -
>  		if (ret) {
> -			dev_err(dev, "Failed to create DT children: %d\n", ret);
> +			dev_err_probe(dev, ret, "Failed to create DT children\n");
>  			goto err_mem;
>  		}
>  
>  	} else {
>  		ret = omap_usbhs_alloc_children(pdev);
>  		if (ret) {
> -			dev_err(dev, "omap_usbhs_alloc_children failed: %d\n",
> -						ret);
> +			dev_err_probe(dev, ret, "omap_usbhs_alloc_children failed\n");

We certainly don't want to mention function names.

>  			goto err_mem;
>  		}
>  	}
> 
> -- 
> 2.53.0
> 

-- 
Lee Jones
