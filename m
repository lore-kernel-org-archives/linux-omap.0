From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: twl-common: Fix compiler warning
Date: Wed, 20 Jun 2012 07:25:16 -0700
Message-ID: <20120620142515.GQ12766@atomide.com>
References: <1339767234-25323-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63596 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756428Ab2FTOZR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 10:25:17 -0400
Content-Disposition: inline
In-Reply-To: <1339767234-25323-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120615 06:38]:
> If the kernel is built only for OMAP2 the following warning will show=
 up:
>=20
> arch/arm/mach-omap2/twl-common.c:52: warning: =E2=80=98twl_set_voltag=
e=E2=80=99 defined but not used
> arch/arm/mach-omap2/twl-common.c:58: warning: =E2=80=98twl_get_voltag=
e=E2=80=99 defined but not used
>=20
> The twl_set/get_voltage callbacks only used when OMAP3/4 is selected.

Thanks applying into fixes.

Tony

>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/twl-common.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/t=
wl-common.c
> index 119d5a9..5447c13 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -48,6 +48,7 @@ static struct i2c_board_info __initdata omap4_i2c1_=
board_info[] =3D {
>  	},
>  };
> =20
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>  static int twl_set_voltage(void *data, int target_uV)
>  {
>  	struct voltagedomain *voltdm =3D (struct voltagedomain *)data;
> @@ -59,6 +60,7 @@ static int twl_get_voltage(void *data)
>  	struct voltagedomain *voltdm =3D (struct voltagedomain *)data;
>  	return voltdm_get_voltage(voltdm);
>  }
> +#endif
> =20
>  void __init omap_pmic_init(int bus, u32 clkrate,
>  			   const char *pmic_type, int pmic_irq,
> --=20
> 1.7.8.6
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
