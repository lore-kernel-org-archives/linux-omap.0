From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Thu, 14 Feb 2013 11:09:07 +0200
Message-ID: <511CA9B3.70401@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il> <511BB113.3020108@ti.com> <511BB87E.60003@ti.com> <511C8A83.5070407@compulab.co.il> <511C8D8F.9060805@ti.com> <511CA247.80606@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3E758DFBCCAB7DD68BE6B453"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59513 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756446Ab3BNJJQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 04:09:16 -0500
In-Reply-To: <511CA247.80606@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--------------enig3E758DFBCCAB7DD68BE6B453
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-14 10:37, Igor Grinberg wrote:
> On 02/14/13 09:09, Tomi Valkeinen wrote:
>> On 2013-02-14 08:56, Igor Grinberg wrote:
>>> On 02/13/13 17:59, Tomi Valkeinen wrote:
>=20
>>>> Okay, so I just realized there's an spi backlight driver used here, =
and
>>>> that backlight driver is actually handling the SPI transactions with=
 the
>>>> panel, instead of the panel driver. So this looks quite messed up.
>>>
>>> Yep, it always was.
>>> The whole DSS specific panel handling inside the
>>> drivers/video/omap2/displays is a mess.
>=20
>> Well, that's not mess itself, it's just omap specific panel framework.=

>> But dividing single device handling into two separate places is a mess=
=2E
>=20
> Yes, you are right it is not the mess, but it prevents the panel to
> be used on other systems and that is BAD.
> At the very least, drivers/video/backlight is a generic place that can =
be
> used not just on OMAP.

True, it's generic, but does it work reliably? The panel hardware is now
partly handled in the backlight driver, and partly in the omap's panel
driver (and wherever on other platforms).

At least currently there's a dependency between the two, as the LCD_EN
gpio is handled by the panel driver, which affects the functioning of
the backlight driver. Is it ensured that the panel driver does not
disable the panel when the backlight driver does spi transactions?

That's what I meant with the mess, it's difficult to make it work
reliably. I know that for some panels such a two-driver approach would
not work at all. Although I guess it's working well enough for you for
this panel.

Thinking about it, if you do move the gpio handling to the backlight
driver, the panel driver will only handle the DPI video stream. Then it
should not have any effect on the SPI side (presuming the panel doesn't
use the pixel clock as func clock), although there's probably still
possibility for display artifacts on enable and disable, if the order of
operations goes the wrong way.

> And since the toppoly was and is used on other systems, why the hell
> should anyone duplicate the driver just to please the OMAP specific
> panel framework? The real problem is that this framework should not be

Not to please. To make it reliable.

> OMAP specific...
> Of course I'm aware of the fact that currently there is no generic
> panel framework, but forging something OMAP specific which is obviously=

> used on most of the other architectures/platforms (and I mean
> panel<->controller relations), is not a good way to go.

Well, if duplicating the code gives us reliable drivers, versus
unreliable without duplicating, then... I don't see it as that bad.

> Although, I'm also aware of the fact that most things are done this way=
:
> do several specific drivers/frameworks, find the common stuff, and extr=
act
> it into a core driver/framework. So I don't want to blame anyone - that=
's
> just the way how we do things, right?

If it was easy, somebody would've done it.

>>>> For a quick solution, can we just set the LCD_EN at boot time (with =
the
>>>> msleep), and not touch it after that?
>>>
>>> That would be sensible for now, so this series can be merged.
>>> As a more appropriate (and long term) solution,
>>> I plan on moving the panel reset pin handling to the spi backlight
>>> driver itself.
>=20
>> Well, if you must. But I suggest moving the whole panel handling into =
a
>> (omap specific) panel driver, as it's done for other panels. That way
>> you'll have a proper panel driver for it, for omap, and when CDF comes=
,
>> you'll get a platform independent panel driver for it.
>=20
> You can't just move generic architecture/platform independent stuff
> into OMAP specific framework... Just think about this... It's insane.

As I said, reliable vs unreliable. That's not insane.

But again, if you can handle this particular panel reliably with the
two-driver approach, I'm fine with it.

> In addition, AFAIR, the reset pin is the property of the toppoly panel
> hardware, so that is why I think, we should let the toppoly driver
> (currently spi backlight, later hopefully CDF) handle it correctly
> along with the spi sequences.

Yes, that sounds ok.

 Tomi


--------------enig3E758DFBCCAB7DD68BE6B453
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRHKm3AAoJEPo9qoy8lh71uF0P/2j+YSkiyMb65s3vBzBLB1Uq
H5uG1sUb/BI3eihgTVUwxiqG7ASuKY4e8+Pmy+j7K8MX8CCYWez05QuKGGl+yZo9
xiI8lZV28jv46d1kXhvm4AFhbs3RfbcNNiOCwLcr0EyjVipqT+JVsMjZ+2slVU3q
/M74F1C/W7N8MS1QKRPbtnje5/zEuTdEs2S6VeGdlX5zMhSfs09DPso1cV6wNX3C
bBYJuEcp7XCdL2qrQ27iGYLPIIrFRU4h6IsJZblmFBdAvj8EO22n4EX+wBqGnVlf
s3thsCxL9tC5Lm/PyZ/xKSh2aV7VadwY0myx7P3drS3NQJsxdrazknS6ssT1absY
JubkC1RPt8luPfDSyoAlKzvbHKOa811LHMVAzu46OfSnFaMbdi3ep/0zcq2iBVtJ
KjT6NF/UCyEPNKJvjcgQq5vQu5BNa6r/FZevRVxS0tP43kAyomLXH+/DWMhLl3sm
TdHlwEpdei/htPPPUjwWUtb0u2zQ+FKvFoCsIMXpjj/uv8nZqvLIJXsCiPpaiRtB
9xVEJ8mFIbHyy7bupZpGkP+up2L//nSLGcSdDpONhyRCJ5bnaAnR/IOZjj+CMSvD
9lDnsnddX08HbypvjPseYI6iScEdgWWcB/gkbzht1fISIINi5rGhF8GvdQaw/rtp
GrJUVYtO5owD7xwYmbXH
=DU0H
-----END PGP SIGNATURE-----

--------------enig3E758DFBCCAB7DD68BE6B453--
