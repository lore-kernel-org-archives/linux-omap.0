From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] usb: musb: am35x: use SIMPLE_DEV_PM_OPS
Date: Wed, 25 Sep 2013 08:48:11 -0500
Message-ID: <20130925134811.GH10746@radagast>
References: <1379850421-7966-1-git-send-email-zonque@gmail.com>
 <20130923212009.GK309@radagast>
 <524137C4.1000104@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhtSGe8h3+lMyY1M"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45243 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755672Ab3IYNsU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Sep 2013 09:48:20 -0400
Content-Disposition: inline
In-Reply-To: <524137C4.1000104@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: balbi@ti.com, linux-ubs@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org

--zhtSGe8h3+lMyY1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2013 at 08:57:08AM +0200, Daniel Mack wrote:
> On 23.09.2013 23:20, Felipe Balbi wrote:
> > On Sun, Sep 22, 2013 at 01:46:58PM +0200, Daniel Mack wrote:
>=20
> >> -static struct dev_pm_ops am35x_pm_ops =3D {
> >> -	.suspend	=3D am35x_suspend,
> >> -	.resume		=3D am35x_resume,
> >> -};
> >> +static SIMPLE_DEV_PM_OPS(am35x_pm_ops, am35x_suspend, am35x_resume);
> >=20
> > you could as well remove the DEV_PM_OPS trickery. Ditto for all other
> > patches
>=20
> Yes, I noticed that too. That's why I sent out a v2 of the series :)

Awesome :-) Thanks dude

--=20
balbi

--zhtSGe8h3+lMyY1M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSQumbAAoJEIaOsuA1yqRE72QP/RhvI7AxDJhxN3Cq8I+tlHQj
EFswcvlDlkc0aIJHVZZCOWP5Q0ScRxuRV/fc3hdIOSwxv+IDWO5HPc/dKGQdRhMP
ib4+pDGW+RJ30lrGZq9FiW3HrQeWrWsPbYrO5YvAqE70DmxetLyQTL5LsvSRiDZE
DYwzk9mOT2gpZDC4MV7MQG4V6Y5GrNPwjgU8GAIPLPWbI5kYoPql/DkKa/l0brrB
GwPJ9BVFEVZfaGJq2CmqcrxIKWDeUJYa9xRDZdH22phNDXwkGSQd0hX3J+nDbqDX
MLuItLoL+W1KtUk4ZZg3yWINWwTcBsMOkprk4igezB1oXTaROnTD9fRTPVsLl8wo
JDoqHJhRMJDWKVkiCnbrowDyaZz595ImuA+tOIs/tME9bkp0wnpsl1F4GxhA6Jb9
G0xJrHGogZwQjV9IV53SvcYdF9kMFqRk8dqVQxhplrxrWoU0P4pUi9iDqRyoAGLl
U+WXg1cctQ7nDrL7DNotuKfiStqRp+iJykl/T6DBtw/oUTiPEk45MF8lrr7UNzec
dcwGI16iQOS4tAnRmmanCuf7D6RqIaYQF8UmypR5XxAwacG0uRY6wOt32M3s2NZU
yZbHF4EBZdeKQx65fStZD20+/SM17yMAZoUfUk0mBGDl1rYh1aYJ2TTvKYrtAtmc
3DCawzzsOamVVkyVXl8p
=nJg5
-----END PGP SIGNATURE-----

--zhtSGe8h3+lMyY1M--
