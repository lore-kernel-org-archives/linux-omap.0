From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 3/5] OMAP3630: PM: Erratum i608: disable RTA
Date: Tue, 30 Nov 2010 11:37:10 +0530
Message-ID: <AANLkTiktZPHxGJCTRUg63bR91J28mpw2Rf4riqrybMKV@mail.gmail.com>
References: <1291061993-4740-1-git-send-email-nm@ti.com> <1291061993-4740-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:48732 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751853Ab0K3GHv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 01:07:51 -0500
Received: by mail-iw0-f182.google.com with SMTP id 39so6616092iwn.13
        for <linux-omap@vger.kernel.org>; Mon, 29 Nov 2010 22:07:50 -0800 (PST)
In-Reply-To: <1291061993-4740-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Vishwa <vishwanath.bs@ti.com>

Nishant,

On Tue, Nov 30, 2010 at 01:49, Nishanth Menon <nm@ti.com> wrote:
> Erratum id: i608
> RTA (Retention Till Access) feature is not supported and leads to dev=
ice
> stability issues when enabled. This impacts modules with embedded mem=
ories
> on OMAP3630
>
> Workaround is to disable RTA on boot and coming out of core off.
> For disabling rta coming out of off mode, we do this by overriding th=
e
> restore pointer for 3630 to allow us restore handler as the first poi=
nt of
> entry before caches are touched and is common for GP and HS devices.
> to disable earlier than this could be possible by modifying the ppa f=
or HS
> devices, but not for GP devices.
>
> Signed-off-by: Ambresh K <ambresh@ti.com>

not in Cc?

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> v2: fixed missing b restore for 3430 es3.1 code.
> =A0 =A0 =A0 =A0introduced erratum handling logic here splitting it ou=
t of uart errata
> =A0 =A0 =A0 =A0typo fixes for erratum
> v1: http://marc.info/?l=3Dlinux-omap&m=3D129013172825240&w=3D2
>
> =A0arch/arm/mach-omap2/control.c =A0 | =A0 =A05 ++++-
> =A0arch/arm/mach-omap2/control.h =A0 | =A0 =A05 +++++
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0| =A0 23 +++++++++++++++++++++=
++
> =A0arch/arm/mach-omap2/sleep34xx.S | =A0 26 +++++++++++++++++++++++++=
+
> =A04 files changed, 58 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/cont=
rol.c
> index 1fa3294..728f268 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -241,7 +241,10 @@ void omap3_save_scratchpad_contents(void)
>
> =A0 =A0 =A0 =A0/* Populate the Scratchpad contents */
> =A0 =A0 =A0 =A0scratchpad_contents.boot_config_ptr =3D 0x0;
> - =A0 =A0 =A0 if (omap_rev() !=3D OMAP3430_REV_ES3_0 &&
> + =A0 =A0 =A0 if (cpu_is_omap3630())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scratchpad_contents.public_restore_ptr =
=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virt_to_phys(get_omap36=
30_restore_pointer());
> + =A0 =A0 =A0 else if (omap_rev() !=3D OMAP3430_REV_ES3_0 &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0omap_rev() !=3D OMAP3430_REV_ES3_1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scratchpad_contents.public_restore_ptr=
 =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0virt_to_phys(get_resto=
re_pointer());
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/cont=
rol.h
> index b6c6b7c..d7911c5 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -204,6 +204,10 @@
> =A0#define OMAP343X_CONTROL_WKUP_DEBOBS3 (OMAP343X_CONTROL_GENERAL_WK=
UP + 0x014)
> =A0#define OMAP343X_CONTROL_WKUP_DEBOBS4 (OMAP343X_CONTROL_GENERAL_WK=
UP + 0x018)
>
> +/* 36xx-only RTA - Retention till Accesss control registers and bits=
 */
> +#define OMAP36XX_CONTROL_MEM_RTA_CTRL =A00x40C
> +#define OMAP36XX_RTA_DISABLE =A0 =A0 =A0 =A0 =A0 0x0
> +
> =A0/* 34xx D2D idle-related pins, handled by PM core */
> =A0#define OMAP3_PADCONF_SAD2D_MSTANDBY =A0 0x250
> =A0#define OMAP3_PADCONF_SAD2D_IDLEACK =A0 =A00x254
> @@ -347,6 +351,7 @@ extern void omap3_save_scratchpad_contents(void);
> =A0extern void omap3_clear_scratchpad_contents(void);
> =A0extern u32 *get_restore_pointer(void);
> =A0extern u32 *get_es3_restore_pointer(void);
> +extern u32 *get_omap3630_restore_pointer(void);
> =A0extern u32 omap3_arm_context[128];
> =A0extern void omap3_control_save_context(void);
> =A0extern void omap3_control_restore_context(void);
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 75c0cd1..bd426cc 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -54,6 +54,10 @@
> =A0#define OMAP343X_TABLE_VALUE_OFFSET =A0 =A0 =A0 0xc0
> =A0#define OMAP343X_CONTROL_REG_VALUE_OFFSET =A00xc8
>
> +#define RTA_ERRATUM_i608 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 0)
> +static u16 pm34xx_errata;
> +#define IS_PM34XX_ERRATUM(id) =A0 =A0 =A0 =A0 =A0(pm34xx_errata & (i=
d))
> +
> =A0struct power_state {
> =A0 =A0 =A0 =A0struct powerdomain *pwrdm;
> =A0 =A0 =A0 =A0u32 next_state;
> @@ -979,6 +983,14 @@ void omap_push_sram_idle(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0save_s=
ecure_ram_context_sz);
> =A0}
>
> +static void pm_errata_configure(void)
> +{
> + =A0 =A0 =A0 if (cpu_is_omap34xx()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap3630())

Is it required to have both the cpu_is checks*?  Why?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm34xx_errata |=3D RTA_=
ERRATUM_i608;
> + =A0 =A0 =A0 }
> +}
> +

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
