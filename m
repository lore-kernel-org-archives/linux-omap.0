From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH] [RFC] Remove the debug print noise
Date: Tue, 10 Aug 2010 16:09:32 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401D991@dbde02.ent.ti.com>
References: <1280753271-21182-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757301Ab0HJKjg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 06:39:36 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7AAdXDY016447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 05:39:35 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o7AAdWfr012841
	for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 16:09:32 +0530 (IST)
In-Reply-To: <1280753271-21182-1-git-send-email-shubhrajyoti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Shubhrajyoti D
> Sent: Monday, August 02, 2010 6:18 PM
> To: linux-omap@vger.kernel.org
> Cc: Datta, Shubhrajyoti
> Subject: [PATCH] [RFC] Remove the debug print noise
> 
> This patch intends to make the i2cdetect more readable.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 7674efb..3a97d2c 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -626,7 +626,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	if (r < 0)
>  		return r;
>  	if (r == 0) {
> -		dev_err(dev->dev, "controller timed out\n");
> +		dev_dbg(dev->dev, "controller timed out\n");

Did you compile the code? I thought it would be as below:
dev_dbg(&dev->dev, "controller timed out\n");

>  		omap_i2c_init(dev);
>  		return -ETIMEDOUT;
>  	}
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
