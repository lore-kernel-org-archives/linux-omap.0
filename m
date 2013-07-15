From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ASoC: omap: Enable COMPILE_TEST build for
	DT platforms
Date: Mon, 15 Jul 2013 19:32:02 +0300
Message-ID: <20130715163201.GC7366@arwen.pp.htv.fi>
References: <1373903876-26370-1-git-send-email-broonie@kernel.org>
 <20130715160045.GG32035@arwen.pp.htv.fi>
 <20130715162605.GS11538@sirena.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2082839125152524611=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20130715162605.GS11538@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

--===============2082839125152524611==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline

--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 05:26:05PM +0100, Mark Brown wrote:
> On Mon, Jul 15, 2013 at 07:00:45PM +0300, Felipe Balbi wrote:
> > On Mon, Jul 15, 2013 at 04:57:56PM +0100, Mark Brown wrote:
> > > @@ -26,7 +26,7 @@ config SND_OMAP_SOC_N810
>=20
> > >  config SND_OMAP_SOC_RX51
> > >  	tristate "SoC Audio support for Nokia RX-51"
> > > -	depends on SND_OMAP_SOC && MACH_NOKIA_RX51
> > > +	depends on SND_OMAP_SOC && (MACH_NOKIA_RX51 || COMPILE_TEST)
>=20
> > RX51 is OMAP3, and that's DT at all. This is likely just a case of
                             ^
			     not


> > updating commit log.
>=20
> Sentence parse grammar not.
>=20
> However...  if you look at the driver it actually does have DT support
> in there, it checks for the machine type or for compatibility with n900.
> Probably needs an ARM dependency which I'll add due to the machine type
> check.

alright.

--=20
balbi

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5CQBAAoJEIaOsuA1yqREntAP/RBejmzZvWGQKHR1lqz6aVxN
sgol0iagfOAOXquHlQ8ZjS3myFB/cDTMuHYXvX+C2IQqRn4xaHcTDmxPOHcnV9rG
GkIBiz6URQK90uJFHVbWzocEJUYZnzyciQY/xadFnmQdE0cietRMr71WdqT3DmqH
PiHZbJzgwre1MPz/dlIJX1J6Nn2aCNZEvSBQTQpILElE/WbuS2cYFIGouVMDnGr9
spArOJ9Wazzet2gGcKUzlW0qfiAPZibSje1zLO5jkUstSNkFuvALyCI78xdzsf+y
RD95Ab77Ag65qvzWVwoS78T7EALcQLKlCSZV9FLWBLl5jdQhCUwlzibuMbrYQOSi
kQ1UHIlSj2N7YhOnaEIJ9B4IfI6Y4O3u4PKl+pCtGgpzVzpax4izJl6KZ6TMKtgN
AMKrN3whE4t3nC9W0IsFmMAR1FmNRGgeQ3eJVtL1ICydmeJRONGBeFbbypi0rYgF
D/8Dvh5NiZcD7785z/D3SODYoOhyKJ3gLolhgP2CBqc/wv7E3iUCUrUKTIR+Fy1v
UPCdajLWsYwc+NOlrGXtnyK7VH4SSiZAmoKyVNP1wfNzNDIV2TJ4fQzIWF6hPnug
WxDy5MOetJMeYZpLkcCJdTww8BRKHMPbgbpvu63naDN0vCDCwUWl4cT47JHWQHQD
8PLI+SalQ8oQ8+WZjd/i
=OBTT
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--

--===============2082839125152524611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2082839125152524611==--
