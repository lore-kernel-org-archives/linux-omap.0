From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v4 3/7] omap3: pm: introduce errata handling
Date: Mon, 20 Dec 2010 11:18:32 +0100
Message-ID: <AANLkTimXTxZ1=9wKYAo7rUGkwdzRpL4-mF-R7-qLNTLF@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60622 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab0LTKSc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 05:18:32 -0500
Received: by qyk12 with SMTP id 12so2979155qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 02:18:32 -0800 (PST)
In-Reply-To: <1292712817-24999-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

Hi Nishant,

Here a few minor remarks about typos:

On Sat, Dec 18, 2010 at 11:53 PM, Nishanth Menon <nm@ti.com> wrote:
> Introduce errata handling for omap3. This patch introduces
Use caps for OMAP3

> errata variable and and stub for initialization which will be
and and -> and

> filled up by followon patches.
followon -> follow-on?

>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Splitting the errata introduction out into it's own separate patch
>
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 | =A0 =A07 +++++++
> =A0arch/arm/mach-omap2/pm34xx.c | =A0 =A09 +++++++++
> =A02 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 0d75bfd..0348fd7 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -85,4 +85,11 @@ extern unsigned int save_secure_ram_context_sz;
> =A0extern unsigned int omap24xx_cpu_suspend_sz;
> =A0extern unsigned int omap34xx_cpu_suspend_sz;
>
> +#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
> +extern u16 pm34xx_errata;
> +#define IS_PM34XX_ERRATUM(id) =A0 =A0 =A0 =A0 =A0(pm34xx_errata & (i=
d))
> +#else
> +#define IS_PM34XX_ERRATUM(id) =A0 =A0 =A0 =A0 =A00
> +#endif =A0 =A0 =A0 =A0 /* defined(CONFIG_PM) && defined(CONFIG_ARCH_=
OMAP3) */
> +
> =A0#endif
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 648b8c5..5702f41 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -68,6 +68,9 @@ static inline bool is_suspending(void)
> =A0#define OMAP343X_TABLE_VALUE_OFFSET =A0 =A0 =A0 0xc0
> =A0#define OMAP343X_CONTROL_REG_VALUE_OFFSET =A00xc8
>
> +/* pm34xx errata defined in pm.h */
> +u16 pm34xx_errata;
> +
> =A0struct power_state {
> =A0 =A0 =A0 =A0struct powerdomain *pwrdm;
> =A0 =A0 =A0 =A0u32 next_state;
> @@ -1002,6 +1005,10 @@ void omap_push_sram_idle(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0save_s=
ecure_ram_context_sz);
> =A0}
>
> +static void __init pm_errata_configure(void)
> +{
> +}
> +
> =A0static int __init omap3_pm_init(void)
> =A0{
> =A0 =A0 =A0 =A0struct power_state *pwrst, *tmp;
> @@ -1011,6 +1018,8 @@ static int __init omap3_pm_init(void)
> =A0 =A0 =A0 =A0if (!cpu_is_omap34xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> + =A0 =A0 =A0 pm_errata_configure();
> +
> =A0 =A0 =A0 =A0printk(KERN_ERR "Power Management for TI OMAP3.\n");
>
> =A0 =A0 =A0 =A0/* XXX prcm_setup_regs needs to be before enabling hw
> --
> 1.6.3.3
>
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
