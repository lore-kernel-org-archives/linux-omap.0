From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv2 09/19] ARM: OMAP4: PM: add errata support
Date: Tue, 29 May 2012 15:10:57 -0500
Message-ID: <CAOMWX4dmt2jUOpkgFC=o5oez3CfUVzF_0NTkm23qrNQDDpmo9w@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com> <1336990730-26892-10-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:42140 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755824Ab2E2ULV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 16:11:21 -0400
Received: by wgbdq10 with SMTP id dq10so3093114wgb.27
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 13:11:18 -0700 (PDT)
In-Reply-To: <1336990730-26892-10-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Mon, May 14, 2012 at 5:18 AM, Tero Kristo <t-kristo@ti.com> wrote:
> Added similar PM errata flag support as omap3 has. A few errata flags
> will be added in subsequent patches.

Considering that we might have erratas for future SoCs as well,
should'nt we just
set up a common errata flag for all SoCs and since we have i123 numbers=
, would
it help being able to reuse errata flags cross SoC generations (if we n=
eed to)?

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 | =A0 =A07 +++++++
> =A0arch/arm/mach-omap2/pm44xx.c | =A0 =A01 +
> =A02 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index ce1e27f..e53ee3c 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -130,6 +130,13 @@ extern void enable_omap3630_toggle_l2_on_restore=
(void);
> =A0static inline void enable_omap3630_toggle_l2_on_restore(void) { }
> =A0#endif =A0 =A0 =A0 =A0 /* defined(CONFIG_PM) && defined(CONFIG_ARC=
H_OMAP3) */
>
> +#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
> +extern u16 pm44xx_errata;
> +#define IS_PM44XX_ERRATUM(id) =A0 =A0 =A0 =A0 =A0(pm44xx_errata & (i=
d))
> +#else
> +#define IS_PM44XX_ERRATUM(id) =A0 =A0 =A0 =A0 =A00
> +#endif
> +
> =A0#ifdef CONFIG_OMAP_SMARTREFLEX
> =A0extern int omap_devinit_smartreflex(void);
> =A0extern void omap_enable_smartreflex_on_init(void);
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44x=
x.c
> index 8f0ec56..8238097 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -35,6 +35,7 @@ struct power_state {
> =A0};
>
> =A0static LIST_HEAD(pwrst_list);
> +u16 pm44xx_errata;
>
> =A0#ifdef CONFIG_SUSPEND
> =A0static int omap4_pm_suspend(void)
> --
> 1.7.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
