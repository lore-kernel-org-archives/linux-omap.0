From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] ARM: omap2: Use a consistent AM33XX SoC option description
Date: Fri, 9 Aug 2013 11:18:43 +0200
Message-ID: <CABxcv=keV2Jf4gDwF477a9Msk6b-RgDBcxK1QyhchWffbKAoXw@mail.gmail.com>
References: <1375997528-396-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:63113 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965452Ab3HIJSo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Aug 2013 05:18:44 -0400
Received: by mail-wg0-f42.google.com with SMTP id j13so1327289wgh.1
        for <linux-omap@vger.kernel.org>; Fri, 09 Aug 2013 02:18:43 -0700 (PDT)
In-Reply-To: <1375997528-396-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thu, Aug 8, 2013 at 11:32 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Fix the option description to match the other TI SoCs.
> This is just a cosmetic change.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-omap2/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 76170dd..56021c6 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -64,7 +64,7 @@ config SOC_OMAP5
>         select ARM_ERRATA_798181 if SMP
>
>  config SOC_AM33XX
> -       bool "AM33XX support"
> +       bool "TI AM33XX"
>         depends on ARCH_MULTI_V7
>         select ARCH_OMAP2PLUS
>         select ARM_CPU_SUSPEND if PM
> --
> 1.8.1.5
>
>

Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>
