From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: PM: Fix build when CONFIG_PM_DEBUG isn't set
Date: Mon, 27 Sep 2010 12:50:21 -0700
Message-ID: <87d3rzotj6.fsf@deeprootsystems.com>
References: <1285421817-6431-1-git-send-email-loic.minier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:49754 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933389Ab0I0TuZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 15:50:25 -0400
Received: by pxi10 with SMTP id 10so1535826pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 27 Sep 2010 12:50:24 -0700 (PDT)
In-Reply-To: <1285421817-6431-1-git-send-email-loic.minier@linaro.org>
 (=?iso-8859-1?Q?=22Lo=EFc?=
	Minier"'s message of "Sat, 25 Sep 2010 15:36:57 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Lo=EFc?= Minier <loic.minier@linaro.org>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Thara Gopinath <thara@ti.com>

Hi Lo=EFc,

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

Could you move these down into the exisint #ifdef CONFIG_PM_DEBUG a
little bit later in the file (after where omap2_pm_debug.)

Also, could you sign-off on the patch please?

Thanks,

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
