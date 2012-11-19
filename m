From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange platform devices
 for ASoC drivers
Date: Mon, 19 Nov 2012 14:58:41 +0200
Message-ID: <50AA2D01.5020302@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com> <1353029819-21809-3-git-send-email-ricardo.neri@ti.com> <50A5F0A5.2010105@ti.com> <50A6805C.3050004@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB15A76B562404C2E4540EE1C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43724 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827Ab2KSM6s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 07:58:48 -0500
In-Reply-To: <50A6805C.3050004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: tony@atomide.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

--------------enigB15A76B562404C2E4540EE1C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-16 20:05, Ricardo Neri wrote:

> I hope the explanation above provides more clarity to you. I think HDMI=

> does not fit seamlessly into the ASoC driver model, as we don't have a
> real codec and no machine driver seems to be needed. This is the best I=

> could get. :/ :)

Ok. I can't say I fully grasp everything about the audio architecture,
but this clarified it anyway.

So I'm fine with the three audio related devices. But I still have the
following points:

The name of the codec platform_device is "hdmi-audio-codec". Isn't that
too generic name? Shouldn't it be "omap-hdmi-audio-codec"? Then again,
you said in this case it represents the tv-set. If so, should it be a
generic codec driver, without any reference to omap?

I still don't understand why the codec and machine drivers need to be
created in the board file. That just forces us to replicate the same
code for all OMAP boards that have OMAP HDMI output. Why not create the
devices in some common code, for example arch/arm/mach-omap2/display.c?

With DT this should be similar: OMAP's hdmi devices should be presented
in the omap4.dtsi file, not in each individual board dts. Although the
DT data should represent the hardware, and if the code and machine
devices are not really there in the HW, then... I don't know =3D).

And something that confuses me: sound/soc/codecs/omap-hdmi.c contains a
codec and dai drivers, but sound/soc/omap/omap-hdmi.c also contains a
dai driver. The latter actually contains two dai drivers, the other a
platform driver and the other a snd_soc_dai_driver. But I guess this is
asoc details, and not relevant to this disuccsion =3D).

 Tomi



--------------enigB15A76B562404C2E4540EE1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQqi0BAAoJEPo9qoy8lh71assP/2ugPYChUndgoJSGnqE4g8xe
VwG5Lo9Ru5VTLQj2hZ2X2xA56ZygnxzNFGbCdGdbeUa8qDLs0J6uIRLBZdtwHVTI
R8SXfmFrLw2lOpc0UWVjnY8FVAJcmu/t6JpYcqzdL7Ndn7K3UY615jE+ZC4rCZ3j
HDabZ9rZl4l6VRYrCw6GW1ZiypspzJ7Cj0woift7uAOwS/Hq3UoOJHLbJqscXWsP
CxOgxopVXqStz0iKQNZhJKKjnsD/le6CBz70Sfy0pt+KmzPp38Wm0ZcC09LQgSkC
eoetJAWSewnEkLOmf7hBtPm2P+TzmDe4OqTwsAMcV4yWcLvXR8SL5oNC0+beylnd
gS1mK9yjtJJIK1YdWnPdAxDKkveXqU+X6z8pd/BG29vczH3IEHyKcYAPzia+EVDf
gfSMWFK9Jd6BneOifNutoFL2KIjLqjKiGtuAN7wiEXHXQ61kKk0OQgc6NIwBiF9q
noJy59HeQNaA+0cRFtWo2CNV6O99kBhO6Wt8fI6tKfWkyu0/eXoUCZTFBypIAxF6
uVyLWIT37lm1mM/JvIsMA163dUkTy6QvfQ7r6oe1yUFnPn1GtQi4aGdpeqQKxCkG
ySENNY6RO619rAx6VD4prRY+syStA22DUchsoJMqR0pGQVeHLx8HDl2ALw+Fwd+H
IHX4Uwyi14NTNmkxKQsy
=GBD/
-----END PGP SIGNATURE-----

--------------enigB15A76B562404C2E4540EE1C--
