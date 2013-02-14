From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Thu, 14 Feb 2013 14:52:34 +0200
Message-ID: <511CDE12.60701@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il> <511BB113.3020108@ti.com> <511BB87E.60003@ti.com> <511C8A83.5070407@compulab.co.il> <511C8D8F.9060805@ti.com> <511CA247.80606@compulab.co.il> <511CA9B3.70401@ti.com> <511CB1B3.80605@compulab.co.il> <511CC37C.3020706@ti.com> <511CDA91.1050300@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBFA50BDBB5C7B9739AF30930"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38704 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934271Ab3BNMwj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 07:52:39 -0500
In-Reply-To: <511CDA91.1050300@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--------------enigBFA50BDBB5C7B9739AF30930
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-14 14:37, Igor Grinberg wrote:
> On 02/14/13 12:59, Tomi Valkeinen wrote:
>> On 2013-02-14 11:43, Igor Grinberg wrote:
>=20
>>>> True, it's generic, but does it work reliably? The panel hardware is=
 now
>>>> partly handled in the backlight driver, and partly in the omap's pan=
el
>>>> driver (and wherever on other platforms).
>>>
>>> It works reliably on other platforms, but not on OMAP - because
>>> we need to cope with the OMAP specific framework...
>=20
>> How do you handle the gpios on other platform? Those are the ones
>> causing the issues here, right?
>=20
> Well, I'm also talking about something that is a history already.
> Remember, we had multiple panel drivers inside the
> video/omap2/displays and then they were consolidated into the
> "generic dpi/dsi/whatever".

Sorry, I miss the point. Was that a bad thing? Didn't it simplify the
task for you with simple panels? It could've been taken even further,
though (see below).

> And yes you are right, on the platforms I'm aware of, the GPIO is not
> handled. Apparently its hardware default (pull resistor) is always on..=
=2E

Ok, so the simple fix of setting the GPIOs only in the board file is
acceptable for now.

Can the LCD_BL_GPIO be handled by the omap panel driver? Otherwise the
backlight will supposedly be always on. Is it just a simple switch for
the BL power, which does not affect the SPI in any way?

>> Or is there something else with OMAP DSS that you need to specifically=

>> cope with?
>=20
> The fact there is a need to create a OMAP specific driver.
> I'm not talking about the generic driver which only needs to have the
> controller specific data (e.g. porches, pixel clock, bus width).
> The generic driver was one of the good ways to go.

Well, we could also have an even more generic driver that takes the
video timings from the board file as platform data. Then all you would
need to do is to define the timings in the board file, as I think is
done for other platforms also.

I'm not very fond of that idea, as I think hardcoded device specific
data should not be given as parameters, but they should be handled by
the device driver internally, as it should know that device specific
data already.

But, in practice, making this kind of even more generic panel driver
will probably make life easier for everyone, so I think we'll have one
with CDF.

 Tomi


--------------enigBFA50BDBB5C7B9739AF30930
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRHN4SAAoJEPo9qoy8lh71JtsP/1xFl0U7eDhjAbodcSm8t+E4
tzAMWbfxzj3R/nF2mwIxsVjMy20+kCh9l5brVkn/iBsvv4dAzLNN3t9irFsrmnlI
jBcfjDYhyR24i6mK5b3+pXtiQ+Vi343m5CUuD20NXj0ve44sQBsLBy/kKfLtKwbl
PRVtYueTYGtRTWtjZIGxwExeTDhbugIKnxAhS7HfxKnUXx7zgAdD/sjSrY608UFk
ueY3w7jJTiwwX9f7yrsPMbLZbPpw8IrBY2l5XAf/Q/tJci20I2lWFmdCdxLF+oyH
X/vF/cAeamFrrNVP+YLlF0r9Zho6v47xWtBTUdYrU64kFxSZ15pVHSS8Y05ZpvZl
U+oh0SrnPiaOq2krskQFJ+IX89BGuVzt2aa/TmDKkrsyPhQXSNj0yI5YmxLCPhGz
rOkOoGoyJVn/X7Z0TXUpyOLLVhD+LCd+voYtcKJ6Z4S2myjU2k5Dk6ma7Ua1dfo+
ARlEIqgSiGhxEfNT2yfAv0qHx9Vt7eSyElu6b7GU69WKSSf5DNcC8qYSRrh/XqSb
j9O8s5BZs5MCaa8p82mk+YBMYBVBvMPBBD8QtVl03ni6vr1nSGrtRxqJsdYzEe9n
2QZfEES/vkVK4DkYZvP6eRErqeWBYw+43+dXkukc9rr7EAFAGIh7K/mc22tinAym
hzXsjdYi+YaaQZnx9awt
=ySsO
-----END PGP SIGNATURE-----

--------------enigBFA50BDBB5C7B9739AF30930--
