From: Pavel Machek <pavel@ucw.cz>
Subject: simultaneous voice/data works (was Re: call/normal
 switch was Re: omap4-droid4: voice call support was)
Date: Sat, 7 Apr 2018 10:10:00 +0200
Message-ID: <20180407081000.GB7818@amd>
References: <20180401131852.GA11086@amd> <20180401153631.GA5700@atomide.com>
 <20180401173012.GB5700@atomide.com>
 <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
 <20180402155754.GD5700@atomide.com>
 <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com> <20180406120423.GA18691@amd>
 <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2608735475586296374=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Dan Williams <dcbw@redhat.com>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============2608735475586296374==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It seems qmicli can be used while unicsy_demo/ofone talks to the modem
using the AT commands.

So I could do:

qmicli -d /dev/cdc-wdm0 --wds-follow-network --wds-start-network=3Dapn=3Din=
ternet.t-mobile.cz
route del default
sudo ifconfig wwan0 up
dhclient wwan0

to get GPRS/UMTS connection. AT commands still work.

Does anyone have any idea what to do to get the GPS to work?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrIfNgACgkQMOfwapXb+vLUgwCeM8xvN8f4NiGsYsGYTtPbEpiu
+kMAn0ncGuWCT/d3i8uOStcDckMHMnJ9
=sXKV
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

--===============2608735475586296374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2608735475586296374==--
