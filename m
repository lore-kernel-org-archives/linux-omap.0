From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC PATCH v2 01/12] mtd: rawnand: ams-delta: Assign
 mtd->dev.parent, not mtd->owner
Date: Tue, 7 Aug 2018 01:54:10 +0200
Message-ID: <604ff0fb-07d5-9068-2f69-41198f3d9854@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806222918.12644-2-jmkrzyszt@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/07/2018 12:29 AM, Janusz Krzysztofik wrote:
> Fix missing mtd->dev.parent assignment and drop useless mtd->owner.

You fail to explain why this fix is required.

> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/mtd/nand/raw/ams-delta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index 2a8872ebd14a..af313c620264 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -162,7 +162,7 @@ static int ams_delta_init(struct platform_device *pdev)
>  	}
>  
>  	ams_delta_mtd = nand_to_mtd(this);
> -	ams_delta_mtd->owner = THIS_MODULE;
> +	ams_delta_mtd->dev.parent = &pdev->dev;
>  
>  	/*
>  	 * Don't try to request the memory region from here,
> 


-- 
Best regards,
Marek Vasut
