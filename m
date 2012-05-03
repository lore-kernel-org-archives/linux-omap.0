From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCHv4 8/8] ARM: OMAP4: PM: Added option for enabling OSWR
Date: Thu, 3 May 2012 13:03:02 +0200
Message-ID: <CAORVsuWVMa-_T4JuXTwT6sePhp0mPoE9U_xhwA28AULveeiM+w@mail.gmail.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
	<1334913591-26312-9-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:53042 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756540Ab2ECLDC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 07:03:02 -0400
Received: by vbbff1 with SMTP id ff1so1140546vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 04:03:02 -0700 (PDT)
In-Reply-To: <1334913591-26312-9-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Hi Tero,

On Fri, Apr 20, 2012 at 11:19 AM, Tero Kristo <t-kristo@ti.com> wrote:
> PM debug now contains a file that can be used to control OSWR support
> enable / disable on OMAP4. Also removed the off_mode_enable file for
> the same platform as it is unsupported.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/pm-debug.c | =A0 20 ++++++++++++++++----
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/mach-omap2/pm44xx.c =A0 | =A0 16 ++++++++++++++++
> =A03 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-=
debug.c
> index 814bcd9..d9a8e42 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -39,6 +39,7 @@
> =A0#include "pm.h"
>
> =A0u32 enable_off_mode;
> +static u32 enable_oswr_mode;
>
> =A0#ifdef CONFIG_DEBUG_FS
> =A0#include <linux/debugfs.h>
> @@ -247,10 +248,13 @@ static int option_set(void *data, u64 val)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_pm_enable_off_mod=
e();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_pm_disable_off_mo=
de();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap34xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_pm_off_mode_enabl=
e(val);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_pm_off_mode_enable(val);
Great since this change removes a non-init cpu_is_xxx check.

> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (option =3D=3D &enable_oswr_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_pm_oswr_mode_enable(val);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -274,8 +278,16 @@ static int __init pm_dbg_init(void)
>
> =A0 =A0 =A0 =A0pwrdm_for_each(pwrdms_setup, (void *)d);
>
> - =A0 =A0 =A0 (void) debugfs_create_file("enable_off_mode", S_IRUGO |=
 S_IWUSR, d,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
&enable_off_mode, &pm_dbg_option_fops);
> + =A0 =A0 =A0 if (cpu_is_omap34xx())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void) debugfs_create_file("enable_off_=
mode",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S_IRUGO | S_IWUSR, d, &=
enable_off_mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pm_dbg_option_fops);
Is the enable_off_mode entry needed on other OMAP platorms (OMAP<3)?

> +
> + =A0 =A0 =A0 if (cpu_is_omap44xx())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void) debugfs_create_file("enable_oswr=
_mode",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S_IRUGO | S_IWUSR, d, &=
enable_oswr_mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pm_dbg_option_fops);
> +
> =A0 =A0 =A0 =A0pm_dbg_init_done =3D 1;

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
