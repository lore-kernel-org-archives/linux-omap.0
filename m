From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Fix section mismatch warning.
Date: Thu, 20 Nov 2008 18:14:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C6E5@dbde02.ent.ti.com>
References: <1227102749-19536-1-git-send-email-premi@ti.com>
 <200811191626.02717.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35104 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878AbYKTMpI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 07:45:08 -0500
In-Reply-To: <200811191626.02717.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]=20
> Sent: Thursday, November 20, 2008 5:56 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] Fix section mismatch warning.
>=20
> I know that Beagle and Overo get the same warnings, so this=20
> isn't really a sufficient fix...

Was trying to fix for EVM. Can extend to these boards once we have a fi=
x.

>=20
> On Wednesday 19 November 2008, Sanjeev Premi wrote:
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -130,7 +130,7 @@ static struct twl4030_madc_platform_data=20
> > omap3evm_madc_data =3D {
> > =A0=A0=A0=A0=A0=A0=A0=A0.irq_line=A0=A0=A0=A0=A0=A0=A0=3D 1,
> > =A0};
> > =A0
> > -static struct twl4030_platform_data omap3evm_twldata =3D {
> > +static struct twl4030_platform_data __initdata omap3evm_twldata =3D=
 {
>=20
> ... and that's incorrect in any case, since that data is used=20
> by probe() code that's doesn't sit in an init section.

=46unction probe() would be in __devinit. Changing __initdata to __devi=
nit
would be fine for compilation. Do you see any issues with it?

BTW, I could not locate the definition of platform_driver for twl4030
to verify if probe() is indeed in __devinit.

> I have the following in my patchset, currently disabled since=20
> it conflicts with other patches.  And in any case, Beagle=20
> can't reboot with these "generic" scripts for some TBD reason.
>=20
> - Dave
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CUT HERE
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c       |    2 +-
>  arch/arm/mach-omap2/board-omap3evm.c          |    2 +-
>  arch/arm/mach-omap2/board-overo.c             |    2 +-
>  arch/arm/mach-omap2/twl4030-generic-scripts.c |    3 +++
>  arch/arm/mach-omap2/twl4030-generic-scripts.h |    5 +++++
>  5 files changed, 11 insertions(+), 3 deletions(-)
>=20
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -188,7 +188,7 @@ static struct twl4030_platform_data beag
>  	/* platform_data for children goes here */
>  	.usb		=3D &beagle_usb_data,
>  	.gpio		=3D &beagle_gpio_data,
> -	.power		=3D &generic3430_t2scripts_data,
> +	.power		=3D GENERIC3430_T2SCRIPTS_DATA,
>  };
> =20
>  static struct i2c_board_info __initdata beagle_i2c_boardinfo[] =3D {
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -140,7 +140,7 @@ static struct twl4030_platform_data omap
>  	.keypad		=3D &omap3evm_kp_data,
>  	.madc		=3D &omap3evm_madc_data,
>  	.usb		=3D &omap3evm_usb_data,
> -	.power		=3D &generic3430_t2scripts_data,
> +	.power		=3D GENERIC3430_T2SCRIPTS_DATA,
>  	.gpio		=3D &omap3evm_gpio_data,
>  };
> =20
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -162,7 +162,7 @@ static struct twl4030_platform_data over
>  	.irq_end	=3D TWL4030_IRQ_END,
>  	.gpio		=3D &overo_gpio_data,
>  	.usb		=3D &overo_usb_data,
> -	.power		=3D &generic3430_t2scripts_data,
> +	.power		=3D GENERIC3430_T2SCRIPTS_DATA,
>  };
> =20
>  static struct i2c_board_info __initdata overo_i2c_boardinfo[] =3D {
> --- a/arch/arm/mach-omap2/twl4030-generic-scripts.c
> +++ b/arch/arm/mach-omap2/twl4030-generic-scripts.c
> @@ -23,6 +23,8 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =20
> 02111-1307  USA
>   */
> =20
> +#ifdef CONFIG_TWL4030_POWER
> +
>  #include <linux/kernel.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> @@ -76,3 +78,4 @@ struct twl4030_power_data generic3430_t2  };
> =20
> =20
> +#endif /* CONFIG_TWL4030_POWER */
> --- a/arch/arm/mach-omap2/twl4030-generic-scripts.h
> +++ b/arch/arm/mach-omap2/twl4030-generic-scripts.h
> @@ -3,6 +3,11 @@
> =20
>  #include <linux/i2c/twl4030.h>
> =20
> +#ifdef CONFIG_TWL4030_POWER
>  extern struct twl4030_power_data generic3430_t2scripts_data;
> +#define GENERIC3430_T2SCRIPTS_DATA &generic3430_t2scripts_data #else=
=20
> +#define GENERIC3430_T2SCRIPTS_DATA NULL #endif /*=20
> CONFIG_TWL4030_POWER=20
> +*/
> =20
>  #endif
>=20
>=20
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
