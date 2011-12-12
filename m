From: Felipe Balbi <balbi@ti.com>
Subject: Re: Interrupt issue in twl4030_keypad
Date: Mon, 12 Dec 2011 21:12:45 +0200
Message-ID: <20111212191241.GC3408@legolas.emea.dhcp.ti.com>
References: <CAMP44s2xhZaoM4KVT0jC5RpdW7Ezp9YAHMG1pC+30Bbqjno7jg@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMP44s2xhZaoM4KVT0jC5RpdW7Ezp9YAHMG1pC+30Bbqjno7jg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, stable@kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 12, 2011 at 08:30:49PM +0200, Felipe Contreras wrote:
> The short version is this: either we revert this patch[1], or we apply
> this patch series[2], as well as its essential fixes[3].
>=20
> The long version is this. There's a synchronization issue with the
> current keypad driver and twl core; the irq is marked as handled even
> though the thread that is supposed to handle it hasn't run yet, and
> since it's clear-on-read, and it hasn't been read, it's detected
> again, so they keypad driver receives two interrupt callbacks instead
> of one, and in the second one reads nothing from the i2c register, so
> a key release is assumed. This makes key-presses as simple as shift+a
> impossible.
>=20
> In other words, it's totally unreliable. This might not be isolated to
> the keypard driver, but other "nested" interrupts from twl core that
> started using request_threaded_irq prematurely (before it was
> supported by the twl core). But at least I haven't tried those.
>=20
> This patch was applied on 2.6.33, which means all versions before 3.2
> are affected, including 3.1.
>=20
> What do you think about fixing this on stable kernels?

I believe Samuel has already applied those to the MFD tree. The funny
part is that those patches were pending on linux-omap for over 2 months
I have refreshed them over and over again and asked for help from other
people to test.

Everything went smooth on my simple beagle board with no keypad and I
couldn't see any issues, unfortunately. Still, 2 months is a whole lot
of time to NAK a patch, but nobody said anything so, of course, Samuel
assumed it was ok and, like I said above, it worked for my simple GPIO
usecase with beagleboard.

Oh well, it won't change anything now, Sam has applied Neil's fixes.

--=20
balbi

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO5lIpAAoJEIaOsuA1yqRETEcP/193wzvUwV4onAgbOC6ENutI
y5ra2LgtzJqScyDl+hDPwjCUGktRykk41hjwOdMWt1d3H6BgVJD70GJr/JFOHd+x
U4HGofMwqKkCJeXNOjykNJKZ0Q0pLqGoui5pgwKPZcOzzjsE0c2vGgiVodbFLouK
27741Q3YTbuHKtjcC4Uk+nWwdEeVcA1hj2FyuQ5Ua19y1b3HHiNzq0Z/YVc5IK6T
X6Bkv5+dA0u2ug9IN0xf8b5ON1yei9PY4So7Geox1NE0OxQTrKpK5H1wqI1iFNpH
SbfFelX2zy3zqR+D89l7KwlGRZu+BbfsfRRNNI4tRw7IcQ76NOUWuwHyEBV4TPyo
meFJNM45w069n1Xd6/rZumnNW2FMnOpzQdtYQFqMZEfy+tyW5qVHIEiG+CDWZXeh
ZqnOT3s+0ag5651kl5M9Q/KaHD4FTu8DYMKwEpttP9MlNaF9F5yq36mG5zdPduP2
iH8QjRDDs1Alkrek6C2qn2tGdagz670MmnR3TXhuznCPFOnKZfKvQqBvN3Ln0fRc
xKMzsbk9zIyqSIQaWprSe6ygz0RAU96/R2LOeUxRbRhca2Gcocq8VqeFOF5+ieWB
PwNfLP0iJXlpJyroU15wFhP2VIjrLA7IU84XtWRgqnTrIFgx3G/TuytnflRMlvFv
tDhcYZNN/4XDCD1uWjys
=8t7t
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
