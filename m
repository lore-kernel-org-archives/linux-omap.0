From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/5] OMAPFB: connect ovl managers to all dssdevs
Date: Mon, 10 Dec 2012 13:03:25 +0200
Message-ID: <50C5C17D.7070102@ti.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com> <1354881309-17625-5-git-send-email-tomi.valkeinen@ti.com> <50C5909E.8030800@ti.com> <50C59745.2080604@ti.com> <50C5B154.9080305@ti.com> <50C5B44E.3040304@ti.com> <50C5BF32.1080006@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD3FEA6672B804AAB43EEB8D4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36881 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496Ab2LJLD2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 06:03:28 -0500
In-Reply-To: <50C5BF32.1080006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigD3FEA6672B804AAB43EEB8D4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-10 12:53, Archit Taneja wrote:
> On Monday 10 December 2012 03:37 PM, Tomi Valkeinen wrote:
>> On 2012-12-10 11:54, Archit Taneja wrote:
>>> On Monday 10 December 2012 01:33 PM, Tomi Valkeinen wrote:
>>
>>>> Another option would be to pass information about mgr-output links f=
rom
>>>> the board files (or DT data) to the omapdss driver, so that omapdss
>>>> could setup them at probe time. With this option omapfb/omapdrm does=
n't
>>>> need to care about this, and it doesn't create load order restrictio=
n.
>>>> But mgr-output links are something that I'd really like to handle
>>>> inside
>>>> the drivers, not something that needs to be passed via platform data=
=2E
>>>
>>> This would definitely make things simpler, but if this parameter is p=
ut
>>> in a panel's DT, it would become omap specific. We could add this inf=
o
>>> to the DT corresponding to omapdss.
>>
>> Yes, I meant it should be omapdss platform data. Nothing related to
>> panels.
>=20
> I think this is the easiest way out. We can have one parameter per
> output in DT. If we do come up with a way to implement the 3rd option
> below, we can always ignore those DT fields(assuming our implementation=

> to give the same result). So in this way, we would just be deprecating =
a
> DT field in the future, and calculating it ourselves.

I would rather go the other way around: calculate it ourselves
(presuming it can be done for the current boards), and add the DT field
later if we come up with boards that won't work with the dynamic approach=
=2E

The reasons I'm not too happy with having the parameter in the DT data
is that:

- DT should be about describing the hardware connections between
components, but in this case it's dynamically configurable connection.

- We need to have the DT parameter for all cases, even if in 95% of
cases it's not really needed.

- We may never need the parameter, if we never get boards that require
funny setup.

> If we do use DT/platform data, would we need to parse it in omapdrm to
> establish drm entities? Or do we rely on omapdss to parse the DT data
> and give the links to omapdrm?

I think we should parse it in omapdss and setup the connections at
omapdss's probe. Then when omapfb/omapdrm starts, they can get
information about the connections from omapdss, and setup their entities
as they want.

So omapdss would setup the mgr->output->panel links, and they would be
ready for omapfb/omapdrm to use.

 Tomi



--------------enigD3FEA6672B804AAB43EEB8D4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQxcF9AAoJEPo9qoy8lh71bI8QAIPFIxltUKXCtVpbYOSkEVWP
c+u7sZBEfpD6G59rMireaXXTXW3jtyyJhROo2C8nNS6P7LqqUrn7mAiM+TXJNgSb
SttLHtbY5LoPbBxsP/nGfSos02VfnsAoVHjkshYJxDZvPZlZi5tYW2d7+paxska2
ofKYMf+rVSZHamvMjR/jYtrGjiwL37qabXpEWAWYBaQMj++NiRe1TL3W77NMK/P6
znYhSp3+CMrk/2pyN3ueES33p4W+meJwVJdrTdPlKXObmvdCz4YQZDkRcIa3eMnS
9XpysEs1cl7tE6KNjoGdc/A5vqYyH6iGBAOgqKtzQzDmASS21pWxHyf5rwUkYyIR
mg9C+hPa4CL/YRskUj25XLiq1z+5iGViIRmwIumDjqxpF4Z8tLCUvqdqK13MZDco
VdLc/u4RMX8gO6OiaWvhnbKEyH8yeMGWaUwsfiz+16inM/3yFt1Q4IDLthjOySLp
AgVuh2j46p1z0mzyJ78zLXLexRrXOrkUXDLXxmfL5h6TgsIKQup8wf7lFM6Thzo3
IomY6HIiySnMZ4z9O5yPkhsO0iw6fedRPax7F5rqGMLEzjaH093/umGeIVIoHsL8
mBBNdD3YH9CPs40ItzsEmrs7v+98DKFTOt1SHrN8dZ1V4PYnLGxVkywAnsiS+FVt
gFZ85Whwtr/ZrLv/o88i
=cX8G
-----END PGP SIGNATURE-----

--------------enigD3FEA6672B804AAB43EEB8D4--
