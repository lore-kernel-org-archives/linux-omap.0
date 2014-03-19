From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 24/62] ARM: omap1: select I2C where needed for PMIC
Date: Wed, 19 Mar 2014 13:46:19 -0700
Message-ID: <20140319204619.GB8333@atomide.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-25-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23361 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607AbaCSUq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 16:46:26 -0400
Content-Disposition: inline
In-Reply-To: <1395257399-359545-25-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [140319 12:33]:
> The OMAP H2, OSK and OSIRIS machines cannot build without
> I2C and TPS65010 both enabled unconditionally.
> 
> In each case, failing to enable CONFIG_I2C results in a
> build or link error, so most consistent solution is to
> ensure that it is impossible to disable those options.
> 
> It would be nice to leave CONFIG_I2C as user-selectable,
> but doing that properly would require more work.

We should not select drivers. How about let's just have
the tps65010 stuff behind an ifdef CONFIG_TPS65010 for
those boards?

Regards,

Tony
 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> ---
>  arch/arm/mach-omap1/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> index cdd05f2..23ab1d5 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -44,6 +44,8 @@ config MACH_OMAP_INNOVATOR
>  config MACH_OMAP_H2
>  	bool "TI H2 Support"
>  	depends on ARCH_OMAP1 && ARCH_OMAP16XX
> +	select TPS65010
> +	select I2C
>      	help
>  	  TI OMAP 1610/1611B H2 board support. Say Y here if you have such
>  	  a board.
> @@ -64,6 +66,8 @@ config MACH_HERALD
>  config MACH_OMAP_OSK
>  	bool "TI OSK Support"
>  	depends on ARCH_OMAP1 && ARCH_OMAP16XX
> +	select TPS65010
> +	select I2C
>      	help
>  	  TI OMAP 5912 OSK (OMAP Starter Kit) board support. Say Y here
>            if you have such a board.
> -- 
> 1.8.3.2
> 
