From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
Date: Fri, 13 Dec 2013 13:54:31 -0600
Message-ID: <20131213195431.GF5292@saruman.home>
References: <20131212214306.GS1939@saruman.home>
 <1386884755-12366-1-git-send-email-balbi@ti.com>
 <52AA54E4.5000606@ti.com>
 <230CBA6E4B6B6B418E8730AC28E6FC7E0415C786@DFLE11.ent.ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42387 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673Ab3LMTza (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 14:55:30 -0500
Content-Disposition: inline
In-Reply-To: <230CBA6E4B6B6B418E8730AC28E6FC7E0415C786@DFLE11.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kwok, WingMan" <w-kwok2@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2013 at 10:04:38AM -0600, Kwok, WingMan wrote:
> Hello
>=20
> > -----Original Message-----
> > From: Shilimkar, Santosh
> > Sent: Thursday, December 12, 2013 7:29 PM
> > To: Balbi, Felipe
> > Cc: Linux USB Mailing List; kgene.kim@samsung.com; Linux ARM Kernel
> > Mailing List; linux-samsung-soc@vger.kernel.org; Linux OMAP Mailing Lis=
t;
> > Kwok, WingMan
> > Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
> >=20
> > On Thursday 12 December 2013 04:45 PM, Felipe Balbi wrote:
> > > A bare-minimum PM implementation which will server as building block
> > > for more complex
> > s/server/serve ;-)
> > > PM implementation in the future.
> > >
> > > At the least will not leave clocks on unnecessarily when e.g.  a user
> > > write mem to /sys/power/state.
> > >
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >
> > > improve error path a little bit.
> > >
> > We will test this out. Thanks for the
> > patch Felipe.
> >=20
>=20
> I have tested the patch and the keystone usb driver continues to function,
> though I can't test suspend at this time as the rest of the system does
> not that functionality yet.

Thanks, should I add your Tested-by ?

--=20
balbi

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSq2X3AAoJEIaOsuA1yqREADAP/1jTut0bkrOALf/F8WuN6q5o
tYjjBgaFeiKhmuD0cweEk6ftROlSIggIxmEoxovcCARVjnPdb2bxpGuFlFEd+NdB
ljvU2nL8xLHvmhHhAjUegvWs1UwYO9xJb4l/Dlco//30lVm6uSKwpOgcGVYY1l2K
oASStflYavHYyPfAbg6yzNGYaZwFGs5MuAz2cDDogQWD8AJa0OZ3gZYNjwzhbePC
8P3IPfm0K6GakkSvKBHweZDFFq0Xqtv2BIV+OrYHsQLlbedySiwBqFFpiHrFA5be
yN9TiFNhFPpuPZkHic2YfLMj1GE82dSzTbrH7JYbAVoN61Q1HBxKhP5cyUNIzpUK
3nsgmyNBNTAzIBdMcLnjwRCicOJpq3MBMWOvzPJhsAL5GdS6KwoeWxDAy1kqf8RW
eY0XOfDGiGXmaUjQpmYERxNjMfZtTu95dKyMGa59U9kh5Y0B6A7ncvTJGEr0sD/F
mFh4AQrqbxL6Dbjijx3LM67qmVcqYHgf1tBy7ze8ZwNAkkjXJl98kAPHDpnDg8w/
H+gCMN/vOXQZXlWOPKQZmfKwqCDIaJMYgSFmaZFy8c6IJfTFKfDVgEnCBgU6qzgO
w0SpYQumUOspcaKP80haY6CdOsPQf2471WE07dXLZbM+1NPNmhk+sVDwQFxiqBkI
nHpOw3pghiid9V6vnNtx
=7dy4
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--
