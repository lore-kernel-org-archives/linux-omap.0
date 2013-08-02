From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/2] OMAP: Panda DVI fix and a cleanup
Date: Fri, 2 Aug 2013 15:52:02 +0300
Message-ID: <51FBAB72.9020108@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com> <51FB9EDB.8010600@ti.com> <20130802124611.GJ7656@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="x74nWHAQb7pXJQkaO2KUGFev5AJCoImGa"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58691 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402Ab3HBMwa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 08:52:30 -0400
In-Reply-To: <20130802124611.GJ7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--x74nWHAQb7pXJQkaO2KUGFev5AJCoImGa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/08/13 15:46, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130802 05:05]:
>> On 23/07/13 12:06, Tomi Valkeinen wrote:
>>> Hi Tony,
>>>
>>> Here's a fix for 3.11 that makes EDID read for DVI work again.
>>>
>>> I also included a cleanup patch that removes the non-DT support funct=
ions that
>>> are no longer called from anywhere. It's not a fix, but as we're in q=
uite early
>>> rcs, I thought it would be nice to remove the dead code.
>>>
>>> Up to you if you want to include that one for 3.11 or not. If not, I'=
ll include
>>> it in a board file series for 3.12 that I'll send soon.
>>>
>>>  Tomi
>>>
>>> Tomi Valkeinen (2):
>>>   ARM: OMAP: dss-common: fix Panda's DVI DDC channel
>>>   ARM: OMAP2+: Remove legacy DSS initialization for omap4
>>>
>>>  arch/arm/mach-omap2/dss-common.c | 49 +-----------------------------=
----------
>>>  arch/arm/mach-omap2/dss-common.h |  2 --
>>>  2 files changed, 1 insertion(+), 50 deletions(-)
>>>
>>
>> Ping.
>=20
> Oops, sorry I was offline last week and still not caught up on mails..

Ok, no prob. There's the "ARM: OMAP2+: use new display drivers" series
also waiting for you, but that's for 3.12 =3D).

> If you have other DSS fixes I suggest you also send these fixes:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>
>=20
> If not, let me know and I'll queue these.

I've got a few fbdev fixes, I can apply the fix to that branch. I'll
leave the second patch for 3.12 as it's really a cleanup (it's actually
also included in the "use new display drivers" series).

 Tomi



--x74nWHAQb7pXJQkaO2KUGFev5AJCoImGa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+6tyAAoJEPo9qoy8lh71VeMP/RUV3hO0D92A3k0cWwXlWMA3
0SYErq0oOb7jLyH9n8z26KBTapc9jYsNX06s8HGT0cowia0CMI4vOehBxseZvmMo
WHrpaY6Y6eM38l0+OikSdAzTC3KIENXdrEwlMQ9NfKjQ1wMLT88tzUJSRjXq5qUo
8mzgGPgkeD9H+zXLZ/M+HE6p6DuzESkhQFczvJbUNC55a26QZz+Pzq/1pJjgsqRD
S90a21Ey515GNlQWBANCuZvC18kGPkElAa51cV/h0m5DmoMlsvDLZcaaJwjI9KDJ
DTb3BSL7VSxXG/D0feDynrUTgWMOJJ8+sgHsGwtjaxI2sCWUHCV2c93/u6djESaj
TJC5IpS+e8kiDTR6D1fSOkiQ9XEcEl9+5OOqF8+76Xdt7SuOOvCBy37Jz+G3wkoq
jt8FtmvsP4cefLYZL+D9E0nwXTps9kgTiEtdUUqO+aMRU3ZuoC84sbin7frekb/Q
GhTtK1PFabX0xL4V6LT1a7DXGcKY4lyf8Ow628jH4aRU69f33PhwN+d1FrE/8+fv
Y5JbrSchBVlvL6LHWp+xhv/6jDWkp/OMbu9o1gxDLsgCRObYj43/7GTs5B4pBKan
RNLQmjgAimgudMPNFPBb/T6fNxHnfh8CXOMSkWnqWddbaSlpcsI8zav++Q98oNlp
wQFvAme14/5RWG/NXceg
=aKar
-----END PGP SIGNATURE-----

--x74nWHAQb7pXJQkaO2KUGFev5AJCoImGa--
