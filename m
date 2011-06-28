From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC] OMAP3: powerdomains: Match silicon revision to select the correct "core_pwrdm" definition
Date: Tue, 28 Jun 2011 09:17:03 -0700
Message-ID: <87fwmuylq8.fsf@ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870370A4D8EF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:42703 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758156Ab1F1QRH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 12:17:07 -0400
Received: by mail-pw0-f43.google.com with SMTP id 9so305139pwi.2
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 09:17:06 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870370A4D8EF@dbde02.ent.ti.com>
	(Abhilash Koyamangalath's message of "Tue, 28 Jun 2011 15:22:55
	+0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Premi, Sanjeev" <premi@ti.com>

"Koyamangalath, Abhilash" <abhilash.kv@ti.com> writes:

> powerdomains3xxx_data.c defines core_3xxx_pre_es3_1_pwrdm and
> core_3xxx_es3_1_pwrdm to take care of differences in "core_pwrdm"
> implementations across revisions.
> However,_pwrdm_lookup("core_pwrdm") always matches the first definition for
> 3630 ES 1.1 and 1.2 which is incorrect. This patch fixes this issue by adding
> code to match silicon revision as well while looking up "core_pwrdm" in
> _pwrdm_lookup().
> core_3xxx_es3_1_pwrdm is different from core_3xxx_pre_es3_1_pwrdm in
> that the former adds hardware save-restore support for USBTLL for 3430
> ES3.1 and for 3630 ES1.1 and ES1.2.
> However,with this change, issuing a standby command (by suspending to RAM)
> seems to crash the system on a 3630 ES1.2., with or without the USB support
> enabled.
> I'm not very sure about how the USBTLL setting effects the suspend operation of
> the rest of the system.

Checkpatch reports:
total: 17 errors, 16 warnings, 29 lines checked

Please fix punctuation, spacing, line-wrapping in changelog for
readability.

The CPU rev is also used on other 34xx SoCs, please check for those too.

Kevin

>
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index eaed0df..cc2b6e6 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -29,6 +29,7 @@
>  #include "powerdomain.h"
>  #include "clockdomain.h"
>  #include <plat/prcm.h>
> +#include <plat/cpu.h>
>
>  #include "pm.h"
>
> @@ -53,6 +54,22 @@ static struct powerdomain *_pwrdm_lookup(const char *name)
>
>         list_for_each_entry(temp_pwrdm, &pwrdm_list, node) {
>                 if (!strcmp(name, temp_pwrdm->name)) {
> +                       if (!strcmp(name, "core_pwrdm") && cpu_is_omap3630()) {
> +                               if (omap_rev() > OMAP3630_REV_ES1_0) {
> +                               /*
> +                                * match omap_chip info for OMAP3630 Rev ES1.1, 
> +                                * ES1.2 or higher
> +                                */
> +                                       if (!(temp_pwrdm->omap_chip.oc
> +                                               & CHIP_GE_OMAP3630ES1_1))
> +                                               continue;
> +                               } else {
> +                               /* match omap_chip info for OMAP3630 Rev ES1.0 */
> +                                       if (!(temp_pwrdm->omap_chip.oc
> +                                                & CHIP_IS_OMAP3630ES1))
> +                                               continue;
> +                               }
> +                       }
>                         pwrdm = temp_pwrdm;
>                         break;
>                 }
