From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 4/6] phy: twl4030-usb: add ABI documentation
Date: Sat, 18 Apr 2015 08:34:02 +1000
Message-ID: <20150418083402.5b626011@notabene.brown>
References: <20150416075945.23307.24424.stgit@notabene.brown>
	<20150416080304.23307.7824.stgit@notabene.brown>
	<20150417221436.GA11429@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/S7jxHtlN.TgXiPXo609GpxP"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150417221436.GA11429@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: NeilBrown <neil@brown.name>, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/S7jxHtlN.TgXiPXo609GpxP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Apr 2015 00:14:36 +0200 Pavel Machek <pavel@ucw.cz> wrote:

> On Thu 2015-04-16 18:03:04, NeilBrown wrote:
> > From: NeilBrown <neilb@suse.de>
> >=20
> > This driver device one local attribute: vbus.
> > Describe that in Documentation/ABI/testing/sysfs-platform/twl4030-usb.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  .../ABI/testing/sysfs-platform-twl4030-usb         |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-twl4030-usb
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-twl4030-usb b/Doc=
umentation/ABI/testing/sysfs-platform-twl4030-usb
> > new file mode 100644
> > index 000000000000..512c51be64ae
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-twl4030-usb
> > @@ -0,0 +1,8 @@
> > +What: /sys/bus/platform/devices/*twl4030-usb/vbus
> > +Description:
> > +	Read-only status reporting if VBUS (approx 5V)
> > +	is being supplied by the USB bus.
> > +
> > +	Possible values: "on", "off".
>=20
> Would bit be better to have values "0" and "1"? Kernel usually does
> that for booleans...

1/ The code  already uses "on" and "off", so changing would be an ABI
breakage.

2/ No it doesn't.
 For modules params, the kernel uses "Y" and "N"

  git grep '? "on" : "off"'  | wc

 find 172 matches.

NeilBrown

--Sig_/S7jxHtlN.TgXiPXo609GpxP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVTGKWjnsnt1WYoG5AQJkdA//VMLH28j3P7pE6U9O81VHZtFJjM7mrDcL
X72CbtGa7QqyVbgjUtXnRXDFYa7Ds9i8DBdQ5ZaNn8NJk0uLfT62nRHQ0PSlT7Do
32ffVIYzDbaW/iVJ+5tU2EUfWufL8Tjn+Oyy09tA2NqIh9LUgNhDtaSIesB37N2Q
9l/RBE8ptTGyzhIjmFEG+FmbWzzjz3zog89cZUlJPalui7/0iWM9P+PLmVG/vO9E
MM5S0jbA6UWwe5X6oVJIp/S5SUMbdIbwtwRq2mNv/MA59G+/6+ZbUFlbiD53sz0S
BPlIQSVNBCSLNDNn9yXpxx8SO0naX89yLSw0aN8ump8tCwpjgg8pqdEKTaoUNz+R
YurrTrhccaegcoGFwBj/yznaWwyG4nMWH4sGDn3FPXcQFROUOf5QEkA4AzG/hgNU
Z/URS0pWuG9w0kHqQPpOH1+lKIbd+I8ZmzZvnVz1CM00ip5OU6cvJUw2xrsf5/qr
77SkIADQGQMPFouJK6erZN+WrhXe36ZuB3M+H0OEoNhONpF4i3pTqXJWBGnZo04M
Sj74MDqv+IeU6A7A88KB1820igrqbo/d1YdRnr2Cc5BP52Oym0g4XqIF03U1cbVc
ddNSPY6tGkABuuoIH0A712OGFmSA+8ViNfM74yh/fYcQEh2YJgivGjHhTSzW8YS9
MKFZf2xPAEg=
=rBbX
-----END PGP SIGNATURE-----

--Sig_/S7jxHtlN.TgXiPXo609GpxP--
