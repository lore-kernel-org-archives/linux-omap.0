From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 0/4] Support for Variscite OM44 modules and boards
Date: Fri, 9 May 2014 12:44:11 +0300
Message-ID: <536CA36B.6000101@ti.com>
References: <1398971269-20515-1-git-send-email-manabian@gmail.com>	<20140506001530.GL25949@atomide.com> <CAGhQ9VystybERsiPUX4ESNBcKPKBN44GvuPUtTM+jpywUqON3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="J7oPDMXsJkfHmEclWTiFdK0pE1Of3rLE1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49574 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754129AbaEIJoj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 05:44:39 -0400
In-Reply-To: <CAGhQ9VystybERsiPUX4ESNBcKPKBN44GvuPUtTM+jpywUqON3A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org

--J7oPDMXsJkfHmEclWTiFdK0pE1Of3rLE1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/05/14 21:02, Joachim Eastwood wrote:
> 1On 6 May 2014 02:15, Tony Lindgren <tony@atomide.com> wrote:
>> * Joachim Eastwood <manabian@gmail.com> [140501 12:08]:
>>> Hello,
>>>
>>> This patch set adds support for Variscite OM44 series of system on mo=
dules and boards.
>>>
>>> There weren't many comments on v1 of this patch set so I hope this ca=
n make it into 3.16.
>>> Changes since v2:
>>>  * Use OMAP IOPAD macros
>>>
>>> Patch 1: Add support for the SoM itself and the reference carrier boa=
rd. Together these make the VAR-STK-OM44 dev kit.
>>> Patch 2: Add support for VAR-DVK-OM44 which is just the STK with a LC=
D display.
>>> Patch 3: Nodes for WLAN/BT support.
>>> Patch 4: Add quirks so that WLAN can be used. Still waiting for prope=
r DT bindings.
>>>
>>> Since this patch set now uses the IOPAD macros a fix from Tony is nee=
d.
>>> See: https://patchwork.kernel.org/patch/4025421/
>>
>> Just noted that the macro won't work while was about to
>> apply these, sorry. So we're back to either using the
>> existing OMAP4_WKUP_IOPAD or raw offset from the padconf
>> area unless you have some great macro ideas.
>=20
> I see. I'll take another look at the macro's and see what I can come up=
 with.
>=20
>>> Note that patch 1 relies upon a patch from Tomi Valkeinen add hpd-gpi=
o (hotplug detect) to the "hdmi-connector".
>>> See: http://marc.info/?l=3Dlinux-omap&m=3D139771947508021&w=3D2
>>>
>>> Patch 2 also relies upon a patch from Tomi that adds DT support to pa=
nel-dpi.
>>> See: http://marc.info/?l=3Ddevicetree&m=3D139030201815380&w=3D2
>>
>> Maybe also leave out the DSS changes until Tomi has confirmed
>> those?
>=20
> I can split the patch set and put a patch with the DSS DT nodes at the
> end. Maybe this last patch can go through Tomi if he has a DSS DT
> branch. I don't want to drop it entirely from the patch set because
> some other people has expressed interest in testing it with full
> display and hdmi support.

I have the HDMI and panel-dpi patches queued for 3.16. As this is a new
board, and there's no compile time dependency on DSS stuff, I think all
these patches can go through Tony.

For the display related parts in these patches:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--J7oPDMXsJkfHmEclWTiFdK0pE1Of3rLE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbKNrAAoJEPo9qoy8lh71lBAP/3XDkUJYx7YBIrubSG/JrLfX
ieaYYHcT5ITeT/vH7otChB9IIB8r0x67utDyiTlMwpxlc+ULuLjXm76TAs3yvYqg
kSGKG0MFUlSaYcgk0rjo0LYOycGw2jnhnBN6ZOZt4yTyEtiToKvoqVpGPJKFku8+
FqwIy5L6HvER2p42nKgT1wVHXOG9xcpg5Y+/iNFiXDoXW/t8CBjT01c40nSNQitg
z+uAPGEoqThpZspFewq/akOYrIJLDCoVPdBWkpx+INEH+PWlP7xSvbKHd1pLfyiE
If/kwI6liOl9MhWmSuF4M/g28rkLmYsrebUAWYwjq8dDfL1uP6eTv7P8AGu452aq
BVkxhWGVcT53JKU1JIzRLKcuEHUnL+IwUQ9eDj2An4q1zRMnBJ+gU6gt0JBA9vUD
2nsY3YHaCUvfYN+yIek5v3PaKCdAoq/ymIc+zUC19rosPvcuSMknspfWvcYn+boV
GKo/o8iC5rp0WCR9m9nM1wHP5iXhT/bCNi6WnI0VLjNjUKsznx7pR3C/yAcOswzL
G3K95bt/aH7yfIVqZzarHKnzvBQwoXCLd2h6+gzsSzvER2RqMMg/Z8imed7KXIiw
xu2Yil26DGMRK2QBtEaN0nW2w0em+Tx+c9AFg6mbM0DPJDgGA0JOcEkDl1Pha+hO
Gy2IEcZKyrkTv0ABpA3x
=OmKI
-----END PGP SIGNATURE-----

--J7oPDMXsJkfHmEclWTiFdK0pE1Of3rLE1--
