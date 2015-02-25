From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 4/8 v2] ARM OMAP2+ GPMC: fix debug output alignment
Date: Wed, 25 Feb 2015 15:05:33 +0200
Message-ID: <54EDC89D.5010707@ti.com>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On 24/02/15 22:05, Robert ABEL wrote:
> GPMC debug output is aligned to 10 characters for field names.
> However, some fields have bigger names, screwing up the alignment.
> Consequently, alignment was changed to longest field name (17 chars) for now.
> 
> Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>  drivers/memory/omap-gpmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index 78b78a64..b5c8305 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -482,7 +482,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
>  	l = gpmc_cs_read_reg(cs, reg);
>  #ifdef DEBUG
>  	printk(KERN_INFO
> -		"GPMC CS%d: %-10s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
> +		"GPMC CS%d: %-17s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
>  	       cs, name, ticks, gpmc_get_fclk_period() * ticks / 1000,
>  			(l >> st_bit) & mask, time);
>  #endif
> 
