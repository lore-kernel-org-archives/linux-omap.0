From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 23/27] OMAPDSS: connector-dvi: Add DT support
Date: Wed, 18 Dec 2013 12:41:03 +0200
Message-ID: <52B17BBF.8090003@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <20131217070551.GR24559@pengutronix.de> <52AFFA2E.5050702@ti.com> <1651476.iaILztiDEi@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="E1POrgl6eIEwBmCWDUfpnTvwVSU7CM6Jh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37112 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab3LRKlN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 05:41:13 -0500
In-Reply-To: <1651476.iaILztiDEi@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--E1POrgl6eIEwBmCWDUfpnTvwVSU7CM6Jh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-17 17:15, Laurent Pinchart wrote:

>>> Either the driver is too specific or the binding is too generic, but
>>> having such a generic name for an omap specific driver seems wrong. S=
ame
>>> for panel-dpi, svideo-connector, composite-video-connector and
>>> hdmi-connector,
>>
>> Hmm. Good point. I was thinking that the driver is only used on OMAP, =
but of
>> course that's not true, the driver is there for all platforms if the k=
ernel
>> just happens to be compiled with the driver.
>>
>> And it's not just about those drivers you mention. The same issue is t=
here
>> for, say, "ti,tpd12s015". I have an omapdss specific driver for that, =
but if
>> some other platform uses the same chip, they'll have a driver for it a=
lso...
>>
>> Sigh. I wonder how this should be handled... The only solution that co=
mes to
>> my mind is to have all the compatible strings as "ti,...". But that's =
not
>> correct, as they are not TI components, but some are generic ones and =
some
>> from another vendor.
>>
>> And even "ti,..." is not good, as there are other TI SoCs with other d=
isplay
>> drivers. So I'd need to prepend the compatible strings with "omapdss,.=
=2E.",
>> making the hardware components driver specific.
>>
>> The long term plan is to make the drivers generic (or implement the sa=
me
>> driver for common display framework). But for now I need to have futur=
e
>> proof DT bindings with omapdss specific drivers...
>=20
> I'll refrain from mentioning that the problem has been identified more =
than a=20
> year ago. Oh, wait, I've metioned it, sorry :-D
>=20
> We really want to make drivers generic enough to be shared by multiple =
display=20
> controllers. I would vote for making the DT bindings generic now alread=
y,=20
> which would be enough to buy some time to fix the problem properly. If =
we=20
> start prepending driver-specific prefixes such as "omapdss," to compati=
ble=20
> string we'll just make the mess even larger and reduce the incentive to=
 fix=20
> it. It would be the worst decision we could make.

Well... I think there are no good options here. I see the following optio=
ns:

1. Add "omapdss," or similar to compat strings in DT, and the same for
the drivers. This solves the issue, but then we'll have bad DT data,
although I see similar method already being used in some places. When we
have common drivers, we can remove the "omapdss," strings from DT, but
we still need to keep them in the drivers to have backward compatibility.=


2. Keep the compat strings generic in DT. This way we'll have correct DT
data, but if anyone happens to create a new driver with the same compat
string, things will break. omapdss can only be compiled for a kernel
with OMAP and ARM support, so it narrows the problematic drivers a bit.

3. Have correct DT data, but at init time, in omap arch code, go through
the DT data and change the compat strings for the display nodes to
include "omapdss,". This way the drivers would only work for omap
platforms. Like a combination of 1. and 2. I'm not sure if the DT-code
allows this at the moment, though.

We could also now select option 2., and go for 3. later if someone else
creates a driver with the same compat string.

While I'm obviously not very impartial here, I do think that using
generic bindings for omapdss is not the worst possible case, as:

I'm very much dedicated to get CDF merged at some point, and I already
have been working on it for each revision.

I also think that even if the omap panel drivers are currently omap
specific, they are not very much so. I have been changing them over the
years to be more and more generic, and I have used them as a base for
CDF panel drivers. If some platform specific driver may have a generic
compat string, omap panel drivers are not the worst option.

I will look at the option 3., hopefully that will be possible and
everybody will be happy. Any other ideas appreciated.

 Tomi



--E1POrgl6eIEwBmCWDUfpnTvwVSU7CM6Jh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSsXu/AAoJEPo9qoy8lh71pJ4QAInERha/H3nPcuf8/ClZ+jd3
zLK9MSjTDG6Tr9LY3l8OiB2zh9ThdYjz7V4VWU6uxyE4gkof9WToECwWscbC2wSA
DsS/aNBPU4Fa3immVdXSewe1Cy9OMirjpTt+HbHvCujm45U0887i11Fso3UVHcSs
iCCHol72f1OHBtMrzQ8/PyTCgEG4isoyXyQlkGILftZNM/FZReCRDboO9dH9cp1m
esAWI9uo3KYSES0bUvMQOaiialAD2F9mThgExk+USMhVaW9qT0vI88iqUROvxEYp
koc4l5ri0iYiJPMP9Sxg36oXYfZpC6iRtbCLPFHddba5DeODgrRneFk9Bsa1N8/M
sLqWLg+KshNUJs3hvHey2KM97GyDDKA+rij8TtTirg+pKrLlQMa+9f2k+2OEphSM
0n12D53t8w29zYEAUrlKz7LxtdKPASrHjq0IhYNQNgLPbdcBgrjPJ0B0NAYcBhmN
Yx16QXQTmcze3W6EsvYMRwQ7oJXNCJRmObz6qR5deGrNBm45fAD4bWAvxxundUL2
fPzUYDCd8+6XEgjZKnA+C2nQ1nPe+5KuIYqnF2UvASdy/l1Ns2Ge54xVzogCg1fg
0kkUDFJgPyMQAKjhmn86W9ac8zBXMPP5eXUUSJzZa682OIg+JVlIgHb4wsiiBy+h
tDYZfrPCPr8Tu1GB5Dgg
=YI1Q
-----END PGP SIGNATURE-----

--E1POrgl6eIEwBmCWDUfpnTvwVSU7CM6Jh--
