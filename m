From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/4] pwm: omap-dmtimer: fix period/duty_cycle calculation
Date: Fri, 4 Mar 2016 22:18:38 +0100
Message-ID: <20160304211838.GA21731@ulmo>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <20160226203100.303fe192.drivshin.allworx@gmail.com>
 <20160304151948.GF26400@ulmo.nvidia.com>
 <20160304112736.660e4223.drivshin.allworx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160304112736.660e4223.drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>, Adam Ford <aford173@gmail.com>
List-Id: linux-omap@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 04, 2016 at 11:27:36AM -0500, David Rivshin (Allworx) wrote:
> On Fri, 4 Mar 2016 16:19:48 +0100
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Fri, Feb 26, 2016 at 08:31:00PM -0500, David Rivshin (Allworx) wrote:
> > > On Fri, 29 Jan 2016 23:26:50 -0500
> > > "David Rivshin (Allworx)" <drivshin.allworx@gmail.com> wrote:
> > >  =20
> > > > From: David Rivshin <drivshin@allworx.com>
> > > >=20
> > > > When using a short PWM period (approaching the min of 2/clk_rate),
> > > > pwm-omap-dmtimer does not produce accurate results. In the worst ca=
se a
> > > > requested period of 2/clk_rate would result in a real period of 4/c=
lk_rate
> > > > instead. This is a series includes a fix for that problem, as well =
as
> > > > other related improvements, and is based on the current linux-pwm/f=
or-next
> > > > tip.
> > > >=20
> > > > I have tested on a Sitara AM335x platform, using a scope to verify =
the
> > > > output with a variety of periods and duty cycles. This includes a P=
WM
> > > > rate up clk_rate/2 with 50% duty cycle (e.g. generating fclk/2) with
> > > > both 32768Hz and 24MHz fclks. I do not have an OMAP4 board to test =
with,
> > > > although appropriate sections in the the reference manuals appear
> > > > substantially the same, so I believe the changes are equally correct
> > > > there.
> > > >=20
> > > > Note that the OMAP4 TRMs do effectively state that the maximum PWM
> > > > rate is clk_rate/4, so at very fast PWM rates the behavior may not =
be
> > > > as reliable as I observed with Sitara. Although I suspect that it's
> > > > the same module and will also work, at least under some circumstanc=
es.
> > > > If anyone with OMAP4 hardware and a scope is so inclined, I would be
> > > > curious to know the results.
> > > >=20
> > > > David Rivshin (4):
> > > >   pwm: omap-dmtimer: fix inaccurate period/duty_cycle calculation
> > > >   pwm: omap-dmtimer: add sanity checking for load and match values
> > > >   pwm: omap-dmtimer: round load and match values rather than trunca=
te
> > > >   pwm: omap-dmtimer: add dev_dbg() message for effective period and=
 duty
> > > >     cycle
> > > >=20
> > > >  drivers/pwm/pwm-omap-dmtimer.c | 71 ++++++++++++++++++++++++++++++=
++----------
> > > >  1 file changed, 55 insertions(+), 16 deletions(-)
> > > >  =20
> > >=20
> > > Hi Thierry,
> > >=20
> > > Gentle ping. It does not look like you've taken this series, and I=20
> > > wanted to make sure you're not waiting on something from me. It would=
=20
> > > be nice to get at least the first patch into 4.5, if possible. =20
> >=20
> > I've applied patches 1 and 3, and I'm planning on sending out a pull
> > request for inclusion in v4.5-rc7 later on.
>=20
> Thanks!
>=20
> > Patches 2 and 4 didn't seem ready/critical, so let's finish those up
> > for v4.6-rc1.
>=20
> I know there was a lot of discussion on 4, but I'm not sure what the=20
> concern is on patch 2. Is there something specific you're thinking of?

Patch 2 sounded like some optional sanity checking which we didn't hit
anyway in the current code. Hence I didn't consider it a fix.

> FYI, I know that Adam Ford is using this driver as the backend for
> a pwm-backlight control. Without patch 2 this driver will not configure=
=20
> the HW in a legal way at 0 or 100% duty cycle. However, I forget what=20
> the practical effect of that is, and Adam seemed to indicate it was OK
> for his purposes.

Okay, I'll hold back a little longer to give you some time to test.

Thierry

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW2furAAoJEN0jrNd/PrOhtCgQALDOK6zODu1XucnFKlYyVk2T
7h4RH8kq+Vi8GdJOT8JRDRftvioB87ZWOWerzy2nX2VeK1bSWoT9YjP8lXKdHh05
8d0d8m3ScfWNLk6fGY/L/ymQuMN58eIgzG9OmmUgkaD2Vj2LRNiVHvl1aRDPMgaL
gCn45fgtRUB2qZ0U5M1h0reaZMEF2VVL38L3HCQTa+EItbq99y/12OpAdI++v1ZJ
5Iei9GgzfRhq2X5q2cqRpN0ghFcGDmZNJfIry8UdPXQSyCXZeiyvL2lyTdy0HkUW
2xFjshjE+1whiA0leXFOU3Jdm4pkN/uxnqvCwO29hAirFoVBQ0qpXI8/EMX/f6QX
l4bl9jsRD/oNbErPtsa5T6hJ98E0BxKPj8l6C+13anToQhnjHPdPsw3hgmStHyCr
xv4CwTfKCg08f6bX6loXWZrY5gg0TLuyiLXl7hNiYW9sVWmGTHVtfeLO8sr0Qmee
O6aprz6/OsGoKiRodyx0ldW918taI6DXRAE1nWif/sPM797nQKFzIXqcXHZ7k++B
l0wlWiJ/TL4oYV9U+F0FutXq1HuhjQI5huOeuWQXv/18NKghLpEVzVCjl/tPMmpp
aimNXgYcXhLDSiX8PRS5F9Nsb3TBIize1eg1fadLqbr4G6toK9eQkpHKAaJo8uVx
kRA7VC06ct54zI18H+aK
=ROx2
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
