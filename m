From: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Add support for thumb mode on DT booted N900
Date: Wed, 5 Feb 2014 14:12:56 +0100
Message-ID: <CAHYPw2Ep9VP6Tem979ewcztdxkHkG8eR_U31U=f5ibsVa5AS4Q@mail.gmail.com>
References: <1391603582-11371-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391603582-11371-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org

2014-02-05 Sebastian Reichel <sre@debian.org>:
> Without enabling the workaround for ARM errata 430973 thumb
> compiled userland crashes randomly on the Nokia N900.
>
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> ---
> Hi Tony,
>
> I think this patch should be added into some fix branch for 3.14-rcX.
>
> -- Sebastian
> ---
>  arch/arm/mach-omap2/pdata-quirks.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2=
/pdata-quirks.c
> index 3d5b24d..7929df3 100644
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
> @@ -169,6 +171,21 @@ static void __init am3517_evm_legacy_init(void)
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
> +               }
> +       }
> +}
>  #endif /* CONFIG_ARCH_OMAP3 */
>
>  #ifdef CONFIG_ARCH_OMAP4
> @@ -259,7 +276,7 @@ struct of_dev_auxdata omap_auxdata_lookup[] __ini=
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

I have two questions:

1) Why are you using if (IS_ENABLED(CONFIG_ARM_ERRATA_430973)) instead =
#ifdef ?
2) Why do you not write warning or info when omap type is not
OMAP2_DEVICE_TYPE_SEC (e.g qemu) ?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
