From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Microphone gain on N900
Date: Mon, 17 Apr 2017 22:34:01 +0200
Message-ID: <20170417203400.GA14505@amd>
References: <20170226202831.GA31405@amd>
 <201702272053.37882@pali>
 <4435ddd2-ca0e-b05d-727d-9f38416c0f97@bitmer.com>
 <20170302142822.GA30427@amd>
 <defb507c-0f4b-7dfe-817b-cb488f289aa3@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <defb507c-0f4b-7dfe-817b-cb488f289aa3@bitmer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>> v4.10 works quite nicely on N900, but I still have problems with
> >>>> audio. Even GSM calls would be usable, if I had reasonable volume on
> >>>> microphone and speaker... but I don't.
> >>>>
> >>>> Both speaker and microphone are too quiet. I can get louder output by
> >>>> plugging headset -- good. I can hear the other side nicely, but am
> >>>> too quiet for them. Unfortunately, even if I plug in wired headset,
> >>>> internal microphone is still used.
> >>>>
> >> For me these settings provide reasonable playback and capture volumes
> >> using v4.10.1:
> >>
> >> amixer -D hw:0 set PCM 100%
> >> amixer -D hw:0 set 'Line DAC' 80% on
> >> amixer -D hw:0 set 'Line' on
> >> amixer -D hw:0 set 'Left Line Mixer DACL1' on
> >> amixer -D hw:0 set 'Right Line Mixer DACR1' on
> >> amixer -D hw:0 set 'Jack Function' 'Headphone'
> >> amixer -D hw:0 set 'TPA6130A2 Headphone' 80%
> >>
> >> amixer -D hw:0 set 'Jack Function' 'Headset'
> >> amixer -D hw:0 set 'AGC' off
> >> amixer -D hw:0 set 'Input Select' 'ADC'
> >> amixer -D hw:0 set 'Left PGA Mixer Line1L' on
> >> amixer -D hw:0 set 'Left Line1L Mux' 'differential'
> >> amixer -D hw:0 set 'Right PGA Mixer Line1L' on
> >> amixer -D hw:0 set 'Right Line1L Mux' 'differential'
> >> amixer -D hw:0 set 'ADC HPF Cut-off' '0.0045xFs' 'disabled'
> >> amixer -D hw:0 set PGA 50% on
> >> amixer -D hw:0 cset iface=3DMIXER,name=3D'PGA Capture Switch',index=3D=
0 on
> >=20
> > This seems to correspond to volumes I have had before. They are enough
> > for phone call in quiet environment, but not really for normal usage.
> >=20
> > Do you have settings where microphone on wired headset works?
> >=20
> Those settings above. They are set after putting all volumes to 0 and
> muted. I'm using the Nokia WH-205 headset that came with the phone.

I just wanted to say thank you. I finally got to testing those
settings again, and this time headset microphone definitely works.

Loopback using arecord | aplay now produces reasonable volume of
audio. (Unfortunately, I still have some problems somewhere in the
audio<->GSM path :-( ).

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlj1JrgACgkQMOfwapXb+vII7QCghJ/kk98dqkfOYwWAQRa25z3F
6d8AnAma5u+dEhMHtzlDbz70IAWBgNTh
=cNa9
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
