From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Thu, 29 Nov 2012 16:31:47 +0200
Message-ID: <50B771D3.8050907@ti.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com> <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com> <50ADE6A5.3030001@ti.com> <CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com> <50AF37EA.3080400@ti.com> <CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com> <50B4A4D7.2070203@ti.com> <CAGDS+nmaGK1igkYnz0EQEycUU=LsD5yz9wxmipSnWohKvAPTXA@mail.gmail.com> <50B74592.3020308@ti.com> <CAGDS+n=oQYr+24mX6bdgtW=fzvfvfX5rAvNXXpxM4YKPxHDodQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9F6AA889AFC061B5EFDB7FF6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52300 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754673Ab2K2Obw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 09:31:52 -0500
In-Reply-To: <CAGDS+n=oQYr+24mX6bdgtW=fzvfvfX5rAvNXXpxM4YKPxHDodQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

--------------enig9F6AA889AFC061B5EFDB7FF6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-29 16:18, Steve Sakoman wrote:
> On Thu, Nov 29, 2012 at 3:22 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>> On 2012-11-27 21:15, Steve Sakoman wrote:
>>> It seems that dss_mgr_check_timings is being called with a null dssde=
v->manager.
>>>
>>> Other than the fact that there should be a null pointer check in the
>>> code, it seems that this is a regression since it used to be possible=

>>> to switch the default display in this fashion.  Is this no longer
>>> allowed?
>>
>> It is allowed. Which kernel is that? I tried v3.7-rc4 and the current
>> omapdss master, both work for me with overo + lcd43 add on.
>=20
> It is stock Linux 3.6 (i.e. commit a0d271cbfed1dd50278c6b06bead3d00ba0a=
88f9)

Still can't reproduce. So does the null pointer deref happen at boot
time? What display related kernel boot options do you have? This looks
funny, considering lcd43 is a bit smaller lcd:

[    3.483062] fbcvt: 1024x768@60: CVT Name - .786M3-R

 Tomi



--------------enig9F6AA889AFC061B5EFDB7FF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQt3HTAAoJEPo9qoy8lh71bKYQAK3zmyW1eL04IIFK69maqubQ
kob3nrDGJ2ae9S6CKt7M/wu9LA64irhmmlbzSufuLDjjPlPBMP7j1L6MkQY6Iqi8
lK3KlV+OroXtrys6ZNDDfd4Vd920tgQPVr+eBewQM8NZbuw2yYdMswVYuD44qBVa
RpsEpL73CpBSJfwqp6U+2MPc77C3aWJep/MTVM6kaaxbX8CZSggfdzEFHzFM02oy
9LZ4huvF4ZZ9jXDcdidUGldHvPH+UBusq4jEHY3Bk51BmqLacNW3fVDO4vKaJDIM
oaPi15ytbpeti0ryEX7ZKTT8yUh7gNPZJ3wSCl0BKwAyAovuuflDL1LZMm0NlxDB
ZH2cWgNDAKZsP4tXrI6bktU/so/OvSXFJy2w0SVBGVThj/wzUmKBAWIzToDwVxfn
efk0EzHv23BIMr7cdsbdQzsa3Lg1oVjbkYawRmJIZJdMSFzWSHcIA8NXWZpxH63/
AVlCZyS+WBDoIX83jrNuqxg927/iOVekta3u19Rt05bPPJpLKsGlP/SSb/Ft9IBg
TtTga53YiEZ6N7M2SeC/uLXq76ZLadT4WYxfaViBfI978ZWJbWA604swJj0aXKU8
x3TqHMR77vqqpDpL2GIAb8vt9K14M1/9k5ecdOx3zN32vna9iApw7LCtiT+GACWf
OvSeZhz8XP/svcImr0Ez
=90QJ
-----END PGP SIGNATURE-----

--------------enig9F6AA889AFC061B5EFDB7FF6--
