From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2] backlight: Add TPS65217 WLED driver
Date: Mon, 17 Sep 2012 01:09:36 +0200
Message-ID: <20120916230936.GK3647@sortiz-mobl>
References: <20120809204231.GF30282@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:20201 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707Ab2IPXJj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Sep 2012 19:09:39 -0400
Content-Disposition: inline
In-Reply-To: <20120809204231.GF30282@darwin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Kaehlcke <matthias@kaehlcke.net>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, Richard Purdie <rpurdie@rpsys.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Matthias,

On Thu, Aug 09, 2012 at 10:42:31PM +0200, Matthias Kaehlcke wrote:
> The TPS65217 chip contains a boost converter and current sinks which can be
> used to drive LEDs for use as backlights. Expose this functionality via the
> backlight API.
> 
> Tested on an AM335x based custom board with a single WLED string, using
> different values for ISEL and FDIM (though it would be hard to tell the
> difference except for the value in WLEDCTRL1). Both instantiation through the
> device tree and by passing platform data have been tested. Testing has been
> done with an Androidized 3.2 kernel from the rowboat project
> 
> This patch is based on the mfd tree, it also applies on linux-next (20120809)
It doesn't seem to apply to my for-next branch.

Also, some comments:

> @@ -174,6 +174,10 @@ static struct tps65217_board *tps65217_parse_dt(struct i2c_client *client)
>  		pdata->of_node[i] = reg_matches[i].of_node;
>  	}
>  
> +	node = of_find_node_by_name(node, "backlight");
> +	if (node)
> +		pdata->of_node[TPS65217_SUBDEV_BL] = node;
> +
>  	return pdata;
>  }
>  
> @@ -250,7 +254,32 @@ static int __devinit tps65217_probe(struct i2c_client *client,
>  		platform_device_add(pdev);
>  	}
>  
> +	if (pdata->bl_pdata || pdata->of_node[TPS65217_SUBDEV_BL]) {
> +		tps->bl_pdev = platform_device_alloc("tps65217-bl", 0);
> +		if (!tps->bl_pdev) {
> +			dev_err(tps->dev, "Cannot create backlight platform device\n");
> +			ret = -ENOMEM;
> +			goto err_alloc_bl_pdev;
> +		}
> +
> +		tps->bl_pdev->dev.parent = tps->dev;
> +
> +		if (pdata->bl_pdata)
> +			tps->bl_pdev->dev.platform_data = pdata->bl_pdata;
> +		else
> +			tps->bl_pdev->dev.of_node =
> +				pdata->of_node[TPS65217_SUBDEV_BL];
> +
> +		platform_device_add(tps->bl_pdev);
> +	}
> +
The MFD API probably allows you to do exactly that by defining a specific cell
for bl. Could you please try to use this API or otherwise justify not using
it?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
