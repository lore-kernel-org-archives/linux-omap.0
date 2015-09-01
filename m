From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap2: vc: fix 'or' always true warning
Date: Tue, 1 Sep 2015 08:46:09 -0700
Message-ID: <20150901154609.GK4215@atomide.com>
References: <DUB128-W519E183FDD98EF80BD4CB79C6E0@phx.gbl>
 <1440756632-14043-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440756632-14043-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: Frans Klaver <fransklaver@gmail.com>, Russell King <linux@arm.linux.org.uk>, David Binderman <dcb314@hotmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Frans Klaver <frans.klaver@xsens.com> [150828 03:14]:
> From: Frans Klaver <fransklaver@gmail.com>
>=20
> Fix the warning:
> arch/arm/mach-omap2/vc.c:302:47: warning: logical =E2=80=98or=E2=80=99=
 of collectively exhaustive tests is always true [-Wlogical-op]
>=20
> As we're toggling both CLKREQ and OFFMODE, we should also be checking
> OFFMODE.
>=20
> Signed-off-by: Frans Klaver <fransklaver@gmail.com>

Thanks apppying into omap-for-v4.3/fixes.

Tony

> ---
>  arch/arm/mach-omap2/vc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 076fd20d7e5a..807bc79e3e3d 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -300,7 +300,7 @@ static void __init omap3_vc_init_pmic_signaling(s=
truct voltagedomain *voltdm)
> =20
>  	val =3D voltdm->read(OMAP3_PRM_POLCTRL_OFFSET);
>  	if (!(val & OMAP3430_PRM_POLCTRL_CLKREQ_POL) ||
> -	    (val & OMAP3430_PRM_POLCTRL_CLKREQ_POL)) {
> +	    (val & OMAP3430_PRM_POLCTRL_OFFMODE_POL)) {
>  		val |=3D OMAP3430_PRM_POLCTRL_CLKREQ_POL;
>  		val &=3D ~OMAP3430_PRM_POLCTRL_OFFMODE_POL;
>  		pr_debug("PM: fixing sys_clkreq and sys_off_mode polarity to 0x%x\=
n",
> --=20
> 2.3.4
>=20
