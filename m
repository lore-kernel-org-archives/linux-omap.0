From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: Re: [PATCH] ARM: mach-omap2: Kconfig: select SUSPEND and PM_SLEEP if
 PM for omap3
Date: Sun, 14 Aug 2011 20:22:46 +0200
Message-ID: <CAFULf_x5uc3KEVW_cNAn9cdxM8ANjv540dWZW4_Z3ouzU8aeig@mail.gmail.com>
References: <CAFULf_wD-qNq5=X5pv=E8+Q2wR-N2n2_z=txL5t7EwF4dQrLYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43596 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab1HNSWr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Aug 2011 14:22:47 -0400
Received: by vws1 with SMTP id 1so3499254vws.19
        for <linux-omap@vger.kernel.org>; Sun, 14 Aug 2011 11:22:46 -0700 (PDT)
In-Reply-To: <CAFULf_wD-qNq5=X5pv=E8+Q2wR-N2n2_z=txL5t7EwF4dQrLYg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

=46orget this one.  I did get this problem compiling a randconfig, but
the explanation and the subsequent fix is incorrect.

Sorry about the noise.

Bjarne

On Sun, Aug 14, 2011 at 6:41 PM, Bjarne Steinsbo <bsteinsbo@gmail.com> =
wrote:
> It's conceivable to configure a kernel with CONFIG_PM, but without
> CONFIG_PM_SLEEP.
>
> - If CONFIG_PM is defined, pm34xx.c calls cpu_suspend() in line 430.
> - cpu_suspend() is a static inline defined in asm/suspend.h, calling
> __cpu_suspend() to do the real job.
> - But __cpu_suspend (in kernel/sleep.S) is only linked in if
> CONFIG_PM_SLEEP is defined.
>
> The result is a link error:
> arch/arm/mach-omap2/built-in.o: In function `cpu_suspend':
> arch/arm/include/asm/suspend.h:17: undefined reference to `__cpu_susp=
end'
>
> There is a similar dependency error with a call to cpu_resume() in
> sleep34xx.S, line 534.
>
> Since the code obviously assumes that PM_SLEEP should be defined if
> PM, change the omap2 Kconfig
> to reflect this. =A0The existing selection of PM_OPP if PM serves as =
a
> precedent for this solution.
>
> When selecting PM_SLEEP, also select SUSPEND, which PM_SLEEP depends =
on.
>
> Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
> ---
> =A0arch/arm/mach-omap2/Kconfig | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index 57b66d5..04a3a83 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -36,6 +36,8 @@ config ARCH_OMAP3
> =A0 =A0 =A0 =A0select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
> =A0 =A0 =A0 =A0select ARCH_HAS_OPP
> =A0 =A0 =A0 =A0select PM_OPP if PM
> + =A0 =A0 =A0 select SUSPEND if PM
> + =A0 =A0 =A0 select PM_SLEEP if PM
>
> =A0config ARCH_OMAP4
> =A0 =A0 =A0 =A0bool "TI OMAP4"
> --
> 1.7.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
