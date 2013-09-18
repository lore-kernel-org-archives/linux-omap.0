From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
Date: Wed, 18 Sep 2013 11:48:17 -0500
Message-ID: <20130918164816.GN21559@radagast>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309181756.12782@pali> <20130918163649.GL21559@radagast>
 <201309181843.49850@pali>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4678280924000755647=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201309181843.49850@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, linux-usb@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Vorontsov <anton@enomsg.org>, Linux Kernel <linux-kernel@vger.kernel.org>, balbi@ti.com, freemangordon@abv.bg, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============4678280924000755647==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8MZM6zh5Bb05FW+3"
Content-Disposition: inline

--8MZM6zh5Bb05FW+3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2013 at 06:43:49PM +0200, Pali Roh=E1r wrote:
> On Wednesday 18 September 2013 18:36:49 Felipe Balbi wrote:
> > On Wed, Sep 18, 2013 at 05:56:12PM +0200, Pali Roh=E1r wrote:
> > > On Wednesday 18 September 2013 15:57:13 Javier Martinez
> > > Canillas
> > >=20
> > > wrote:
> > > > to split the patch in two since the patch was solving
> > > > two separate issues
> > >=20
> > > My patch does not solving *two* issues. It is *one*
> > > regression and both parts of patch are needed for fixing
> > > it. Read commit message again. It does not make sense to
> > > split patch fixing kernel regression into more one line
> > > patches - or please clarify why.
> >=20
> > issue 1) twl4030-usb.c doesn't initialize atomic notifier head
> > issue 2) musb doesn't call notifier chain
> >=20
> > do you need a drawing ?
>=20
> Regression 1) power supply drivers not working since v3.5
>=20
> Look at firsts emails.
>=20
>=20
> Do you really have problem to do what *you* need with 1 line=20
> patch which I sent? Or what what you want?

if you had already resent patches the way I requested, they'd already be
applied. Instead you chose to troll the people who are trying to helping
out.

You have two issues being fixed in the same patch and that's not
acceptable.

--=20
balbi

--8MZM6zh5Bb05FW+3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSOdlQAAoJEIaOsuA1yqREBoYP/jr6CZf3RUxBSdKk6C7PYJ1m
p9dlSJNRmxSJnKePIZotLIXIHR3xz/Ut7omIv+9h2aUrKUQ571ljAR6IEmHG+KCz
D1ZJSMEC8OU/1Mx8Xdr3RgGS2NqeEbv6WjmRHHRjg5y1XLuTpmMK0kNnhgLSvGfK
WA/2CIeS1nSPpS2HRPW0RPOuSOaXWkq+ZIrCQDZezyLX+ev2k+b0vv0PvH6jhlVP
hdPSQm8ZOxb1Q22mEtddLZYBVtEWoeJhCp/NludJjkHdYk2BIM7801p6Qy331BIG
SodctAb/pGm+RfePzoygUVv4eenSRKPFEG8/xq3q+n2jTLMuJ4hq2tfMnppafxdh
lGxbfAoj6vuNhSO1vEeLzADVlneldBjQkIsnlOcSe7BtBECIZvQ2MkklhY7P6RzY
RsBFQy+EvlfVgUajQm6Asiz5jkC+u3eZE3uKv8oMdWz0ugrTTeDijwH9Bze4zJ0s
h/CdtF5GfTKMp3aozbXxc5Kxvtq9oq9Hfe7V9IXrJnUTmpfU2Vcqhl1E0ekhc9e/
1sVePt+7wr5cHcXCrZkexJhnqIUZaAgASTPNXupCBk9FXisoEaME6jnHYSBSukMJ
9c3QMhaCnXkOja10ktPaRs87xEktwVfNDOkv3TYCcrxFlEgxbvKYIRO1FjY6NVYg
lcUHY5ZohMxuOB2C3NEZ
=xsEM
-----END PGP SIGNATURE-----

--8MZM6zh5Bb05FW+3--


--===============4678280924000755647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4678280924000755647==--
