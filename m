From: Pavel Machek <pavel@ucw.cz>
Subject: Re: simultaneous voice/data works (was Re: call/normal
 switch was Re: omap4-droid4: voice call support was)
Date: Sat, 7 Apr 2018 14:22:33 +0200
Message-ID: <20180407122233.GA11302@amd>
References: <20180401153631.GA5700@atomide.com>
 <20180401173012.GB5700@atomide.com>
 <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
 <20180402155754.GD5700@atomide.com>
 <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com> <20180406120423.GA18691@amd>
 <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
 <20180407081000.GB7818@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2656763259633967031=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180407081000.GB7818@amd>
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


--===============2656763259633967031==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-04-07 10:10:00, Pavel Machek wrote:
> Hi!
>=20
> It seems qmicli can be used while unicsy_demo/ofone talks to the modem
> using the AT commands.
>=20
> So I could do:
>=20
> qmicli -d /dev/cdc-wdm0 --wds-follow-network --wds-start-network=3Dapn=3D=
internet.t-mobile.cz
> route del default
> sudo ifconfig wwan0 up
> dhclient wwan0
>=20
> to get GPRS/UMTS connection. AT commands still work.
>=20
> Does anyone have any idea what to do to get the GPS to work?

Got that to work.

I installed modemmanager -- unfortunately that claims ttyUSB4 so it
breaks voice/sms -- but then

mmcli -m 0 --enable
mmcli -m 0  --location-enable-gps-nmea
watch -n .3 sudo mmcli -m 0  --location-get-gps-nmea

=2E..can be used to get GPS data. Droid4 seems to have rather bad GPS,
so you should probably put it near window for testing.

Is there way to grab data from modemmanager and feed it to gpsd, so
that normal applications can access gps? I don't see easy way.

I tried --location-enable-gps-unmanaged , but that did not work for
me.

Is modemmanager enabling GPS, or is it talking to libqmi to do that?
The code is quite confusing to me...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrIuAgACgkQMOfwapXb+vKwNgCgnpkGp1ZCvHY6YIGdLkLNZj2B
bF4An2dCSDEPgPDJVe6bZ9cpT1Ob5zoX
=4HlO
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

--===============2656763259633967031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2656763259633967031==--
