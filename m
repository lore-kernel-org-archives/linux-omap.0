From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
Date: Fri, 13 Dec 2013 14:22:40 -0600
Message-ID: <20131213202240.GK5292@saruman.home>
References: <20131212214306.GS1939@saruman.home>
 <1386884755-12366-1-git-send-email-balbi@ti.com>
 <52AA54E4.5000606@ti.com>
 <230CBA6E4B6B6B418E8730AC28E6FC7E0415C786@DFLE11.ent.ti.com>
 <20131213195431.GF5292@saruman.home>
 <230CBA6E4B6B6B418E8730AC28E6FC7E0415C84D@DFLE11.ent.ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <230CBA6E4B6B6B418E8730AC28E6FC7E0415C84D@DFLE11.ent.ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Kwok, WingMan" <w-kwok2@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2013 at 02:18:42PM -0600, Kwok, WingMan wrote:
>=20
> > -----Original Message-----
> > From: Balbi, Felipe
> > Sent: Friday, December 13, 2013 2:55 PM
> > To: Kwok, WingMan
> > Cc: Shilimkar, Santosh; Balbi, Felipe; Linux USB Mailing List;
> > kgene.kim@samsung.com; Linux ARM Kernel Mailing List; linux-samsung-
> > soc@vger.kernel.org; Linux OMAP Mailing List
> > Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
> >=20
> > On Fri, Dec 13, 2013 at 10:04:38AM -0600, Kwok, WingMan wrote:
> > > Hello
> > >
> > > > -----Original Message-----
> > > > From: Shilimkar, Santosh
> > > > Sent: Thursday, December 12, 2013 7:29 PM
> > > > To: Balbi, Felipe
> > > > Cc: Linux USB Mailing List; kgene.kim@samsung.com; Linux ARM Kernel
> > > > Mailing List; linux-samsung-soc@vger.kernel.org; Linux OMAP Mailing
> > > > List; Kwok, WingMan
> > > > Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM
> > > > support
> > > >
> > > > On Thursday 12 December 2013 04:45 PM, Felipe Balbi wrote:
> > > > > A bare-minimum PM implementation which will server as building
> > > > > block for more complex
> > > > s/server/serve ;-)
> > > > > PM implementation in the future.
> > > > >
> > > > > At the least will not leave clocks on unnecessarily when e.g.  a
> > > > > user write mem to /sys/power/state.
> > > > >
> > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > > ---
> > > > >
> > > > > improve error path a little bit.
> > > > >
> > > > We will test this out. Thanks for the patch Felipe.
> > > >
> > >
> > > I have tested the patch and the keystone usb driver continues to
> > > function, though I can't test suspend at this time as the rest of the
> > > system does not that functionality yet.
> >=20
> > Thanks, should I add your Tested-by ?
>=20
> Yes please.

you need to reply with Tested-by: Your Name <your.email@domain.com> just
to make it all official. Sorry

--=20
balbi

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSq2yQAAoJEIaOsuA1yqREEzIP/3swrNy/QvdqqO1ReEJWy8UI
fjYY145DzNmFUjjJ3iWTxTsYEnaDS12Y4fxDxPToIxZnOI2V1kT7ohgk2dJTWi8d
CqqFGsaxdMcvGNhImxUZxqvBXQUvwZO/+MVcG/uZcUmIhOcLwFeEOkUEcSdpDEoY
5oosERi1viRtY60/4dEvQPoA7wXPN4KjFfakO8fG2zdQl1Aa/xYPO1JSiQYUnwDo
kizowxikejceXdbBiIy8zhcvjZqtUYCpXSNAb3R6gHr0nP8xVqkaRC3L7Z6ciiEd
sgBxL4YIKwBeHpbEBDWrUWCl7gVU7JmuR97Ez+wF8w4U5UapoDbIJJENrtOdkmGy
P1enUOFEWJqOF9yTewveskAidPRgcMzLmtt4m+FKFhBjBE7yCvRHwkQ8sRdI6Cqo
nBaOqwNAyfCo+AObJuQmuobd8U9ytzQ2EvCLvA5tTzySfsZarHFqKkNMciTpkPht
+Nm+Ul1N9cJc7R57O0oqGdqxWsvDJ+rl/LjqpPVpDAqyXZBSciVrdTotpxk/9PkJ
6A4flz1Jz42AdZyRMO8jwlazvQNzDTjfPvkBNkeo7Xq3vzMjeWq84uK9woiHO8wB
/U3cJFHAlpyW3Y5wcRZKHKFU6iglcFZT6Xn1FpcjO7rKHxcNd2c6ePXRdafw9dpj
BSRJ8Hnrge/lfd+pAMLR
=M4aF
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--
