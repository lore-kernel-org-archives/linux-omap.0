From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] ARM: OMAP: SmartReflex: select CONFIG_POWER_SUPPLY in Kconfig
Date: Tue, 02 Oct 2012 14:50:53 -0700
Message-ID: <87zk447dc2.fsf@deeprootsystems.com>
References: <1348151816-30248-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62639 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932392Ab2JBVux (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Oct 2012 17:50:53 -0400
Received: by pbbrr4 with SMTP id rr4so9181063pbb.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Oct 2012 14:50:52 -0700 (PDT)
In-Reply-To: <1348151816-30248-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Thu, 20 Sep 2012 16:36:56 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Select POWER_SUPPLY from POWER_AVS_OMAP entry in Kconfig.
>
> This avoids the following build problems using a randconfig
> that has CONFIG_POWER_SUPPLY not set:
>
>   LD      init/built-in.o
> arch/arm/mach-omap2/built-in.o: In function `sr_class3_configure':
> arch/arm/mach-omap2/smartreflex-class3.c:44: undefined reference to `sr_configure_errgen'
> arch/arm/mach-omap2/built-in.o: In function `sr_class3_disable':
> arch/arm/mach-omap2/smartreflex-class3.c:33: undefined reference to `sr_disable_errgen'
> arch/arm/mach-omap2/smartreflex-class3.c:35: undefined reference to `sr_disable'
> arch/arm/mach-omap2/built-in.o: In function `sr_class3_enable':
> arch/arm/mach-omap2/smartreflex-class3.c:28: undefined reference to `sr_enable'
> arch/arm/mach-omap2/built-in.o: In function `sr_class3_init':
> arch/arm/mach-omap2/smartreflex-class3.c:59: undefined reference to `sr_register_class'
> make: *** [vmlinux] Error 1
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Thanks, queuing for v3.7-rc

Kevin

> ---
>  arch/arm/plat-omap/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index dd36eba..001a795 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -48,6 +48,7 @@ config OMAP_DEBUG_LEDS
>  config POWER_AVS_OMAP
>  	bool "AVS(Adaptive Voltage Scaling) support for OMAP IP versions 1&2"
>  	depends on POWER_AVS && (ARCH_OMAP3 || ARCH_OMAP4) && PM
> +	select POWER_SUPPLY
>  	help
>  	  Say Y to enable AVS(Adaptive Voltage Scaling)
>  	  support on OMAP containing the version 1 or
