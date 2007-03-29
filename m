From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.21-rc4-omap1] omap2/pm.c build fix
Date: Thu, 29 Mar 2007 16:29:13 -0400
Message-ID: <20070329202912.GM3638@atomide.com>
References: <200703281316.09088.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200703281316.09088.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070328 17:24]:
> Fix build bug ... next_timer_interrupt() depends on NO_IDLE_HZ
> or else (new style) NO_HZ, so don't assume it's always present.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -389,8 +389,12 @@ #endif
>  	}
>  
>  	if (!resume)
> +#if defined(CONFIG_NO_IDLE_HZ) || defined(CONFIG_NO_HZ)
>  		printk("--- Going to %s %s (next timer after %u ms)\n", s1, s2,
>  		       jiffies_to_msecs(next_timer_interrupt() - jiffies));
> +#else
> +		printk("--- Going to %s %s\n", s1, s2);
> +#endif
>  	else
>  		printk("--- Woke up (slept for %u.%03u ms)\n", us / 1000, us % 1000);
>  	for (i = 0; i < reg_count; i++)

Pushing today.

Tony
