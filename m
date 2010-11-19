From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 13/13] OMAP3630: PM: Errata i583: disable coreoff if < ES1.2
Date: Fri, 19 Nov 2010 11:07:13 +0100
Message-ID: <AANLkTimqoLvHK3xzg9kVWn7wNexBKN=iiKrCjnwJY40y@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<1290131698-6194-14-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33660 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab0KSKHO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 05:07:14 -0500
Received: by qwd7 with SMTP id 7so24886qwd.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 02:07:13 -0800 (PST)
In-Reply-To: <1290131698-6194-14-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

On Fri, Nov 19, 2010 at 2:54 AM, Nishanth Menon <nm@ti.com> wrote:
> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>
> Limitation i583: Self_Refresh Exit issue after OFF mode
>
> Issue:
> When device is waking up from OFF mode, then SDRC state machine sends
> inappropriate sequence violating JEDEC standards.
>
> Impact:
> OMAP3630 < ES1.2 is impacted as follows depending on the platform:
> CS0: for 38.4MHz as internal sysclk, DDR content seen to be stable, w=
hile
> =A0 =A0 =A0 =A0for all other sysclk frequencies, varied levels of ins=
tability
> =A0 =A0 =A0 =A0seen based on varied parameters.
> CS1: impacted
>
> This patch takes option #3 as recommended by the Silicon errata:
> Avoid core power domain transitioning to OFF mode. Power consumption
> impact is expected in this case.
> To do this, we route OFF requests to RET request on the impacted revi=
sions
> of silicon.
>
> [nm@ti.com: rebased the code to 2.6.37-rc2- short circuit code change=
d a bit]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
> =A0arch/arm/mach-omap2/pm34xx.c | =A0 14 ++++++++++++++
> =A01 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 0102d60..1890e49 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -86,6 +86,7 @@ static int secure_ram_saved;
>
> =A0#define PER_WAKEUP_ERRATA_i582 (1 << 0)
> =A0#define RTA_ERRATA_i608 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
> +#define SDRC_WAKEUP_ERRATA_i583 =A0 =A0 =A0 =A0(1 << 0)
This value should be (1 << 2).

> =A0static u16 pm34xx_errata;
> =A0#define IS_PM34XX_ERRATA(id) =A0 (pm34xx_errata & (id))
>
> @@ -437,6 +438,17 @@ void omap_sram_idle(void)
> =A0 =A0 =A0 =A0omap3_intc_prepare_idle();
>
> =A0 =A0 =A0 =A0/* CORE */
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Errata i583: implementation for ES rev < Es1.2 on =
3630
> + =A0 =A0 =A0 =A0* We cannot enable OFF mode in a stable form for pre=
vious
> + =A0 =A0 =A0 =A0* revisions, transition instead to RET
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (IS_PM34XX_ERRATA(SDRC_WAKEUP_ERRATA_i583) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (core_next_state =3D=3D=
 PWRDM_POWER_OFF)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_next_pwrst(core_pwrdm, PWRDM_=
POWER_RET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_next_state =3D PWRDM_POWER_RET;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (core_next_state < PWRDM_POWER_ON) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_uart_prepare_idle(0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_uart_prepare_idle(1);
> @@ -1050,6 +1062,8 @@ static void pm_errata_configure(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm34xx_errata |=3D PER_WAKEUP_ERRATA_i=
582;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpu_is_omap3630() && (omap_rev() >=
 OMAP3630_REV_ES1_1))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm34xx_errata &=3D ~PE=
R_WAKEUP_ERRATA_i582;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap3630() && (omap_rev() < =
OMAP3630_REV_ES1_2))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm34xx_errata |=3D SDRC=
_WAKEUP_ERRATA_i583;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpu_is_omap3630())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm34xx_errata |=3D RTA=
_ERRATA_i608;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Enable the l2 cache toggling in sle=
ep logic */
> --
> 1.6.3.3
>
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
