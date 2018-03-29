From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Thu, 29 Mar 2018 17:46:00 +0200
Message-ID: <20180329154600.qhels5fqzzg364gj@earth.universe>
References: <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hmjo6ahyvmg6zlgq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180329135904.GN5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>
List-Id: linux-omap@vger.kernel.org


--hmjo6ahyvmg6zlgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 29, 2018 at 06:59:04AM -0700, Tony Lindgren wrote:
> > I think cpcap is always the clock and frame master, but I think
> > mdm6600 is the remote side and OMAP is not involved at all.
>=20
> OK. So could it be just an alsamixer on/off toggle then for
> "Modem" or something similar?

I think so. We might want to have an "Mode" enum instead, though.
That can be extended, once we unlock the other modes (bluetooth,
bluetooth call).

> > > Then using the n_gsm ts 27.010 uart mux, I dial:
> > >=20
> > > ./ngsm-rw 1 "AT+CFUN=3D1"		# connect to network
> > > U0001+CFUN:OK
> > > ./ngsm-rw 2 "AT+CMUT=3D0"		# unmute speaker over ch2, do this over qm=
i?
> > > U0001+CMUT:OK
> > > ./ngsm-rw 1 "ATD#123"		# dial number
> > > U0001D:OK
>=20
> There's a typo above, it should be just ATD123 where 123 is the
> number.
>=20
> I was just doing few test calls to robots. Payback time for all
> the robocalls, you know! :)
>
> > > And I do hear a voice talking over the speakerphone :) Sorry have not=
 tested the
> > > mic yet..
>=20
> And calling a person I can hear the other end but the mic is
> not working. So maybe I need to tweak the alsamixer settings
> too for mic?

Your override kills most settings from alsamixer. You can try to
just override CPCAP_REG_VAUDIOC, CPCAP_REG_CC and CPCAP_REG_CDI
and setup everything else with alsamixer.

-- Sebastian

--hmjo6ahyvmg6zlgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq9CjUACgkQ2O7X88g7
+przkQ//X/5hsQChHBeVIjqlDhdUuMlOScdWIVtCkqvjvmIJ6BOuOwH1/eTaZo3S
vPetWimm69AYWiGZVe2RH6eIQol1SaGGTT0kUrOa3drtybAyp2Ck2YCukumgk8NX
ZNaPcg8X7eCTpHwd92bTocoThtnS7hBbLCQkpZWMYtmVRn8OibVaB7C+6wSr+tlu
bkrtLNDa5Zy7y8lKv98Kb9+7UrDPzRXN2q8JGb3NiH2S0by6+nB6uAQvApO7XuD+
VnhlsvnVR6BFakVdqiaM1En9omPSGdpxGhluqoroWaftgHMc2jjopahk6Yjj6UtQ
iLkkZ5yWRVcogTNYTFKCYhfOyQiJVycYL7yf7TIiLwxBgJJi/2nuGtUWcsMQ/GAW
lhGKcqTuoK7SBW+mM0ghzpa8QzP50KVBlwQBAkKkVzEXmL/6MP3ipUCXHnssPlt/
57n7vgcJTG+cxM03rQsIO1ut6+Jo3ytTFuRkhBLnEOXSSwPwalxLQYDudSqaty6h
S5XnJUfbLt4DC9e9n38lOpuLFmI5U7XtXn8nghteUxJNytKDfyavJeA0qUb0UqNN
R3Hdy71YL2NYUWh5KfjIRosTCn66KuOnhMFbyRdTL7tMlRiix0GreDDkJQ4CIr1l
J0XAghjRrSqzcHccvOGeQiKlBtpw6XONEX/Ka0CWrB6RqeHQ37g=
=2Fvm
-----END PGP SIGNATURE-----

--hmjo6ahyvmg6zlgq--
