From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.19-rc6-omap] fix rng platform device init
Date: Tue, 28 Nov 2006 02:30:02 +0000
Message-ID: <20061128023001.GE7763@atomide.com>
References: <20061124181217.73146196734@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20061124181217.73146196734@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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

* David Brownell <david-b@pacbell.net> [061124 18:13]:
> The platform device needed for /dev/hw_random wasn't being created
> correctly; it used the wrong CONFIG symbol(s).
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> ----
> FYI, output of one "rngtest" run on a mostly-idle OSK:
> 
> Indet: starting FIPS tests...
> rngtest: bits received from input: 23479480032
> rngtest: FIPS 140-2 successes: 1173013
> rngtest: FIPS 140-2 failures: 961
> rngtest: FIPS 140-2(2001-10-10) Monobit: 124
> rngtest: FIPS 140-2(2001-10-10) Poker: 115
> rngtest: FIPS 140-2(2001-10-10) Runs: 360
> rngtest: FIPS 140-2(2001-10-10) Long run: 368
> rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
> rngtest: input channel speed: (min=274.323; avg=968.504; max=1807.947)Kibits/s
> rngtest: FIPS tests speed: (min=1.371; avg=5.956; max=6.129)Mibits/s
> rngtest: Program run time: 27463201721 microseconds
> 
> 
> --- osk2.orig/arch/arm/plat-omap/devices.c	2006-11-17 16:36:48.000000000 -0800
> +++ osk2/arch/arm/plat-omap/devices.c	2006-11-24 09:57:46.000000000 -0800
> @@ -440,7 +440,7 @@ static inline void omap_init_wdt(void) {
>  
>  /*-------------------------------------------------------------------------*/
>  
> -#if	defined(CONFIG_OMAP_RNG) || defined(CONFIG_OMAP_RNG_MODULE)
> +#if defined(CONFIG_HW_RANDOM_OMAP) || defined(CONFIG_HW_RANDOM_OMAP_MODULE)
>  
>  #ifdef CONFIG_ARCH_OMAP24XX
>  #define	OMAP_RNG_BASE		0x480A0000

Thanks, pushing today.

Tony
