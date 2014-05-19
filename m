From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 19 May 2014 22:05:15 +0300
Message-ID: <537A55EB.1080507@ti.com>
References: <20140513152518.GA16837@atomide.com> <53730AFB.2090800@ti.com> <20140514160216.GD18463@atomide.com> <537487AE.3060906@ti.com> <20140515182133.GC23659@atomide.com> <5375A8A8.7080306@ti.com> <20140516160717.GD22031@atomide.com> <20140516174158.GA11733@earth.universe> <20140516180154.GG22031@atomide.com> <5379CD24.6040508@ti.com> <20140519160447.GB4849@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9oluejSWgmpHFmU7a3XUjO06vtPL92lct"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56396 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbaESTFx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 15:05:53 -0400
In-Reply-To: <20140519160447.GB4849@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--9oluejSWgmpHFmU7a3XUjO06vtPL92lct
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19/05/14 19:04, Tony Lindgren wrote:

> In many cases however we do have multiple compatible strings that
> describe how the device is wired. See drivers/tty/serial/of_serial.c
> for example. It has "ns16550" but then it also has additional
> "nvidia,tegra20-uart", "nxp,lpc3220-uart" and "ibm,qpace-nwp-serial".

All those sound like SoC components. In that case it sounds fine to have
the device compatible contain the SoC name. We're talking here about
external, detachable devices.

>>> Not use what you're after with the SPI example though, but sounds
>>> like that's something different.
>>
>> I think Sebastien's example is just like the issue here.
>=20
> Hmm is there some existing example in the kernel like that?

No, Sebastien's example was just a hypothetical case. Here, using your
way of having SoC specific data in the .dts, we would have
"sharp,ls037v7dw01-omap-dss", and in Sebastien's example with a touch
sensor we'd have, say, "synaptics,xyz123-omap-spi".

 Tomi



--9oluejSWgmpHFmU7a3XUjO06vtPL92lct
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTelXxAAoJEPo9qoy8lh71km8P+wbIBvTWJrht6h0TkaLoAaJ6
0SWm2fxDE75ANgQueJL0ocJM/ZERY75bohw6wP4B0LL5uTBABpcTZ2v4ukOu07Rf
ikWDWiCsmplpXWYbSmv6a7qyxknwtafIab8I2cMrM2ugvH9jSVdYclZaCwqGL/zp
tssX15WAHXvjVk7nXEHeNecfgicwLd1uCt/201YT8KPS+Z77Z2TWIkpojnjzzJ0+
NoGr9NEq26/vdDxur5cpfyRnxzsTrzpGpvxXLorEToorUJDf6Y0V++YWuxt9Q4hy
1fsH6nI1Pp6d1RaMrj30eUkQ6IzMySeoKE+01akYkrys3ncPi6XBpKx5DAdNdnoP
5doVeWDUnhYDTxykwSD3pS/wEWbmNPVQDIg1VMuoRsCuqyIkpt2P6TwD/vKBvtiD
9Ypns9fG9PeflUjT19UVDRPBcMBdhotsKf0OOhQ+ioPWEngiPXR5fXCC/ls3eACE
NVMBgU5iQ5cEDNS/4XHK9tg2WijI39+mHoDxl0Xtqd842Ac42OVTyGDMlq04zfIq
+PFZcjuACVZDqFSD5GL6i8Zgpwr3Tz6esUkp/6B0aFnh00xYdiZUnzG2IwjnJRiV
ihpcIvykFQQtCkWuiAJJ9N1eWtJuASMxp8+eqWr85eq16mhqTIr6Jzcm/u5pymU8
FgSJjvod0XV6dXhOLzfF
=1J0I
-----END PGP SIGNATURE-----

--9oluejSWgmpHFmU7a3XUjO06vtPL92lct--
