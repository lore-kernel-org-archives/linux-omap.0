From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC 3/4] omap: attach external controller to VDD1/VDD2
Date: Fri, 8 Jul 2011 19:23:33 +0300
Message-ID: <20110708162332.GD31978@legolas.emea.dhcp.ti.com>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
 <1310140588-26078-4-git-send-email-t-kristo@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:37257 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750764Ab1GHQXh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 12:23:37 -0400
Received: by mail-bw0-f43.google.com with SMTP id 7so2132094bwd.30
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 09:23:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310140588-26078-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 08, 2011 at 06:56:27PM +0300, Tero Kristo wrote:
> Instiante a twlreg_ext_ctrl structure in the OMAP voltage code for
> VDD1 and VDD2 and attach it as an external controller for these
> regulators. It will allow the OMAP voltage code to take over the
> default regulator driver code for ->set_voltage() and ->get_voltage().
>=20
> TODO:
>=20
>  * Does this really belong to the OMAP voltage code ? The PowerIC
>    attached to the OMAP may not be the traditional TWL, so maybe this
>    code belongs to a more board-specific location (but then we have
>    the question of avoiding too much duplication of this code
>    throughout the different board files)
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.c                 |   37 +++++++++++++++++++=
++++++
>  arch/arm/mach-omap2/voltage.h                 |    4 +++
>  arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +
>  3 files changed, 43 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 9ef3789..e9b9bbb 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -59,6 +59,9 @@ static struct dentry *voltage_dir;
>  /* Init function pointers */
>  static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
>  					unsigned long target_volt);
> +static int omap_twlreg_ext_ctrl_get_voltage(struct twlreg_ext_ctrl *ext_=
ctrl);
> +static int omap_twlreg_ext_ctrl_set_voltage(struct twlreg_ext_ctrl *ext_=
ctrl,
> +					    int min_uV, int max_uV);
> =20
>  static u32 omap3_voltage_read_reg(u16 mod, u8 offset)
>  {
> @@ -1029,6 +1032,19 @@ void omap_change_voltscale_method(struct voltagedo=
main *voltdm,
>  	}
>  }
> =20
> +static int omap_twlreg_ext_ctrl_get_voltage(struct twlreg_ext_ctrl *ext_=
ctrl)
> +{
> +	struct voltagedomain *voltdm =3D (struct voltagedomain *) ext_ctrl->dat=
a;
> +	return omap_vp_get_curr_volt(voltdm);
> +}
> +
> +static int omap_twlreg_ext_ctrl_set_voltage(struct twlreg_ext_ctrl *ext_=
ctrl,
> +					    int min_uV, int max_uV)
> +{
> +	struct voltagedomain *voltdm =3D (struct voltagedomain *) ext_ctrl->dat=
a;
> +	return omap_voltage_scale_vdd(voltdm, min_uV);
> +}
> +
>  /**
>   * omap_voltage_domain_lookup() - API to get the voltage domain pointer
>   * @name:	Name of the voltage domain
> @@ -1071,6 +1087,8 @@ struct voltagedomain *omap_voltage_domain_lookup(ch=
ar *name)
>  int __init omap_voltage_late_init(void)
>  {
>  	int i;
> +	struct twlreg_ext_ctrl *ctrl;
> +	struct voltagedomain *voltdm;
> =20
>  	if (!vdd_info) {
>  		pr_err("%s: Voltage driver support not added\n",
> @@ -1088,6 +1106,25 @@ int __init omap_voltage_late_init(void)
>  		omap_vc_init(vdd_info[i]);
>  		vp_init(vdd_info[i]);
>  		vdd_debugfs_init(vdd_info[i]);
> +
> +		voltdm =3D &vdd_info[i]->voltdm;
> +		/* Attach twlreg external controller */
> +		if (voltdm->reg_name) {
> +			ctrl =3D kmalloc(sizeof(struct twlreg_ext_ctrl),
> +				GFP_KERNEL);
> +			if (!ctrl) {
> +				pr_err("%s: can't alloc twlreg_ext_ctrl for"
> +				       " vdd_%s\n", __func__, voltdm->name);
> +				return -ENOMEM;
> +			}
> +			ctrl->set_voltage =3D omap_twlreg_ext_ctrl_set_voltage;
> +			ctrl->get_voltage =3D omap_twlreg_ext_ctrl_get_voltage;
> +			ctrl->data =3D voltdm;
> +
> +			twlreg_attach_external_controller(voltdm->reg_name,
> +				ctrl);
> +			voltdm->twl_ext_ctrl =3D ctrl;
> +		}
>  	}
> =20
>  	return 0;
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index e9f5408..1fb1d85 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -15,6 +15,7 @@
>  #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
> =20
>  #include <linux/err.h>
> +#include <linux/regulator/twl.h>
> =20
>  #include "vc.h"
>  #include "vp.h"
> @@ -52,9 +53,12 @@ struct omap_vfsm_instance_data {
>   * struct voltagedomain - omap voltage domain global structure.
>   * @name:	Name of the voltage domain which can be used as a unique
>   *		identifier.

missed reg_name

--=20
balbi

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOFy8EAAoJEAv8Txj19kN1gU0H/jdBh7mMSewif9Vqxnrhr39O
+i7Llr3+WazdMfLKAfi1TZx/phVgrE6oNDYwDEc+Wp1WNp630mTwRCx5BrYu3uTm
YCDKwbI6eErzD4zneCXKy3mNW9evfqwHzm42u0Ux7n0ty6I+LqlO6CmB6dDxgwWC
Yph1PpnP10l+4Q4vzwEVwbBauFpEGQFApi3JyCHhII49PBRIdwv3GPNuAzi2JAFd
d0W/9lWSgY/MJEskXf763q1qvb4dv7HXdaLrjiDWSJTtvYmFUrrUyY/vBwHpyXqD
DaFLoJLwC6urhzrYb7qn4ASwrRz/mtMg0VFrqiujU+6SEZKSLPf/uj4SfAo4Se4=
=d6XH
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
