From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for
 automode
Date: Mon, 20 Jan 2014 12:24:34 +0100
Message-ID: <20140120112434.GA3225@earth.universe>
References: <1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
 <CAOf5uwkrep0PhOn67+9PHmP2A2Jxrp9DNK3BRp9D_sYu_PYvvw@mail.gmail.com>
 <201311242001.23126@pali>
 <CAOf5uw=-cy2QoDxjecxYTYsrQRD=LtN0N7DcYJHZ6HSbexzPRw@mail.gmail.com>
 <20131201223730.GD6271@lizard>
 <CAOf5uwnkQwkS7_fsLtC5nzdXyS1Rzw2SkxaziUuJrO9SKXh3yw@mail.gmail.com>
 <20131202002444.GA22418@teo>
 <CAOf5uwnz6SfeEsbGq62QFgRHJ2ys++VV1+VrULxyR4uH2Z_vJQ@mail.gmail.com>
 <20140119205402.GA24185@earth.universe>
 <20140120102129.GO27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140120102129.GO27282@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Anton Vorontsov <anton@enomsg.org>, Michael Trimarchi <michael@amarulasolutions.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2014 at 10:21:29AM +0000, Russell King - ARM Linux wrote:
> And another one using that evil mail-followup-to header:
>=20
> Mail-Followup-To: Pali Roh=E1r <pali.rohar@gmail.com>,
>         Anton Vorontsov <anton@enomsg.org>,
>         Michael Trimarchi <michael@amarulasolutions.com>,
>         David Woodhouse <dwmw2@infradead.org>,
>         Tony Lindgren <tony@atomide.com>,
>         Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.o=
rg,
>         Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
>         freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
>=20
> which results in all the above being moved into the To: header by
> unsuspecting recipients who reply to your message.

Thanks for the hint. Should be fixed now.

-- Sebastian

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJS3QdyAAoJENju1/PIO/qaQtYQAJdbVMdRzkY3Rsn0FdQANKoF
mqml3w5T3SsZ6sU2zE7UbhSETkONOYqp3rn3TcApUecOZiaERjrQCtYoMqhU+HVQ
t0jY/ucXH4cyGZw0nrm9OhnnB+Itx1qyMPD6KrAq1EYMNG9wv18XF97UrI1oRT74
jb2QJDGKcMpmDTJk+1vAHDa6vvnSxKXklMZiU/aBXZTdQmoWGMeFzU4i/JRZod8M
sdjl0YHAtktwFcoD2FzxVIhVvPzQL8bk4axF89zoq6OAOf0ZCpaAcUVtUXOmX5vB
LPpxnY+xbvmxvK8ldrXrnorAYGIiwNpuU6K1CKW6mVBb73BSTOMH6kL0vYBp8yxL
kkXYB5JKwHmbM+AG+wsdPJ4e0SMOW4u7zVfjijp3lJ2SU1PMYPM+sl6kMmfsSqY8
UJweEUkp3AzFmbiQ0iR1ycM3LmMWIWH2FXLjo25tlKJSToAsMojiVLWna1iyuLYs
607wyI/WKGsCDozSWeP3dnTFTGSItAGfXbFLFURHJCZHKIaGyfNkDsGY5Sp0/0+c
F/ZGNuZT64cmfjIYI7e6a8jn9xphsXIRyMNHyo6p3ynwwlg3uhj5JD8Og6QSQekB
YRVOAPC8m66viXuyktIYfQGXXSVDcalJsACgBOfcRoXrawHjpRx+cohhnaNW0QC2
DgTsWk6bx6523ztF9UNv
=Oc7n
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
