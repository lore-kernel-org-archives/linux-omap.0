From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Thu, 12 Dec 2013 10:54:48 +0200
Message-ID: <52A979D8.3040604@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1824203.Ui6fpnZVmO@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="TJit0L8LbaepxPrJKn0HUHCsojcbVM4TO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59255 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064Ab3LLIzH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 03:55:07 -0500
In-Reply-To: <1824203.Ui6fpnZVmO@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

--TJit0L8LbaepxPrJKn0HUHCsojcbVM4TO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2013-12-12 02:39, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> On Wednesday 04 December 2013 14:28:27 Tomi Valkeinen wrote:
>> Hi,
>>
>> Here's a new version for DT support to OMAP Display Subsystem. See
>> http://article.gmane.org/gmane.linux.ports.arm.omap/102689 for the int=
ro of
>> the previous version, which contains thoughts about the related proble=
ms.
>>
>> The major change in this version is the use of V4L2 and CDF style
>> port/endpoint style in the DT data.
>=20
> That's great, and I fully support that. This also calls for refactoring=
 the=20
> V4L2 DT bindings and support code to share them with display devices. A=
=20
> bikeshedding question is where to put the common code.

Thanks very much for review!

I know drivers/video is in practice "fbdev", but drivers/video (the
words) sound like the best place for things related to video.

We should establish a committee to ponder this important question.

Btw, I don't know if you noticed (or did I mention it somewhere): I use
a bit shortened form of the V4L2 bindings. If there's just one endpoint,
I omit the port node. I think that's always unambiguous (compared to
also omitting the endpoint node, and having the properties in the main
node, as was mentioned in some other thread).

I also don't supply the same data for both endpoints, when the data is
about the link. E.g. I think the V4L2 binding doc suggests to supply
things like bus-width for both endpoints. I only supply the data for the
endpoint that uses that data. With some encoders/panels the same data
could be needed on both ends, but not in these patches.

>> However, note that even if the DT data contains proper port & endpoint=
 data,
>> the drivers only use the first endpoint. This is to simplify the patch=
es, as
>> adding full support for the ports and endpoints to the drivers will be=
 a big
>> task.
>=20
> That's perfectly fine, there's no need to implement unused features jus=
t for=20
> the sake of it, as long as the bindings are forward-compatible in that =

> respect.
>=20
>> This approach still works with more or less all the boards, as the onl=
y
>> cases where the simpler model is an issue are the boards with multiple=

>> display devices connected to a single output.
>>
>> Laurent, I'd appreciate if you could have a look at the .dts changes, =
to see
>> if there's anything that's clearly not CDF compatible.
>=20
> I've quickly reviewed the patch set, concentrating on the .dts changes.=
=20
> Overall it looks good to me, but I suspect that we will need quite some=
 time=20
> to finalize standard bindings as there's lots of small details that nee=
d to be=20
> taken care of.

Yes. I want to get this forward as it's becoming too much pain to manage
things without DSS DT support, when the rest of the OMAP platform code
is using DT.

The most important thing in the DSS DT bindings for now is that they
should contain enough information so that any future DT bindings changes
can be handled with a boot-time conversion code.

Actually, even the endpoint/port stuff is extra, as that could be
deduced even from the "video-source" method I used in earlier DT versions=
=2E

> The major point that bothers we, as explained in my reply to one of the=
=20
> patches, is that I feel like the multi-device model (virtual DSS core +=
 DSS=20
> modules) might not accurately represent the hardware. Departing from it=
=20
> probably sounds scary but might not be such a large change.

There are actually two separate things here. One is the multi-device
model, having separate device for each DSS submodule. The other is
having the 'omapdss' "virtual" platform device.

Note that the "dss_core" device is a real HW block, and depicted as the
"dss" node in DT data, whereas "omapdss" device is not present in the DT
data, and is created dynamically at boot time.

The omapdss device is a legacy thing, but nowadays it is mainly used to
pass platform data. Removing omapdss device is not easy, but the only
questions around that is how to implement the required platform-data
functionalities, and it doesn't affect the DT data.

 Tomi



--TJit0L8LbaepxPrJKn0HUHCsojcbVM4TO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqXnYAAoJEPo9qoy8lh717eoP/jV6sFf/QYrx3B3SHQy5G1gN
4gcipzRhrT5Yse499ZdH4dD1Bzf88w9GEc8dgDRKtIAKYneGNFXum3joKRvDXC5u
ZgIoRnRBI/OrJrQsKP0hQM0e2AfxFTXICacnvisiG+EntRrHlAw+0q87pnshzSZe
OlrwuqeFrbGvucmOtl7uWELZVKDhERIF4yMKOzlcEvv8AUWxzbBUslgtmFM1usYG
wC0W/EEk+MigX1Q2DOBbJ7so4wk+fNVMrjPu1Hi9QMfZJrb7dQzXZt8fZ+9I1ZEN
JRMsbiqf+Z7GuxEn+5jbU32PMl62x56PHxQxQaZIGvpw9sEOw1/iIzMUm8bcJ1x2
MG91zIfa/KxjRAoazZe5DTrQjiSR+kTAIFDUTEBCuajBTtiAFbQ/TYe3rYeUNUCD
lnG85F+36nx0Rytem9dZm7B6e5RR5JUO1fohWTKOiJ5yabxKiJDasLOz5aJkF1ps
7LqmH/zxXNwZjVX3SxcDwMzn9pW+bZGYwD6Qk97yEbTeejSVWs7j7lj6D2emE7E7
xNunEPkBNuTe32gKPy8lWw/xu4S0fgJbAdT7Y3C+9328ZEjvWlq1TZJ4nNrvEMif
Q8fg/ykvA7PVB69Dw5fXhveZXpNUJ4UyByk87sRodXE9h4lVz+WvGDJaAXy7Q7kS
+92ZNhNk38InBD4lPZQB
=oPcG
-----END PGP SIGNATURE-----

--TJit0L8LbaepxPrJKn0HUHCsojcbVM4TO--
