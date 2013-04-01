From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: remove "config MACH_OMAP_HTCWIZARD"
Date: Mon, 1 Apr 2013 08:53:45 -0700
Message-ID: <20130401155345.GD10155@atomide.com>
References: <1363901769.1390.159.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363901769.1390.159.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Bolle <pebolle@tiscali.nl> [130321 14:40]:
> The Kconfig symbol MACH_OMAP_HTCWIZARD got added in v2.6.30. It has
> never been used. Its entry can safely be removed.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.

Thanks, applying into omap-for-v3.10/fixes-non-critical.

Regards,

Tony
 
>  arch/arm/mach-omap1/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> index 903da8e..cdd05f2 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -55,12 +55,6 @@ config MACH_OMAP_H3
>  	  TI OMAP 1710 H3 board support. Say Y here if you have such
>  	  a board.
>  
> -config MACH_OMAP_HTCWIZARD
> -	bool "HTC Wizard"
> -	depends on ARCH_OMAP850
> -	help
> -	  HTC Wizard smartphone support (AKA QTEK 9100, ...)
> -
>  config MACH_HERALD
>  	bool "HTC Herald"
>  	depends on ARCH_OMAP850
> -- 
> 1.7.11.7
> 
