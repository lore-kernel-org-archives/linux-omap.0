From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: dsps fix the typo in reg-names of the dma
 node
Date: Fri, 20 Sep 2013 10:43:12 -0500
Message-ID: <20130920154312.GU26101@radagast>
References: <1376501399-27295-1-git-send-email-bigeasy@linutronix.de>
 <1376501399-27295-3-git-send-email-bigeasy@linutronix.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G9m07da55tKJni3T"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376501399-27295-3-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benoit Cousson <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--G9m07da55tKJni3T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

adding Benoit Cousson and linux-omap

On Wed, Aug 14, 2013 at 07:29:59PM +0200, Sebastian Andrzej Siewior wrote:
> I forgot to separete the different names in the reg-names property. This
> didn't cause anything to fail because the driver does not use the names
> and simply relies on the order of the memory offsets in reg.
> This patch fixes this in case it is used later.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

Benoit, hope you can take this patch in the -rc cycle.

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  arch/arm/boot/dts/am33xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 24d6309..a38f8d3 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -470,7 +470,7 @@
>  					0x47402000 0x1000
>  					0x47403000 0x1000
>  					0x47404000 0x4000>;
> -				reg-names =3D "glue controller scheduler queuemgr";
> +				reg-names =3D "glue", "controller", "scheduler", "queuemgr";
>  				interrupts =3D <17>;
>  				interrupt-names =3D "glue";
>  				#dma-cells =3D <2>;
> --=20
> 1.8.4.rc1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--G9m07da55tKJni3T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSPG0PAAoJEIaOsuA1yqREkKYP/1f4hajLBbck36wVaL6q+o1G
ZpZdXqnNL/S4WuX/xopXoJS2xDm6LUguM0fiZASRpvhzoORiybJ0mCAtNsJGw40H
wa44sMSHHpZiORk2dJQzv66DmwjDQVrp495BlkOzY7zrWQB8h1ALxpX9KCvq5vPh
yxfXlZ+OeUHOBxuvq9Vlh5BUplRvFssLaEoJJYM+NItPXNZtmPyZu5XE5QQ3pmmc
RUci2NGKffLP7x5dkfHIN+ogHAXArZT/BJo4cGW76eXwKS+zERXs0GWITim2eygV
1wltdKHcL3jlrd5IR14WqOn9U4EhGC5QrKfXmwk4fnHIyNKGR0x6yBh7F2Qcm/hJ
QfeRhKM7UErki7R/eOo78W9uadTCUMjT7vZ1lghJEK/yLQPbKYYJUAcggOvJK4ME
G4VzVMXCm4kAg4BGio8YwyGosFTzmEokS9gg4WEg/DNvozlvWu54sDzlQ7hmAoRc
y7ZKPIdHytZemCmEeCdMxom2N0+iLPYPrflTJlovQgVf46LIJ7r205M1GQ07rBBF
F0/VXCLr1ESOYSTztUp8RradpZ/2hfce/AD7vXzsAZLxcWzHlVMqQp+5B1O0bxxL
n+DEFk3/TUfK112md1m5m2vJ026QkkWWR2dOJeZwLgOVXzqjI2YNZA3HA1ZabeJX
UYQjA3sEBeEPnHqtKs3S
=iAAe
-----END PGP SIGNATURE-----

--G9m07da55tKJni3T--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
