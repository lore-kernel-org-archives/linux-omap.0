From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: kconfig: Enable devicetree by default
 for OMAP2+ systems
Date: Wed, 4 Jan 2012 13:11:11 -0700
Message-ID: <CACxGe6sAEs4H4FR75psy74x9V3mbp6wAdryJbDu8HBZ4tMmyvw@mail.gmail.com>
References: <1323190149-6492-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35846 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731Ab2ADULf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 15:11:35 -0500
Received: by pbdu13 with SMTP id u13so9517170pbd.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 12:11:35 -0800 (PST)
In-Reply-To: <1323190149-6492-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Dec 6, 2011 at 9:49 AM, Benoit Cousson <b-cousson@ti.com> wrote=
:
> devicetree will become the mandatory boot method for OMAP2+.
> In order to avoid cluttering the OMAP code with #ifdef CONFIG_OF,
> select USE_OF by default for every OMAP2+ systems.
> Select as well the APPENDED_DTB and ATAG_DTB_COMPAT to allow legacy
> boot loader to keep working properly.
>
> Enable PROC_DEVICETREE as well.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/arm/mach-omap2/Kconfig | =A0 =A01 -
> =A0arch/arm/plat-omap/Kconfig =A0| =A0 =A04 ++++
> =A02 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index e1293aa..056a812 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -109,7 +109,6 @@ comment "OMAP Board Type"
> =A0config MACH_OMAP_GENERIC
> =A0 =A0 =A0 =A0bool "Generic OMAP2+ board"
> =A0 =A0 =A0 =A0depends on ARCH_OMAP2PLUS
> - =A0 =A0 =A0 select USE_OF
> =A0 =A0 =A0 =A0default y
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Support for generic TI OMAP2+ boards using Flatten=
ed Device Tree.
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index aa59f42..74f41dc 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -24,6 +24,10 @@ config ARCH_OMAP2PLUS
> =A0 =A0 =A0 =A0select CLKDEV_LOOKUP
> =A0 =A0 =A0 =A0select GENERIC_IRQ_CHIP
> =A0 =A0 =A0 =A0select OMAP_DM_TIMER
> + =A0 =A0 =A0 select USE_OF
> + =A0 =A0 =A0 select ARM_APPENDED_DTB
> + =A0 =A0 =A0 select ARM_ATAG_DTB_COMPAT
> + =A0 =A0 =A0 select PROC_DEVICETREE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0"Systems based on OMAP2, OMAP3 or OMAP4"
>
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
