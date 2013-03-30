From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Sat, 30 Mar 2013 19:36:54 +0100
Message-ID: <20130330183654.GH28947@amd.pavel.ucw.cz>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

Hi!

> +u32 rx51_secure_dispatcher(u32 idx, u32 flag, u32 nargs, u32 arg1, u32 arg2,
> +			   u32 arg3, u32 arg4)
> +{
> +	u32 ret;
> +	u32 param[5];
> +
> +	param[0] = nargs+1;
> +	param[1] = arg1;
> +	param[2] = arg2;
> +	param[3] = arg3;
> +	param[4] = arg4;
> +
> +	/*
> +	 * Secure API needs physical address
> +	 * pointer for the parameters
> +	 */
> +	flush_cache_all();
> +	outer_clean_range(__pa(param), __pa(param + 5));
> +	ret = rx51_ppa_smc(idx, flag, __pa(param));
> +
> +	return ret;
> +}

You can do without ret variable... Also more detailed changelog would
be nice... like what exact problem this works around.

<google>

So... some CPU errata where code sharing virtual addresses could be
executed improperly?
								
> @@ -103,6 +104,12 @@ static void __init rx51_init(void)
>  	rx51_peripherals_init();
>  	rx51_camera_init();
>  
> +#ifdef CONFIG_ARM_ERRATA_430973
> +	printk(KERN_INFO "Enabling ARM errata 430973 workaround.\n");
> +	/* set IBE to 1 */
> +	rx51_secure_update_aux_cr(1 << 6, 0);
> +#endif
> +

Thanks,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
