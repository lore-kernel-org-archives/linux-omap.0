From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Fri, 25 Apr 2014 17:08:00 +0300
Message-ID: <535A6C40.10609@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com> <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com> <535A42D6.5090107@ti.com> <535A4470.2000509@ti.com> <535A5C0A.7040808@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="5mmMEWITP1AsGc9IpFuA8KVw1rdK6triU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53552 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbaDYOI3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Apr 2014 10:08:29 -0400
In-Reply-To: <535A5C0A.7040808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

--5mmMEWITP1AsGc9IpFuA8KVw1rdK6triU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/04/14 15:58, Archit Taneja wrote:
> On Friday 25 April 2014 04:48 PM, Tomi Valkeinen wrote:
>> On 25/04/14 14:11, Archit Taneja wrote:
>>> Hi,
>>>
>>> On Thursday 24 April 2014 03:47 PM, Tomi Valkeinen wrote:
>>>> Add support to set OMAP5 DSI pin muxing.
>>>>
>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>> ---
>>>>    arch/arm/mach-omap2/display.c | 35
>>>> ++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 34 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/display.c
>>>> b/arch/arm/mach-omap2/display.c
>>>> index 16d33d831287..974461441fc3 100644
>>>> --- a/arch/arm/mach-omap2/display.c
>>>> +++ b/arch/arm/mach-omap2/display.c
>>>> @@ -137,11 +137,42 @@ static int omap4_dsi_mux_pads(int dsi_id,
>>>> unsigned lanes)
>>>>        return 0;
>>>>    }
>>>>
>>>> +#define CONTROL_PAD_BASE    0x4A002800
>>>> +#define CONTROL_DSIPHY        0x614
>>>> +
>>>
>>> I guess this is something we can move to our driver, and use sysconf =
to
>>> get the register from DT.
>>
>> I just copied the same method as used for OMAP4.
>>
>> I guess sysconf is an option. But I really dislike the idea of moving
>> omap control module code to a display driver... I'm not sure what othe=
r
>> options we have, though. Maybe an OMAP DSI specific pinctrl driver?
>=20
> OMAP4 has CONTROL_DSIPHY for configuring both lane enable/disbale, and
> pull up/down, but OMAP5 has normal PAD_CONF registers for DSI lines(2
> pins per register) for configuring pull up/down, and CONTROL_DSIPHY for=

> lane enable/disable.
>=20
> We would have a very messed up pinctrl driver, but it would probably be=

> better than doing all this stuff in the driver.

Actually, this patch is not good. I should've looked at the code more
carefully =3D).

This one does ioremap every time the function is called, which could be
done multiple times.

And I think omap4_ctrl_pad_readl() can be used to access the registers.
Like this (not tested):

#define OMAP5_CONTROL_DSIPHY		0x614

static int omap5_dsi_mux_pads(int dsi_id, unsigned lanes)
{
	u32 enable_mask, enable_shift, reg;

	if (dsi_id =3D=3D 0) {
		enable_mask =3D OMAP4_DSI1_LANEENABLE_MASK;
		enable_shift =3D OMAP4_DSI1_LANEENABLE_SHIFT;
	} else if (dsi_id =3D=3D 1) {
		enable_mask =3D OMAP4_DSI2_LANEENABLE_MASK;
		enable_shift =3D OMAP4_DSI2_LANEENABLE_SHIFT;
	} else {
		return -ENODEV;
	}

	reg =3D omap4_ctrl_pad_readl(OMAP5_CONTROL_DSIPHY);
	reg &=3D ~enable_mask;
	reg |=3D (lanes << enable_shift) & enable_mask;
	omap4_ctrl_pad_writel(reg, OMAP5_CONTROL_DSIPHY);

	return 0;
}

 Tomi



--5mmMEWITP1AsGc9IpFuA8KVw1rdK6triU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTWmxAAAoJEPo9qoy8lh71p2QP/A0gRTagCGAJu1PGctr7D48X
ABiy4OVPkGSR4cKlLD4chtdm7bWeLnwepuSwT4PQundh+G88aClhypkzlT9nNYLJ
Ghzin8PeXR67asvS5YDdUSethf7IvY4dEXpYZTM+v10GfYapS3XoLSJmT312o7oH
QeDwO36rdGnaPsnVGvN3uQx80lNzjDqHS15bEZq8KoZXIkMzy9IeZC2NOVwCvjQH
7T6mIhOUJS2iScMDUHqFX4+b3f5wnx79+m82+Z2Z1cCkVSiCnE8NPwLM1RJwSyGO
hIY2ynjBCi87DyojDqXvL3Q34N+ylhmo2IFWjHB9pqXUOXBhNoOb8HvZf2V65kfs
VmwHZYOtJ+wFXLTrX/tbscunGS2pbB6bpStiW7lWkumdULCO8JjN41yprlfJ8HUS
7Duk2aZkTYt0pGDQkQruXu5SMIme8CkOVDikToFn1rNWnWo+w7urmUF+g1BDh2qX
+Y6nCPh2GAdC4Ixm1Ushb3C6DEeXeJJCmohEFNMG0ZInOBe9t0/oVXtWrXArGa6t
q4kOPe30m4vzdl6c4nc76VQwkSafeVDsdymDIMdljUuCEbOYfmW/Wb7EkBuypU8k
MAWFadsGe8bTC30a8fWf9IWMN7joqHhvvcyVPF324+V7AIbn3RH2RPw6T2I2VQ1K
KlEeS1ROu1K3/npabDx4
=BSRM
-----END PGP SIGNATURE-----

--5mmMEWITP1AsGc9IpFuA8KVw1rdK6triU--
