From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
 cause data corruption
Date: Wed, 16 Feb 2011 15:53:48 +0000
Message-ID: <AANLkTikEjTgisftQV46djrOP8iWMFV267v-efHsVf_Nd@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com>
	<13596bec9184b117d6a1d02da8e017bf@mail.gmail.com>
	<AANLkTimjXG5-kEW=1vodnGo3Ct_xOS_HihdqN0TeL9ba@mail.gmail.com>
	<33573d5cfc91cf45dc58ee861cccc2ae@mail.gmail.com>
	<4dfaffa99292bf8e36791ea9a68de75e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43052 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab1BPPxs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 10:53:48 -0500
Received: by iyj8 with SMTP id 8so1349707iyj.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 07:53:48 -0800 (PST)
In-Reply-To: <4dfaffa99292bf8e36791ea9a68de75e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Andrei Warkentin <andreiw@motorola.com>, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org

On 15 February 2011 07:14, Santosh Shilimkar <santosh.shilimkar@ti.com>=
 wrote:
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1140,7 +1140,7 @@ config ARM_ERRATA_742231
>
> =C2=A0config PL310_ERRATA_588369
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "Clean & Invalidate maintenance opera=
tions do not invalidate
> clean lines"
> - =C2=A0 =C2=A0 =C2=A0 depends on CACHE_L2X0 && ARCH_OMAP4
> + =C2=A0 =C2=A0 =C2=A0 depends on CACHE_L2X0 && CACHE_PL310

It can just depend on CACHE_PL310 as this depends on CACHE_L2X0.

> +config PL310_ERRATA_727915
> + =C2=A0 =C2=A0 =C2=A0 bool "Background Clean & Invalidate by Way ope=
ration can cause
> data corruption"
> + =C2=A0 =C2=A0 =C2=A0 depends on CACHE_L2X0 && CACHE_PL310

Same here.

> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -45,7 +45,10 @@ config ARCH_OMAP4
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select CPU_V7
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select ARM_GIC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select LOCAL_TIMERS
> + =C2=A0 =C2=A0 =C2=A0 select CACHE_L2X0

CACHE_L2X0 has a long dependency list. You could add ARCH_OMAP4 in
there or just change the other platforms to select a HAVE_CACHE_L2X0.
Ideally we would like this option to be selectable in config just in
case you want to debug some issues.

> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -52,6 +52,12 @@ static void omap4_l2x0_disable(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_smc1(0x102, 0x0);
> =C2=A0}
>
> +static void omap4_l2x0_set_debug(unsigned long val)
> +{
> + =C2=A0 =C2=A0 =C2=A0 /* Program PL310 L2 Cache controller debug reg=
ister */
> + =C2=A0 =C2=A0 =C2=A0 omap_smc1(0x100, val);
> +}

This part together with the Kconfig changes for OMAP4 could be a
separate patch, OMAP-specific.

The rest seems fine.

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
