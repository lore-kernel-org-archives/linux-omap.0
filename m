From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Wed, 13 Feb 2013 17:28:19 +0200
Message-ID: <511BB113.3020108@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig72DDD45D03F23D0E27289D19"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43341 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758942Ab3BMP2Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 10:28:25 -0500
In-Reply-To: <511BAE50.2090507@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--------------enig72DDD45D03F23D0E27289D19
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-13 17:16, Igor Grinberg wrote:
> Hi Archit,
>=20
> On 02/13/13 16:21, Archit Taneja wrote:
>> The cm-t35 board file currently requests gpios required to configure t=
he tdo35s
>> panel, and provides platform_enable/disable callbacks to configure the=
m.
>>
>> These tasks have been moved to the generic dpi panel driver itself and=
 shouldn't
>> be done in the board files.
>>
>> Remove the gpio requests and the platform callbacks from the board fil=
e.
>> Add the gpio information to generic dpi panel's platform data so that =
it's
>> passed to the panel driver.
>>
>> Note: In cm_t35_init_display(), the gpios were disabled, and the LCD_E=
N gpio was
>> enabled after a 50 millisecond delay. This code has been removed and i=
s not
>> taken care of in the generic panel driver. The impact of this needs to=
 be
>> tested. The panel's gpios are also not exported any more. Hence, they =
can't be
>> accessed via sysfs interface.
>=20
> Indeed, there is an impact - the LCD no longer works.
> The reason for the LCD_EN gpio being pushed high after the 50ms delay,
> is to get the LCD out of reset, so the SPI transaction will succeed
> and initialize the LCD.
> Now, when you remove the gpio handling for the LCD_EN pin,
> the LCD no longer works.

So between what is the sleep done? It's not clear from the code. LCD_EN
needs to be 0 for 50ms, or...?

If the panel requires specific reset handling, does it work right even
currently when the panel is turned off and later turned on? The msleep
is only used at boot time.

 Tomi



--------------enig72DDD45D03F23D0E27289D19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRG7ETAAoJEPo9qoy8lh71VpwP/iuvdTTdyKqsslQfy0+CuTAC
cNeej/IQ2FY7kMyDC/N1FGbbF+62vb/SXEwc4rYqpOcnF/nEuyBKXMhdvoG+4YkY
au1J+PYQvok2Vqc6gW3WZ9buCTxdKECgybdjJR0lIrjiAmbA8T7PogSXJXJVnVU5
YeDKgN2gLyOLW+cr6cUFpap8faxVLOJHkGOBBSDdHwIo/MrwxzZdGGCHigpz6/P9
t7I/kR9E/3NI+iAeuSyw/Va8EybusHB5JGlhocb6ecYH1Rj93E1J2csbKBFE5JyQ
p6PjNmWt2B7EgZKpLRNuJ2SWlJ6Y0QEgklNHQgto32cQIzXNNi8HPqMuPUXAEUvX
hvk3TcOMv6yoxrC24XiazHj69sNSquNG+TSvlPrqWyo8812IFGCq46nSVo4tWVnP
HwHma04IlWaKGxlrsM+Ka9iPw1zaoxBi8LZFVvrXlY61FwaEQ9Tjnxf/wr3X1zcT
DBbbF/01zyg8hQjPSMa1MkFLrl/Sq06DuqZ0Y9YbtjEMESmvBd2hSuQ6KLtnKMRH
W8X20iLdbBASJEWxwSloocMjUHEW+NHaOoUKAybUWExTgFrweHF+qIfF86IOp07u
ALwRSu1j2qPKi03oH37v/lJ5hIeLQoqPBt0WDGKmb959iCR1NUtWNZMUa3h3jZiA
mkmLV/sN1qan4gxknC8Y
=6c8L
-----END PGP SIGNATURE-----

--------------enig72DDD45D03F23D0E27289D19--
