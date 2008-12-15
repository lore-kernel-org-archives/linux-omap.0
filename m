From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc6-omap-git 1/2] twl4030-usb: cleanup debug code
Date: Mon, 15 Dec 2008 10:57:06 -0800
Message-ID: <20081215185705.GX10664@atomide.com>
References: <200811261644.42867.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53528 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbYLOS5J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 13:57:09 -0500
Content-Disposition: inline
In-Reply-To: <200811261644.42867.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081126 16:45]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Remove some debug code from twl4030-usb which 'checkpatch.pl' warned
> about.  Turn some other messages into debug code; and add some debug
> messages in the "write verify" paths (so we can see if they matter).
> This gives about 25% codespace shrinkage.

Pushing both to l-o tree today.

Tony

> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/i2c/chips/twl4030-usb.c |   29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
> 
> --- a/drivers/i2c/chips/twl4030-usb.c
> +++ b/drivers/i2c/chips/twl4030-usb.c
> @@ -285,13 +285,18 @@ static int twl4030_i2c_write_u8_verify(s
>  	    (twl4030_i2c_read_u8(module, &check, address) >= 0) &&
>  						(check == data))
>  		return 0;
> +	dev_dbg(twl->dev, "Write%d[%d,0x%x] wrote %02x but read %02x\n",
> +			1, module, address, check, data);
> +
>  	/* Failed once: Try again */
>  	if ((twl4030_i2c_write_u8(module, data, address) >= 0) &&
>  	    (twl4030_i2c_read_u8(module, &check, address) >= 0) &&
>  						(check == data))
>  		return 0;
> -	/* Failed again: Return error */
> +	dev_dbg(twl->dev, "Write%d[%d,0x%x] wrote %02x but read %02x\n",
> +			2, module, address, check, data);
>  
> +	/* Failed again: Return error */
>  	return -EBUSY;
>  }
>  
> @@ -304,23 +309,9 @@ static inline int twl4030_usb_write(stru
>  	int ret = 0;
>  
>  	ret = twl4030_i2c_write_u8(TWL4030_MODULE_USB, data, address);
> -	if (ret >= 0) {
> -#if 0	/* debug */
> -		u8 data1;
> -		if (twl4030_i2c_read_u8(TWL4030_MODULE_USB, &data1,
> -					address) < 0)
> -			dev_err(twl->dev, "re-read failed\n");
> -		else
> -			dev_dbg(twl->dev,
> -			       "Write %s wrote %x read %x from reg %x\n",
> -			       (data1 == data) ? "succeed" : "mismatch",
> -			       data, data1, address);
> -#endif
> -	} else {
> -		dev_warn(twl->dev,
> +	if (ret < 0)
> +		dev_dbg(twl->dev,
>  			"TWL4030:USB:Write[0x%x] Error %d\n", address, ret);
> -	}
> -
>  	return ret;
>  }
>  
> @@ -333,7 +324,7 @@ static inline int twl4030_readb(struct t
>  	if (ret >= 0)
>  		ret = data;
>  	else
> -		dev_warn(twl->dev,
> +		dev_dbg(twl->dev,
>  			"TWL4030:readb[0x%x,0x%x] Error %d\n",
>  					module, address, ret);
>  
> @@ -655,7 +646,7 @@ static int __init twl4030_usb_probe(stru
>  		return -ENOMEM;
>  
>  	if (!pdata) {
> -		dev_info(&pdev->dev, "platform_data not available\n");
> +		dev_dbg(&pdev->dev, "platform_data not available\n");
>  		return -EINVAL;
>  	}
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
