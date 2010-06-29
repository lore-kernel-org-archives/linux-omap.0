From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/6] omap: Disable VGA console for omaps
Date: Tue, 29 Jun 2010 16:07:24 +0400
Message-ID: <20100629120724.GA23884@oksana.dev.rtsoft.ru>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
 <20100629114720.16008.84291.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47508 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755537Ab0F2MH3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 08:07:29 -0400
Content-Disposition: inline
In-Reply-To: <20100629114720.16008.84291.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Tue, Jun 29, 2010 at 02:47:20PM +0300, Tony Lindgren wrote:
> Otherwise we have to disable it manually to avoid compile errors.
> 
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

We'll need this for mach-cns3xxx too. And doing that change for
every ARM subarch is going to produce lots of rejects.

I'd suggest to disable (or make it 'default n') for all ARMs,
except these:

$ git grep VGA_CONSOLE= arch/arm/configs/
arch/arm/configs/footbridge_defconfig:CONFIG_VGA_CONSOLE=y
arch/arm/configs/integrator_defconfig:CONFIG_VGA_CONSOLE=y
arch/arm/configs/netwinder_defconfig:CONFIG_VGA_CONSOLE=y

Thanks!

> ---
>  drivers/video/console/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 8e8f18d..467a966 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -6,7 +6,7 @@ menu "Console display driver support"
>  
>  config VGA_CONSOLE
>  	bool "VGA text console" if EMBEDDED || !X86
> -	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE && !SUPERH && !BLACKFIN && !AVR32 && !MN10300
> +	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE && !SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !ARCH_OMAP
>  	default y
>  	help
>  	  Saying Y here will allow you to use Linux in text mode through a

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
