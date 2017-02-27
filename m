From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Microphone gain on N900
Date: Mon, 27 Feb 2017 20:53:37 +0100
Message-ID: <201702272053.37882@pali>
References: <20170226202831.GA31405@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3185623192746838731=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170226202831.GA31405@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, abcloriens@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

--===============3185623192746838731==
Content-Type: multipart/signed;
  boundary="nextPart1984490.qseyajWmyB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1984490.qseyajWmyB
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 26 February 2017 21:28:32 Pavel Machek wrote:
> Hi!
>=20
> v4.10 works quite nicely on N900, but I still have problems with
> audio. Even GSM calls would be usable, if I had reasonable volume on
> microphone and speaker... but I don't.
>=20
> Both speaker and microphone are too quiet. I can get louder output by
> plugging headset -- good. I can hear the other side nicely, but am
> too quiet for them. Unfortunately, even if I plug in wired headset,
> internal microphone is still used.
>=20
> Now... I researched mixer settings in v4.4, v4.10 and v2.6.28... and
> could not find way to control microphone. v2.6.28 is completely
> different from the other two. v4.10 misses many controls from v4.4;
> and I guess this might be related:
>=20
> [    2.579925] rx51-audio n900-audio: tlv320aic3x-hifi <->
> 49022000.mcbsp mapping ok
> [    2.586486] rx51-audio n900-audio: ASoC: no source widget found
> for TPA6130A2 HPLEFT
> [    2.592651] rx51-audio n900-audio: ASoC: Failed to add route
> TPA6130A2 HPLEFT -> direct -> Headphone Jack
> [    2.605163] rx51-audio n900-audio: ASoC: no source widget found
> for TPA6130A2 HPRIGHT
> [    2.611938] rx51-audio n900-audio: ASoC: Failed to add route
> TPA6130A2 HPRIGHT -> direct -> Headphone Jack
> [    2.625701] rx51-audio n900-audio: ASoC: no sink widget found for
> TPA6130A2 LEFTIN
> [    2.632965] rx51-audio n900-audio: ASoC: Failed to add route LLOUT
> -> direct -> TPA6130A2 LEFTIN
> [    2.640563] rx51-audio n900-audio: ASoC: no sink widget found for
> TPA6130A2 RIGHTIN
> [    2.648101] rx51-audio n900-audio: ASoC: Failed to add route RLOUT
> -> direct -> TPA6130A2 RIGHTIN
> [    2.655761] rx51-audio n900-audio: ASoC: no sink widget found for
> b LINE2R
> [    2.663208] rx51-audio n900-audio: ASoC: Failed to add route
> MONO_LOUT -> direct -> b LINE2R
> [    2.670501] rx51-audio n900-audio: ASoC: no source widget found
> for b HPLOUT
> [    2.677642] rx51-audio n900-audio: ASoC: Failed to add route b
> HPLOUT -> direct -> Earphone
> [    2.685058] rx51-audio n900-audio: ASoC: no source widget found
> for b Mic Bias
> [    2.692352] rx51-audio n900-audio: ASoC: Failed to add route b Mic
> Bias -> direct -> HS Mic
> [    2.706298] input: RX-51 AV Jack as
> /devices/platform/n900-audio/sound/card0/input6

Jarkko, Peter: can you look at above errors? Looks like audio routing is=20
not correctly configured.

> Pali, do you have maemo running on top of recent kernel (v4.1, v4.4,
> v4.10?). Do voice calls work there?

Now I do not have prepared Maemo + mainline kernel for testing...

I remember that Maemo sscd/csd/... daemons were able to connect to=20
cellular network but I was not trying to make voice calls.

> Any ideas welcome...
>=20
> Best regards,
> 									Pavel

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1984490.qseyajWmyB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAli0g8EACgkQi/DJPQPkQ1JcawCdFejJ9dDszlb5ah3EHMGgTSwK
bFkAoLd1oLs362zmxmYGvrYzY2ZNaNoW
=1l0b
-----END PGP SIGNATURE-----

--nextPart1984490.qseyajWmyB--


--===============3185623192746838731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3185623192746838731==--
