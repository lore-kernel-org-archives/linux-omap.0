From: Pavel Machek <pavel@ucw.cz>
Subject: Re: call/normal switch was Re: omap4-droid4: voice
	call support was
Date: Sat, 31 Mar 2018 21:46:16 +0200
Message-ID: <20180331194616.GA19388@amd>
References: <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com> <20180331145531.GA10404@amd>
 <20180331181935.GX5700@atomide.com> <20180331191939.GA8999@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8787553058881223582=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180331191939.GA8999@amd>
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


--===============8787553058881223582==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-03-31 21:19:39, Pavel Machek wrote:
> On Sat 2018-03-31 11:19:35, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [180331 14:56]:
> > > Hi!
> > >=20
> > > > Hmm well I got audio call hacked to work as a proof of concept hack,
> > > > see below. Maybe it can be used to verify some of the assumptions
> > > > above.
> > > >=20
> > > > Then.. To split the work a bit, can you guys maybe try to decode
> > > > the cpcap register values and try to do a proper ASoC driver patch?
> > >=20
> > > This is not proper patch yet, but it should be a step in that
> > > direction...
> >=20
> > Cool :) Microphone still does not work for me.. I tried tweaking
> > the alsamixer settings but no mic. This is with cold boot with
> > droid4-kexecboot if that might make a difference, we may have
> > some register uninitialized somewhere. Any ideas?
>=20
> Ok, I was focusing on the speaker side.
>=20
> alsamixer, tab to go to capture settings, set it to 37 37 Mic2 Mic1
> should work, according to my notes, but not recently tested and not
> tested against real human.
>=20
> I'll attempt to test it, but something in my userland shuts down
> system just after boot 60% of time, which is rather annoying.

Hmm. So I tried again, and setting Mic1 and back in the capture
settings crashed the modem. Bang, disconnected from the USB.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq/5YgACgkQMOfwapXb+vIDJgCfaibLmTgKvbpU19lpATnNUHbf
+ZkAn2gHcy0x8Xh38+19E9I4SxWWn+H6
=Gjp1
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

--===============8787553058881223582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8787553058881223582==--
