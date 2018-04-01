From: Pavel Machek <pavel@ucw.cz>
Subject: Re: call/normal switch was Re: omap4-droid4: voice
	call support was
Date: Sun, 1 Apr 2018 15:18:52 +0200
Message-ID: <20180401131852.GA11086@amd>
References: <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com> <20180331145531.GA10404@amd>
 <20180331181935.GX5700@atomide.com> <20180331191939.GA8999@amd>
 <20180331194616.GA19388@amd> <20180331195524.GB19388@amd>
 <20180331234314.GZ5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3556982793431663491=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180331234314.GZ5700@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============3556982793431663491==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-03-31 16:43:14, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180331 19:56]:
> > On Sat 2018-03-31 21:46:16, Pavel Machek wrote:
> > > On Sat 2018-03-31 21:19:39, Pavel Machek wrote:
> > > > On Sat 2018-03-31 11:19:35, Tony Lindgren wrote:
> > > > > Cool :) Microphone still does not work for me.. I tried tweaking
> > > > > the alsamixer settings but no mic. This is with cold boot with
> > > > > droid4-kexecboot if that might make a difference, we may have
> > > > > some register uninitialized somewhere. Any ideas?
> > > >=20
> > > > Ok, I was focusing on the speaker side.
> > > >=20
> > > > alsamixer, tab to go to capture settings, set it to 37 37 Mic2 Mic1
> > > > should work, according to my notes, but not recently tested and not
> > > > tested against real human.
> > > >=20
> > > > I'll attempt to test it, but something in my userland shuts down
> > > > system just after boot 60% of time, which is rather annoying.
> > >=20
> > > Hmm. So I tried again, and setting Mic1 and back in the capture
> > > settings crashed the modem. Bang, disconnected from the USB.
> >=20
> > Next try, and it worked this time.
> >=20
> > _Before the call_, set mode to Normal and then Call. Then go to
> > capture, and set 100 100 Mic2 Mic1. Then place a call,
> >=20
> > AT+CFUN=3D1
> > OK
> > ATD6;
>=20
> No luck with microphone here :( Using ttyUSB4, AT+CFUN=3D1
> works, but ATD command on it just hangs the USB interface
> and I have to reload phy-mapphone-mdm6600 to reset the
> modem.

Test call with real human worked (thanks to Rolf K.), I could hear him
well but he reported call was very quiet. And that was with capture
settings at 100%.

If you had a register dump from android with mics working, preferably
not in speaker mode, perhaps I could try to figure it out?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrA3DwACgkQMOfwapXb+vKQyACgnbrFs3rTKvHCoMKHWoeXGdpR
MF4AoKlnNqMScX5ldLO34asSo9+ZYKH8
=XUgN
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

--===============3556982793431663491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3556982793431663491==--
