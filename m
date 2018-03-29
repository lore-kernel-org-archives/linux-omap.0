From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Thu, 29 Mar 2018 18:08:28 +0200
Message-ID: <20180329160828.GA14007@amd>
References: <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4699826837723844454=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180329014507.GM5700@atomide.com>
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


--===============4699826837723844454==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> @@ -510,17 +510,17 @@
>  07f4: 0000
>  07f8: 0000
>  07fc: 0000
> -0800: 0065
> -0804: 0000
> -0808: 0040
> +0800: 0025     # CPCAP_REG_VAUDIOC     VAUDIO Control
> +0804: 60cf     # CPCAP_REG_CC          Codec Control, moto cpcap.c:1337 =
sets 0x0093?
> +0808: ae0a     # CPCAP_REG_CDI         Codec Digital Interface
>  080c: 0000
>  0810: 0004
> -0814: 0804
> -0818: 079c
> -081c: 0000
> -0820: 0924
> -0824: 0000
> -0828: 0000
> +0814: 0cc0     # CPCAP_REG_TXI         TX Inputs, moto cpcap.c:1340 sets=
 0x0CC6?
> +0818: 0610     # CPCAP_REG_TXMP        TX MIC PGA's, moto cpcap.c:1343 s=
ets 0x0273?
> +081c: 0006     # CPCAP_REG_RXOA        RX Output Amplifiers
> +0820: 0b2c     # CPCAP_REG_RXVC        RX Volume Control
> +0824: 0606     # CPCAP_REG_RXCOA       RX Codec to Output Amps
> +0828: 0600     # CPCAP_REG_RXSDOA      RX Stereo DAC to Output Amps
>  082c: 0400
>  0830: 0000
>  0834: 0030
>=20
> I wonder if mdm6600 is the i2s master during the voice call?
>=20
> Then using the n_gsm ts 27.010 uart mux, I dial:
>=20
> ./ngsm-rw 1 "AT+CFUN=3D1"		# connect to network
> U0001+CFUN:OK
> ./ngsm-rw 2 "AT+CMUT=3D0"		# unmute speaker over ch2, do this over qmi?
> U0001+CMUT:OK
> ./ngsm-rw 1 "ATD#123"		# dial number
> U0001D:OK
>=20
> And I do hear a voice talking over the speakerphone :) Sorry have not tes=
ted the
> mic yet..

Hehe, ok, that's fun! I don't need +CMUT=3D0. It gave me error but then
the call worked, anyway... (I'm working with ttyUSB4).

I don't know how to hang the call up. ATH did not work for me.

And no, microphone does not work.

Thanks!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq9D3wACgkQMOfwapXb+vJOXACeJS8eBaU9CzbKBlKXSGMIoiax
lP8AoMHbGnIDq2WJe7JmFQzS8qX2vta+
=YR7x
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

--===============4699826837723844454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4699826837723844454==--
