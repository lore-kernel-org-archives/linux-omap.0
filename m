From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange platform devices for
 ASoC drivers
Date: Tue, 20 Nov 2012 10:15:28 +0900
Message-ID: <20121120011526.GF4483@opensource.wolfsonmicro.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com>
 <1353029819-21809-3-git-send-email-ricardo.neri@ti.com>
 <50A5F0A5.2010105@ti.com>
 <50A6805C.3050004@ti.com>
 <50AA2D01.5020302@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41524 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751786Ab2KTBPh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 20:15:37 -0500
Content-Disposition: inline
In-Reply-To: <50AA2D01.5020302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>, tony@atomide.com, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 02:58:41PM +0200, Tomi Valkeinen wrote:

> I still don't understand why the codec and machine drivers need to be
> created in the board file. That just forces us to replicate the same
> code for all OMAP boards that have OMAP HDMI output. Why not create the
> devices in some common code, for example arch/arm/mach-omap2/display.c?

Yes, this would be more sensible if there's no board specifics involved.

> With DT this should be similar: OMAP's hdmi devices should be presented
> in the omap4.dtsi file, not in each individual board dts. Although the
> DT data should represent the hardware, and if the code and machine
> devices are not really there in the HW, then... I don't know =).

Well, in a case like this where the sound card is essentially autoprobed
based on the detection of the hardware at runtime the sound card
probably shouldn't appear in the device tree at all - you'll probably
want something to say there's a physical HDMI port it's worth looking at
there but everything else should be figured out at runtime.

> And something that confuses me: sound/soc/codecs/omap-hdmi.c contains a
> codec and dai drivers, but sound/soc/omap/omap-hdmi.c also contains a
> dai driver. The latter actually contains two dai drivers, the other a
> platform driver and the other a snd_soc_dai_driver. But I guess this is
> asoc details, and not relevant to this disuccsion =).

There's an interaface on each end of the link, they're wired together to
communicate between the two devices.

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqtl1AAoJELSic+t+oim9GfMP/3pRzznJdkqaNDCa2lLUVmXI
Suy72Ie0YPrH5OudC6gyDH5TYs/RT6GzFlLr/6Ky3/xpV/RkZySb0Ac7MGKpTE52
tJhjdTz+PoXxxBLRJUrM/SYyZ8vSKJRDx7bklnQcjqeuPTPcaahXhHkvftPk5+9c
opYx9f0qgbEi5mklkF+PKSl1kQu2MbMSoP20gkt6kcD0qkdUpNMO9sBdNhrIt7Bf
D60iZi/WHJEYPnsoBptlDeFzvqDmLR/LQIPLdgOj1ThdHS8PTIKHW8OprQyX2Qhx
rpdSXu3B2QUt76Zd/0lNnfbuvZrSmyKLlFGCFZ4P1OgQTv+01MkrddJuLxoIfkhW
yo5Kj20Hr2d4at5tDFUaQo5rc0UbB1/8I6YGcJwYlUv2aheis/x/i9hY8LL5Jnu5
xdaZ777H/lmOD+6GRI1RltABAhdShxAsTJJWgvekEgh7mL0lR7u/3KDFHrirnm6w
lefpLwVa3rfBxsfoK/eAPbCxJGZo1ItPHRku5zFXAS09Q7ufS+fC72I6S7ISzx+o
czVF0vPoPWnoqxilCWXa8F56fBUVzpPlgRRe4okya0P4FJvs9/5+GuWUJtbYo5ZU
f0HCFIFqoUac4nfoosGxq6Ye1lyHl1d168egl2ZDR4rLRyPVFkcmnXfhjmG9Vzw0
gcfQqTIvS2tV+4hR6jMX
=uIlM
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--
