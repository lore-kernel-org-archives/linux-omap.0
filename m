From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] usb: musb: wake the device before ulpi transfers
Date: Wed, 21 Mar 2012 17:07:50 +0200
Message-ID: <20120321150748.GP3092@arwen.pp.htv.fi>
References: <1332340552-9270-1-git-send-email-notasas@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fV3mxwFPWhsKHyX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:43755 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755064Ab2CUPIK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 11:08:10 -0400
Received: by mail-lb0-f181.google.com with SMTP id k6so977940lbo.40
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 08:08:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1332340552-9270-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>


--2fV3mxwFPWhsKHyX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2012 at 04:35:52PM +0200, Grazvydas Ignotas wrote:
> musb can be suspended at the time some other driver wants to do ulpi
> transfers using usb_phy_io_* functions, and that can cause data abort,
> as it happened with isp1704_charger:
> http://article.gmane.org/gmane.linux.kernel/1226122
>=20
> Add pm_runtime to ulpi functions to rectify this. This also adds io_dev
> to usb_phy so that pm_runtime_* functions can be used.
>=20
> Cc: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

applied, thanks

--=20
balbi

--2fV3mxwFPWhsKHyX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPae7EAAoJEIaOsuA1yqREgIAQAJbY+Imz0FnsTzzT9FZyB3Qb
y1lKyfF+mhU4spGrqb9+I06sETSIlqR95utCq7SPVrKhzJYUY/WrMQ2yJbXYOdgO
iDe3O2PPNXjZXOChZOCCWqksJT6Nj3tOeNkv8XMCsq+Mt1zVb5c6KAlonkyx333c
dA+5cI1V531+SkZ4YgThk/KgApDkW+b2RhLdvnvVzV/g5hIJKLLzESrlpHobkOK1
jyQ13FDbbl3UwEl6IMwJfFSSXY/cffckYG8JaPGzf2asvCzr0i8ZKJSt6udnDo7X
IzVzwk6EcQZHrDh5whX4e5PjaXb/83jsoQ9dEZa1KYIv7zhz3nrgfnNVQEuEpIYV
WlsRaqPTx41Jlsqtu+xONmhakB9mBuUSL8CpQHNo7ksfbeS+a7Tb/Us57HsXaqaa
uRUqqxbi3d4AYU9rFXL81twDPMFvOP9ihXX9rPN8uz41vE7Z/MBvJeU7obqkjxid
wEuYj6RlLi+eaP00TPpE31t3Iv76sWmBOMDXBXUWpP+qAR+eHMOrq+kehpVO+Wnt
QhzGpL9JG0ONjDSkOhlbYCFXqPoXgTvlhGBwxZhAG5kdFnZLDvwtuJUB4DdB/wXk
fx81XOmg2/lcYkE7NrgEAgA6jyqwwKfK/PMIEeW4xDs7iKz4+bra4vYtMoNu5/+4
So21KB+n8uHNiQ88t/0m
=nVOm
-----END PGP SIGNATURE-----

--2fV3mxwFPWhsKHyX--
