From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Microphone gain on N900
Date: Thu, 2 Mar 2017 15:28:22 +0100
Message-ID: <20170302142822.GA30427@amd>
References: <20170226202831.GA31405@amd> <201702272053.37882@pali>
 <4435ddd2-ca0e-b05d-727d-9f38416c0f97@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8873924936993164972=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4435ddd2-ca0e-b05d-727d-9f38416c0f97@bitmer.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, abcloriens@gmail.com, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============8873924936993164972==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> v4.10 works quite nicely on N900, but I still have problems with
> >> audio. Even GSM calls would be usable, if I had reasonable volume on
> >> microphone and speaker... but I don't.
> >>
> >> Both speaker and microphone are too quiet. I can get louder output by
> >> plugging headset -- good. I can hear the other side nicely, but am
> >> too quiet for them. Unfortunately, even if I plug in wired headset,
> >> internal microphone is still used.
> >>
> For me these settings provide reasonable playback and capture volumes
> using v4.10.1:
>=20
> amixer -D hw:0 set PCM 100%
> amixer -D hw:0 set 'Line DAC' 80% on
> amixer -D hw:0 set 'Line' on
> amixer -D hw:0 set 'Left Line Mixer DACL1' on
> amixer -D hw:0 set 'Right Line Mixer DACR1' on
> amixer -D hw:0 set 'Jack Function' 'Headphone'
> amixer -D hw:0 set 'TPA6130A2 Headphone' 80%
>=20
> amixer -D hw:0 set 'Jack Function' 'Headset'
> amixer -D hw:0 set 'AGC' off
> amixer -D hw:0 set 'Input Select' 'ADC'
> amixer -D hw:0 set 'Left PGA Mixer Line1L' on
> amixer -D hw:0 set 'Left Line1L Mux' 'differential'
> amixer -D hw:0 set 'Right PGA Mixer Line1L' on
> amixer -D hw:0 set 'Right Line1L Mux' 'differential'
> amixer -D hw:0 set 'ADC HPF Cut-off' '0.0045xFs' 'disabled'
> amixer -D hw:0 set PGA 50% on
> amixer -D hw:0 cset iface=3DMIXER,name=3D'PGA Capture Switch',index=3D0 on

This seems to correspond to volumes I have had before. They are enough
for phone call in quiet environment, but not really for normal usage.

Do you have settings where microphone on wired headset works?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAli4LAYACgkQMOfwapXb+vKY+wCgoYqROLMYDI3kqW4lY7w8vyXG
Pb8An07bU25K9u8SYNHJptEA2OVmnGfv
=w3wD
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--


--===============8873924936993164972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8873924936993164972==--
