From: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCHv2] ARM: OMAP2+: Add support for thumb mode on DT booted N900
Date: Sat, 1 Mar 2014 22:32:50 +0100
Message-ID: <CAHYPw2E6hrz7zb1G8WzWV5rc2KrTkz0HK_HxfdoC2MQ+k5Eaxg@mail.gmail.com>
References: <1391603582-11371-1-git-send-email-sre@debian.org> <1392672658-13866-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:37136 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbaCAVdb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Mar 2014 16:33:31 -0500
In-Reply-To: <1392672658-13866-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

2014-02-17 22:30 GMT+01:00 Sebastian Reichel <sre@debian.org>:
> Without enabling the workaround for ARM errata 430973 thumb
> compiled userland crashes randomly on the Nokia N900.
>
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> Reviewed-by: Pavel Machek <pavel@ucw.cz>
> ---
> Hi,
>
> This is PATCHv2 for the thumb errata workaround for N900 DT
> boot, which should go into 3.14-rc.
>
> Changes since PATCHv1:
>  * Add Reviewed-By: Pavel Machek
>  * Add more verbose warning about the errata as suggested by Pavel
>
> I did not increase the verbose level, since the next higher verbose
> level is pr_err and the message is not an error.
>
> I think it would make sense to update the Kconfig entry for the errat=
a to
> enable the workaround by default for the Nokia N900. That should be d=
one in
> its own patch, though.
>
> Apart from that it would be nice if errata workaround could be enable=
d
> via DeviceTree instead of kernel configuration. This will require som=
e
> discussion though, so I think we should start with this patch for now=
=2E
>
> -- Sebastian
> ---
>  arch/arm/mach-omap2/pdata-quirks.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2=
/pdata-quirks.c
> index 3d5b24d..0cc710d 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -22,6 +22,8 @@
>  #include "common-board-devices.h"
>  #include "dss-common.h"
>  #include "control.h"
> +#include "omap-secure.h"
> +#include "soc.h"
>
>  struct pdata_init {
>         const char *compatible;
> @@ -169,6 +171,22 @@ static void __init am3517_evm_legacy_init(void)
>         omap_ctrl_writel(v, AM35XX_CONTROL_IP_SW_RESET);
>         omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET); /* OCP barrier *=
/
>  }
> +
> +static void __init nokia_n900_legacy_init(void)
> +{
> +       hsmmc2_internal_input_clk();
> +
> +       if (omap_type() =3D=3D OMAP2_DEVICE_TYPE_SEC) {
> +               if (IS_ENABLED(CONFIG_ARM_ERRATA_430973)) {
> +                       pr_info("RX-51: Enabling ARM errata 430973 wo=
rkaround\n");
> +                       /* set IBE to 1 */
> +                       rx51_secure_update_aux_cr(BIT(6), 0);
> +               } else {
> +                       pr_warning("RX-51: Not enabling ARM errata 43=
0973 workaround\n");
> +                       pr_warning("Thumb binaries may crash randomly=
 without this workaround\n");
> +               }
> +       }
> +}
>  #endif /* CONFIG_ARCH_OMAP3 */
>
>  #ifdef CONFIG_ARCH_OMAP4
> @@ -259,7 +277,7 @@ struct of_dev_auxdata omap_auxdata_lookup[] __ini=
tdata =3D {
>  static struct pdata_init pdata_quirks[] __initdata =3D {
>  #ifdef CONFIG_ARCH_OMAP3
>         { "compulab,omap3-sbc-t3730", omap3_sbc_t3730_legacy_init, },
> -       { "nokia,omap3-n900", hsmmc2_internal_input_clk, },
> +       { "nokia,omap3-n900", nokia_n900_legacy_init, },
>         { "nokia,omap3-n9", hsmmc2_internal_input_clk, },
>         { "nokia,omap3-n950", hsmmc2_internal_input_clk, },
>         { "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
> --
> 1.8.5.3
>

Hello,

now when this patch was accepted and there is secure code for rx51,
what about adding hwrng secure code?
Non DT version is here:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Dd2065e2b5bb3ec986f0f3ba044a81a136767d0b4
I think it could be simple to register needed driver when omap type is
OMAP2_DEVICE_TYPE_SEC.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
