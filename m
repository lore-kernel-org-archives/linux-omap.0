From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.21-rc4-omap1] fix H4 dependencies again
Date: Thu, 29 Mar 2007 16:28:18 -0400
Message-ID: <20070329202817.GK3638@atomide.com>
References: <200703281302.10190.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200703281302.10190.david-b@pacbell.net>
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
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070328 17:24]:
> Fix Kconfig sequencing:  the 2430 SDP keeps getting stuffed
> in the middle of H4 dependencies, so the various H4-specific
> config options aren't displayed as depending on H4.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -37,10 +37,6 @@ config MACH_OMAP_H4
>  	select OMAP_DEBUG_DEVICES
>  	select GPIOEXPANDER_OMAP
>  
> -config MACH_OMAP_2430SDP
> -	bool "OMAP 2430 SDP board"
> -	depends on ARCH_OMAP2 && ARCH_OMAP24XX
> -
>  config MACH_OMAP_H4_TUSB
>  	bool "TUSB 6010 EVM board"
>  	depends on MACH_OMAP_H4
> @@ -78,3 +74,8 @@ config MACH_OMAP2_H4_USB1
>  config MACH_OMAP_APOLLON
>  	bool "OMAP 2420 Apollon board"
>  	depends on ARCH_OMAP2 && ARCH_OMAP24XX
> +
> +config MACH_OMAP_2430SDP
> +	bool "OMAP 2430 SDP board"
> +	depends on ARCH_OMAP2 && ARCH_OMAP24XX
> +

Pushing today.

Tony
