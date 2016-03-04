From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/4] pwm: omap-dmtimer: fix period/duty_cycle calculation
Date: Fri, 4 Mar 2016 16:19:48 +0100
Message-ID: <20160304151948.GF26400@ulmo.nvidia.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <20160226203100.303fe192.drivshin.allworx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pgaa2uWPnPrfixyx"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160226203100.303fe192.drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org


--Pgaa2uWPnPrfixyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 08:31:00PM -0500, David Rivshin (Allworx) wrote:
> On Fri, 29 Jan 2016 23:26:50 -0500
> "David Rivshin (Allworx)" <drivshin.allworx@gmail.com> wrote:
>=20
> > From: David Rivshin <drivshin@allworx.com>
> >=20
> > When using a short PWM period (approaching the min of 2/clk_rate),
> > pwm-omap-dmtimer does not produce accurate results. In the worst case a
> > requested period of 2/clk_rate would result in a real period of 4/clk_r=
ate
> > instead. This is a series includes a fix for that problem, as well as
> > other related improvements, and is based on the current linux-pwm/for-n=
ext
> > tip.
> >=20
> > I have tested on a Sitara AM335x platform, using a scope to verify the
> > output with a variety of periods and duty cycles. This includes a PWM
> > rate up clk_rate/2 with 50% duty cycle (e.g. generating fclk/2) with
> > both 32768Hz and 24MHz fclks. I do not have an OMAP4 board to test with,
> > although appropriate sections in the the reference manuals appear
> > substantially the same, so I believe the changes are equally correct
> > there.
> >=20
> > Note that the OMAP4 TRMs do effectively state that the maximum PWM
> > rate is clk_rate/4, so at very fast PWM rates the behavior may not be
> > as reliable as I observed with Sitara. Although I suspect that it's
> > the same module and will also work, at least under some circumstances.
> > If anyone with OMAP4 hardware and a scope is so inclined, I would be
> > curious to know the results.
> >=20
> > David Rivshin (4):
> >   pwm: omap-dmtimer: fix inaccurate period/duty_cycle calculation
> >   pwm: omap-dmtimer: add sanity checking for load and match values
> >   pwm: omap-dmtimer: round load and match values rather than truncate
> >   pwm: omap-dmtimer: add dev_dbg() message for effective period and duty
> >     cycle
> >=20
> >  drivers/pwm/pwm-omap-dmtimer.c | 71 ++++++++++++++++++++++++++++++++--=
--------
> >  1 file changed, 55 insertions(+), 16 deletions(-)
> >=20
>=20
> Hi Thierry,
>=20
> Gentle ping. It does not look like you've taken this series, and I=20
> wanted to make sure you're not waiting on something from me. It would=20
> be nice to get at least the first patch into 4.5, if possible.

I've applied patches 1 and 3, and I'm planning on sending out a pull
request for inclusion in v4.5-rc7 later on.

Patches 2 and 4 didn't seem ready/critical, so let's finish those up
for v4.6-rc1.

Thierry

--Pgaa2uWPnPrfixyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW2aeUAAoJEN0jrNd/PrOharMP/0NBo53MjcIvfiqyH1s8bUSW
rQ8NZnu06j7hhMjezlgpaq2kbIVkH0IKuLi1l6blic/uoj55f8RHZiJsbKZeV/Fm
qI+C9Iv5RfVCDly4hNrWusnHoN59nt9FExwLmcGyCwHcSS4bExaFppz9yW567uB+
47vUSRPjS5PfYDQwn4oB3Zq5++F++lROHzvWjHr+FcmdLBOTwVwmZZfDovJDpnIQ
q2/78ujZ/NN5hknI2SIpaN4CijIYzKMEuy/ffLeuLI9Gf9Q7A67IswxpKYJTq92m
tXNufCfk/zs2CfUDUj16/nBkP3awMR/dgJFu4foyrX7KMXdeojDI4BKTSaK3Oo++
Ovi8eYTCONr8tD6qoonxkl1keYQjjIEvlEzaBtM/33hpdHdOOthuBJZtX8KfG4F3
kHUfmNi5GyKVLbd17ZmQOELC28M/ReUH2bghSmEDRk9MrrRt/0XS9cUiEsx62ulq
lkxPmsKsFBFS3dV9dB8lBfG2wKopk7afzGJLv5RbniylVkxpEq3tpMV0NNhUD+x3
P5JesP5St/48HASW4mQOg27LqpQ7H0XPLNoH9NVxBjzvpeUr5iIcoglH3G/KbCAG
A0gtYEVhSMNHZtLDFzn8XCq1YcFJQxlnhW47cTww8qQ5uni42EXqnnER46X1WYa/
C+Z8JgzD9pGgwxVHoeAN
=FIZX
-----END PGP SIGNATURE-----

--Pgaa2uWPnPrfixyx--
