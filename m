From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFT 6/8] ARM: OMAP: remove unused cpu_is_omap3505()
Date: Mon, 30 Apr 2012 11:07:16 +0200
Message-ID: <CAORVsuVYXooj5CPzZZhOL8asmoX5X1bB=D-7pyf4McgKOATmyg@mail.gmail.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
	<1335482993-14035-7-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62675 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab2D3JHR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 05:07:17 -0400
Received: by vcqp1 with SMTP id p1so1881005vcq.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 02:07:16 -0700 (PDT)
In-Reply-To: <1335482993-14035-7-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin,

On Fri, Apr 27, 2012 at 1:29 AM, Kevin Hilman <khilman@ti.com> wrote:
> The 3505 check is now unused and can be removed.
>
> There are no longer any cpu_is_* checks that depend on specific IP
> detection.
>
> Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/cpu.h | =A0 =A08 +-------
> =A01 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-om=
ap/include/plat/cpu.h
> index 41f3e5a..b34bf6c 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -250,8 +250,7 @@ IS_AM_SUBCLASS(335x, 0x335)
> =A0* cpu_is_omap2423(): =A0True for OMAP2423
> =A0* cpu_is_omap2430(): =A0True for OMAP2430
> =A0* cpu_is_omap3430(): =A0True for OMAP3430
> - * cpu_is_omap3505(): =A0True for OMAP3505
> - * cpu_is_omap3517(): =A0True for OMAP3517
> + * cpu_is_omap3517(): =A0True for AM35x: OMAP3517, OMAP3505
Is cpu_is_omap35xx() a better name for it?

Regards,
Jean

> =A0*/
> =A0#define GET_OMAP_TYPE =A0((omap_rev() >> 16) & 0xffff)
>
> @@ -275,7 +274,6 @@ IS_OMAP_TYPE(2422, 0x2422)
> =A0IS_OMAP_TYPE(2423, 0x2423)
> =A0IS_OMAP_TYPE(2430, 0x2430)
> =A0IS_OMAP_TYPE(3430, 0x3430)
> -IS_OMAP_TYPE(3505, 0x3517)
> =A0IS_OMAP_TYPE(3517, 0x3517)
>
> =A0#define cpu_is_omap310() =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> @@ -292,7 +290,6 @@ IS_OMAP_TYPE(3517, 0x3517)
> =A0#define cpu_is_omap2423() =A0 =A0 =A0 =A0 =A0 =A0 =A00
> =A0#define cpu_is_omap2430() =A0 =A0 =A0 =A0 =A0 =A0 =A00
> =A0#define cpu_is_omap3530() =A0 =A0 =A0 =A0 =A0 =A0 =A00
> -#define cpu_is_omap3505() =A0 =A0 =A0 =A0 =A0 =A0 =A00
> =A0#define cpu_is_omap3517() =A0 =A0 =A0 =A0 =A0 =A0 =A00
> =A0#define cpu_is_omap3430() =A0 =A0 =A0 =A0 =A0 =A0 =A00
> =A0#define cpu_is_omap3630() =A0 =A0 =A0 =A0 =A0 =A0 =A00
> @@ -346,7 +343,6 @@ IS_OMAP_TYPE(3517, 0x3517)
> =A0#if defined(CONFIG_ARCH_OMAP3)
> =A0# undef cpu_is_omap3430
> =A0# undef cpu_is_omap3530
> -# undef cpu_is_omap3505
> =A0# undef cpu_is_omap3517
> =A0# undef cpu_is_ti81xx
> =A0# undef cpu_is_ti816x
> @@ -356,8 +352,6 @@ IS_OMAP_TYPE(3517, 0x3517)
> =A0# define cpu_is_omap3430() =A0 =A0 =A0 =A0 =A0 =A0 is_omap3430()
> =A0# define cpu_is_omap3530() =A0 =A0 =A0 =A0 =A0 =A0 (cpu_is_omap343=
0())
> =A0# define cpu_is_omap3517() =A0 =A0 =A0 =A0 =A0 =A0 is_omap3517()
> -# define cpu_is_omap3505() =A0 =A0 =A0 =A0 =A0 =A0 (cpu_is_omap3517(=
) && =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 !omap3_has_sgx())
> =A0# undef cpu_is_omap3630
> =A0# define cpu_is_omap3630() =A0 =A0 =A0 =A0 =A0 =A0 is_omap363x()
> =A0# define cpu_is_ti81xx() =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_ti81xx()
> --
> 1.7.9.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
