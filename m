From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: PM: Fix build when CONFIG_PM_DEBUG isn't set
Date: Fri, 01 Oct 2010 13:19:07 -0700
Message-ID: <877hi18y4k.fsf@deeprootsystems.com>
References: <87d3rzotj6.fsf@deeprootsystems.com>
	<1285621460-22011-1-git-send-email-loic.minier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:49705 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab0JAUTK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 16:19:10 -0400
Received: by pxi10 with SMTP id 10so859440pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 13:19:10 -0700 (PDT)
In-Reply-To: <1285621460-22011-1-git-send-email-loic.minier@linaro.org>
 (=?iso-8859-1?Q?=22Lo=EFc?=
	Minier"'s message of "Mon, 27 Sep 2010 23:04:20 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Lo=EFc?= Minier <loic.minier@linaro.org>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Thara Gopinath <thara@ti.com>

Lo=EFc Minier <loic.minier@linaro.org> writes:

> Since 6cdee91257bee23a46dc869ca62469b67cba2c7e the references to
> enable_off_mode and sleep_while_idle can't be resolved when CONFIG_PM=
_DEBUG
> isn't set:
> arch/arm/mach-omap2/built-in.o: In function `omap_uart_restore_contex=
t':
> arch/arm/mach-omap2/serial.c:253: undefined reference to `enable_off_=
mode'
> arch/arm/mach-omap2/built-in.o: In function `omap3_can_sleep':
> arch/arm/mach-omap2/pm34xx.c:479: undefined reference to `sleep_while=
_idle'
>
> Simply #define these in pm.h just like omap2_pm_debug.
>
> Signed-off-by: Lo=EFc Minier <loic.minier@linaro.org>

Applying this fix, but moving the change down into an existing #ifdef

Kevin

> ---
>  arch/arm/mach-omap2/pm.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 77770a1..68db3a7 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -13,8 +13,13 @@
> =20
>  #include <plat/powerdomain.h>
> =20
> +#ifdef CONFIG_PM_DEBUG
>  extern u32 enable_off_mode;
>  extern u32 sleep_while_idle;
> +#else
> +#define enable_off_mode 0
> +#define sleep_while_idle 0
> +#endif
> =20
>  extern void *omap3_secure_ram_storage;
>  extern void omap3_pm_off_mode_enable(int);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
