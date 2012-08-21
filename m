From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: snd_soc_jack for HDMI audio: does it
 make	sense?
Date: Tue, 21 Aug 2012 14:16:26 +0100
Message-ID: <20120821131625.GD7995@opensource.wolfsonmicro.com>
References: <5032E8A5.8070108@ti.com> <s5hlih895kt.wl%tiwai@suse.de>
 <20120821120511.GB7995@opensource.wolfsonmicro.com>
 <50337F7B.1060501@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1141499583293439534=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <50337F7B.1060501@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Ricardo Neri <ricardo.neri@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Guiriec,
 Sebastien" <s-guiriec@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============1141499583293439534==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 02:30:51PM +0200, David Henningsson wrote:
> On 08/21/2012 02:05 PM, Mark Brown wrote:

> >  - sound/core/ctljack.c which was added later and provides separate
> >    in-kernel and userspace APIs and is currently only used by HDA.

> This is wrong. PulseAudio uses the new ctljack API. I started out
> with an implementation which used the input device API
> (sound/core/jack.c), but since some people did not like this API,
> the ctljack API was designed and implemented for PA to use, which it
> does (since PulseAudio 2.0 - the input device API implementation in
> PulseAudio was never merged upstream).

...and the only thing using this API to generate events is HDA which is
what I was talking about here given that this is a question from a
driver point of view.

> >What I'd like to see happening is that we merge ctljack into jack (since
> >only HDA is going to be affected by that change it seems like the right
> >direction to make the merge) and also add extcon support, I have looked
> >at the extcon support.

> I don't know either why we have two different interfaces for jack
> detection (not counting extcon) for driver writers. I think we
> should merge jack and ctljack, as long as that does not mean you
> break anything I'm relying on in ctljack.

> Maybe something for discussion at Plumbers?

We discussed this last time we all met and came to the above conclusion :/

> >Short term for drivers used on embedded systems I'd have to recommend
> >extcon rather than anything ALSA-specific.

> I thought that when Takashi did the new ctljack interface, that
> would effectively deprecate the old input device interface, and that
> ctljack was the new recommendation.

Android currently uses the out of tree version of the extcon ABI (like I
say it's where the code originated), and some OSs do use the input ABI
also but realistically if you've got to pick one Android is where the
market is at.

To my knowledge no embedded OS is using the control jacks, it's possible
that there's something using them as a function of using PulseAudio but
the ones I'm famililar with currently ignore PulseAudio routing and just
use the mixing facilities.  Given the dependency on alsa-lib it'd be an
inconvenient ABI to adopt for most of them.

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM4m1AAoJEFJkBDiqVpZ4EVcQAI6fUHlwXEXfcFXmeQSGYi0M
oy2hAxDDBLyRvNsvEbbYkrqg1XG+bnLKqS528DY6ssax1Eigfpf8DKGhHEdMSF5x
ghdM5Eda9diDXuw2uypVrhQQFiFGImwsTlFP2P/1TrwVZlY0kdDq8gBsEx14IuPZ
tTqn3lwPX8BN4tsJLdxVLSzISBBekn5tKaC8a2ghVQ3+uqLrLG9ysDR896IuYD2D
L6AoOXKEQSigv5vbS6KJqpsipYnZ2PNJJk3NXpY46H4wvFZUK8FGMbFQEsgoVJQQ
w0oJlG7UR0RiICkrX2knl9jrKsFL2EmwtsbxysTyouebxs1IsxN8p7eaYvKM5Ub6
N4GKPcnAicw3aShC5+Tu9rv1QFNCtwGFPNz5VwRAFoAVO2e5890JBNxN/loQFS2/
4goX7xs2DUYCj9Mah4CPzAsrGBG7LWBU3iz6pa5PPdF1dLCDxxDq6HyUvIeZm9VS
iVJuwaPRAvVhSgScMG73gm9udBSRDtE1KgAr1CbRtvvO+rNg48u2O9ZWir9IUViz
A0i5xrR1Bi8rZMqdjvUsRrWlA2H2c+SFhmZPIpQv4JltRhKDNhUInhOSAEpNfepU
S1BHL+USnjQzsajeCKuDmac0SvoVEqIch4oEX9uBvF0zq0feQGKIORNlmu3FAlSS
k7feihwU2gy7OW1oZW2l
=xLs3
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--

--===============1141499583293439534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1141499583293439534==--
