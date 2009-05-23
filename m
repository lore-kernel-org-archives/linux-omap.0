From: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
Subject: Re: [PATCH] Select TWL4030_CORE for boards which need twl4030_i2c_*
	functions.
Date: Sat, 23 May 2009 16:53:16 +0300
Message-ID: <fce2a370905230653pf809d74xf37ce022586a05a5@mail.gmail.com>
References: <1243085964-31024-1-git-send-email-ihar.hrachyshka@gmail.com>
	 <1243086728-31127-1-git-send-email-ihar.hrachyshka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:60052 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbZEWNxR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 May 2009 09:53:17 -0400
Received: by bwz22 with SMTP id 22so2151632bwz.37
        for <linux-omap@vger.kernel.org>; Sat, 23 May 2009 06:53:16 -0700 (PDT)
In-Reply-To: <1243086728-31127-1-git-send-email-ihar.hrachyshka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>

Sorry for the noise on ML. That was the right patch with the right log.

On Sat, May 23, 2009 at 4:52 PM, Ihar Hrachyshka
<ihar.hrachyshka@gmail.com> wrote:
> This fixes compilation for the following machines: MACH_OMAP_2430SDP,
> MACH_OMAP_LDP, MACH_OMAP2EVM, MACH_OMAP_3430SDP, MACH_OMAP3EVM,
> MACH_OMAP3_BEAGLE, MACH_OVERO, MACH_OMAP3_PANDORA, when TWL4030_CORE =
is not
> enabled.
>
> Signed-off-by: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
> ---
> =C2=A0arch/arm/mach-omap2/Kconfig | =C2=A0 =C2=A08 ++++++++
> =C2=A01 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index 27750f5..cffd979 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -105,34 +105,42 @@ config MACH_OMAP_APOLLON
> =C2=A0config MACH_OMAP_2430SDP
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "OMAP 2430 SDP board"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_OMAP2 && ARCH_OMAP2430
> + =C2=A0 =C2=A0 =C2=A0 select TWL4030_CORE
>
> =C2=A0config MACH_OMAP_LDP
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "OMAP3 LDP board"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX
> + =C2=A0 =C2=A0 =C2=A0 select TWL4030_CORE
>
> =C2=A0config MACH_OMAP2EVM
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "OMAP 2530 EVM board"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_OMAP2 && ARCH_OMAP24XX
> + =C2=A0 =C2=A0 =C2=A0 select TWL4030_CORE
>
> =C2=A0config MACH_OMAP_3430SDP
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "OMAP 3430 SDP board"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX
> + =C2=A0 =C2=A0 =C2=A0 select TWL4030_CORE
>
> =C2=A0config MACH_OMAP3EVM
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "OMAP 3530 EVM board"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX
> + =C2=A0 =C2=A0 =C2=A0 select TWL4030_CORE
>
> =C2=A0config MACH_OMAP3_BEAGLE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "OMAP3 BEAGLE board"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX
> + =C2=A0 =C2=A0 =C2=A0 select TWL4030_CORE
>
> =C2=A0config MACH_OVERO
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "Gumstix Overo board"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX
> + =C2=A0 =C2=A0 =C2=A0 select TWL4030_CORE
>
> =C2=A0config MACH_OMAP3_PANDORA
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "OMAP3 Pandora"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX
> + =C2=A0 =C2=A0 =C2=A0 select TWL4030_CORE
>
> =C2=A0config OMAP_TICK_GPTIMER
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int "GPTIMER used for system tick timer"
> --
> 1.6.3.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
