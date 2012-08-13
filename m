From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] mfd: Fix allocation size of tps65217 platform data
Date: Mon, 13 Aug 2012 06:54:48 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA116FF@DBDE01.ent.ti.com>
References: <20120808210051.GD30282@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44155 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab2HMGy6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Aug 2012 02:54:58 -0400
In-Reply-To: <20120808210051.GD30282@darwin>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Kaehlcke <matthias@kaehlcke.net>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Matthias,

Can you comment on my latest patch? So that I can fix this issue
on the same.

https://patchwork.kernel.org/patch/1220151/

Thanks
AnilKumar

On Thu, Aug 09, 2012 at 02:30:51, Matthias Kaehlcke wrote:
> tps65217_parse_dt() allocates a struct tps65217_board for each regulator
> specified in the device tree. the structure itself provides arrays for
> the pointers to the regulator init data and the regulator device tree node,
> so only one instance of it is needed
> 
> This patch is based on the mfd tree
> 
> Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
> ---
>  drivers/mfd/tps65217.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 61c097a..cf908ac 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -162,7 +162,7 @@ static struct tps65217_board *tps65217_parse_dt(struct i2c_client *client)
>  		return NULL;
>  
>  	count = ret;
> -	pdata = devm_kzalloc(&client->dev, count * sizeof(*pdata), GFP_KERNEL);
> +	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
>  		return NULL;
>  
> -- 
> 1.7.10
> 
> 

