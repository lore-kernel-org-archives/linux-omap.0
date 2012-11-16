From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
Date: Fri, 16 Nov 2012 09:15:13 +0200
Message-ID: <50A5E801.3000100@ti.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com> <20121112225037.GU6801@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1A9442FB413F366B828C5EE3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60571 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab2KPHPX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 02:15:23 -0500
In-Reply-To: <20121112225037.GU6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: archit@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org

--------------enig1A9442FB413F366B828C5EE3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-13 00:50, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [121112 02:27]:
>> Hi,
>>
>> This series changes omapfb to use standard dma_alloc funcs instead of =
omap
>> specific vram allocator. This let's us remove the omap vram allocator,=
 making
>> omapfb platform independent.
>>
>> However, note that using standard dma funcs causes the following downs=
ides:
>>
>> 1) dma_alloc_attrs doesn't let us allocate at certain physical address=
=2E
>> However, this should not be a problem as this feature of vram allocato=
r
>> is only used when reserving the framebuffer that was initialized by th=
e
>> bootloader, and we don't currently support "passing" a framebuffer fro=
m
>> the bootloader to the kernel anyway.
>>
>> 2) dma_alloc_attrs, as of now, always ioremaps the allocated area, and=

>> we don't need the ioremap when using VRFB. This patch uses
>> DMA_ATTR_NO_KERNEL_MAPPING for the allocation, but the flag is current=
ly
>> not operational.
>>
>> 3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
>> changed the ioctl to return 64M for all the values, which, I hope, the=

>> applications will interpret as "there's enough vram".
>>
>> 4) "vram" kernel parameter to define how much ram to reserve for video=
 use no
>> longer works. The user needs to enable CMA and use "cma" parameter.
>=20
> Great, thanks for fixing these. Could you please queue these into
> a separate branch against v3.7-rc5 that I can also merge into
> omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3?
>=20
> Feel free to add my Acked-by: Tony Lindgren <tony@atomide.com> to the
> arch/arm/*omap*/* parts.

I added your acks, and pushed:

git://gitorious.org/linux-omap-dss2/linux.git 3.8/vram-conversion

It's based on -rc4 as my other branches are based on that.

 Tomi



--------------enig1A9442FB413F366B828C5EE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQpegEAAoJEPo9qoy8lh71Dv0QAIBHXdsYNvcoppwcGUTNFpuc
ScgwlQTzRajJWvTlYx1mJms/uboyPnBdwgfdDpPZFkg0r41FzO/BCwOiB9joFxag
1Zm38UlB65Cif45+B5RoY9s7WYP/uCHQZu/guk3Dguzr0uCVuEMl9vHm1U7ZipB6
WSeE843y9zrxirwM8erGnkBlCdGaJOWDUWmT7ZFXWSCJh+1i/TcepaXhWpYS9vn9
fDkyNVKjwbChGdk9Ok+yoHeO5GyWIRjtvMYtjKeE0t5RUViVAcZ4NeIoehJCw4Nz
n46wLBs2xRNrLO/pt8lwqT9wSOi+EBN6O8yQM4OwDA9kLSda29lY/zAAkj8Lj3WD
KjHklL59azh5ia4zPDXTYMN5mAaaNslYuL6O8/UtUzRbh4iEqpBr88qgOrZ+3vgL
A2238aQcrwJ1Nr0GBoy3HWlpAKvkfrG5wCT+dfrPXJhflbglIm0U7xC7tEraRWu7
ClfGqa+v0Isqsd1vb86VhS96/RGGYcf9E3TSVjnB/71h4QSZW3S3r5EeMfkgNYDj
1VTE0D45hmfiO2QUSdNdRtfcxm9MAXU6aPXxXq5cSLpxrKspi5Y6ma1lY97k2Nst
HbPlyFGdBdYedgBwhaqbMSRyMiqT82QQcQ/YeIdKFNgbgbJ3pbDfsU3WiWfoe03U
JV9kKwe0Oeqr9HwlVNKc
=33Ev
-----END PGP SIGNATURE-----

--------------enig1A9442FB413F366B828C5EE3--
