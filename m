From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 4/5 v2] OMAP3630: PM: Disable L2 cache while invalidating
 L2 cache
Date: Tue, 30 Nov 2010 11:42:12 +0530
Message-ID: <AANLkTi=ynHCz_dGM___7wD1+dx=GTLm+NSTYxbCeP8xc@mail.gmail.com>
References: <1291061993-4740-1-git-send-email-nm@ti.com> <1291061993-4740-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44586 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752845Ab0K3GMy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 01:12:54 -0500
Received: by mail-iw0-f170.google.com with SMTP id 9so688323iwn.15
        for <linux-omap@vger.kernel.org>; Mon, 29 Nov 2010 22:12:53 -0800 (PST)
In-Reply-To: <1291061993-4740-5-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Vishwa <vishwanath.bs@ti.com>

Nishant,

On Tue, Nov 30, 2010 at 01:49, Nishanth Menon <nm@ti.com> wrote:
> From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>
> This disables L2 cache before invalidating it and reenables it afterw=
ards.
> This is be done according to ARM documentation. Currently this is ide=
ntified
> as being needed on OMAP3630 as the disable/enable is done from "publi=
c side"
> while, on OMAP3430, this is done in the "secure side".
>
> [nm@ti.com: ported to 2.6.37-rc2, added hooks to enable the logic onl=
y on 3630]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
> v2: rebased out to this series independent of HS bugfixes
> v1: http://marc.info/?l=3Dlinux-omap&m=3D129013171125204&w=3D2
>
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0| =A0 =A06 ++++++
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0| =A0 =A03 +++
> =A0arch/arm/mach-omap2/sleep34xx.S | =A0 30 +++++++++++++++++++++++++=
+++++
> =A03 files changed, 39 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 0d75bfd..aff39d0 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -85,4 +85,10 @@ extern unsigned int save_secure_ram_context_sz;
> =A0extern unsigned int omap24xx_cpu_suspend_sz;
> =A0extern unsigned int omap34xx_cpu_suspend_sz;
>
> +#if defined(CONFIG_PM)
> +extern void enable_omap3630_toggle_l2_on_restore(void);
> +#else
> +static inline void enable_omap3630_toggle_l2_on_restore(void) { }
> +#endif
> +
> =A0#endif
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index bd426cc..e0ade5f 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -988,6 +988,9 @@ static void pm_errata_configure(void)
> =A0 =A0 =A0 =A0if (cpu_is_omap34xx()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpu_is_omap3630())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm34xx_errata |=3D RTA=
_ERRATUM_i608;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable the l2 cache toggling in slee=
p logic */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap3630())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_omap3630_toggle_=
l2_on_restore();


This can simply be like this:
=2E..
=2E..
-         if (cpu_is_omap3630())
+         if (cpu_is_omap3630()) {
                         pm34xx_errata |=3D RTA_ERRATUM_i608;
+                        /* Enable the l2 cache toggling in sleep logic=
 */
+                       enable_omap3630_toggle_l2_on_restore();
+          }
=2E..
=2E..

> =A0 =A0 =A0 =A0}
> =A0}
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
