From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] drivers: memory: This patch fix the following checkpatch
 warning.
Date: Tue, 16 Apr 2019 11:49:53 +0300
Message-ID: <27678553-2f8b-cd8a-c3ed-dc897922dc42@ti.com>
References: <1555404372-3582-1-git-send-email-mohankumar718@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555404372-3582-1-git-send-email-mohankumar718@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mohan Kumar <mohankumar718@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Mohan,

On 16/04/2019 11:46, Mohan Kumar wrote:
> Switch hardcoded function name with a reference to __func__ making the
> code more maintainable
> 
> WARNING: Prefer using '"%s...", __func__' to using function's name, in a
> string
> 
> Use pr_warn instead of printk
> 
> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ...
> then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/memory/omap-gpmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index f629759..685f422 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -795,7 +795,7 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t,
>  #endif
>  
>  	gpmc_cs_bool_timings(cs, &t->bool_timings);
> -	gpmc_cs_show_timings(cs, "after gpmc_cs_set_timings");
> +	gpmc_cs_show_timings(cs, "%s", __func__);

This will not build. gpmc_cs_show_timings only takes 2 arguments.
>  
>  	return 0;
>  }
> @@ -1033,7 +1033,7 @@ void gpmc_cs_free(int cs)
>  
>  	spin_lock(&gpmc_mem_lock);
>  	if (cs >= gpmc_cs_num || cs < 0 || !gpmc_cs_reserved(cs)) {
> -		printk(KERN_ERR "Trying to free non-reserved GPMC CS%d\n", cs);
> +		pr_err("Trying to free non-reserved GPMC CS%d\n", cs);
>  		BUG();
>  		spin_unlock(&gpmc_mem_lock);
>  		return;
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
