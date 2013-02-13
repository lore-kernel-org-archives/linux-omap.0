From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Wed, 13 Feb 2013 17:59:58 +0200
Message-ID: <511BB87E.60003@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il> <511BB113.3020108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8F7467E38DAD39865B469EDB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44954 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934209Ab3BMQAD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 11:00:03 -0500
In-Reply-To: <511BB113.3020108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--------------enig8F7467E38DAD39865B469EDB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-13 17:28, Tomi Valkeinen wrote:
> On 2013-02-13 17:16, Igor Grinberg wrote:
>> Hi Archit,
>>
>> On 02/13/13 16:21, Archit Taneja wrote:
>>> The cm-t35 board file currently requests gpios required to configure =
the tdo35s
>>> panel, and provides platform_enable/disable callbacks to configure th=
em.
>>>
>>> These tasks have been moved to the generic dpi panel driver itself an=
d shouldn't
>>> be done in the board files.
>>>
>>> Remove the gpio requests and the platform callbacks from the board fi=
le.
>>> Add the gpio information to generic dpi panel's platform data so that=
 it's
>>> passed to the panel driver.
>>>
>>> Note: In cm_t35_init_display(), the gpios were disabled, and the LCD_=
EN gpio was
>>> enabled after a 50 millisecond delay. This code has been removed and =
is not
>>> taken care of in the generic panel driver. The impact of this needs t=
o be
>>> tested. The panel's gpios are also not exported any more. Hence, they=
 can't be
>>> accessed via sysfs interface.
>>
>> Indeed, there is an impact - the LCD no longer works.
>> The reason for the LCD_EN gpio being pushed high after the 50ms delay,=

>> is to get the LCD out of reset, so the SPI transaction will succeed
>> and initialize the LCD.
>> Now, when you remove the gpio handling for the LCD_EN pin,
>> the LCD no longer works.
>=20
> So between what is the sleep done? It's not clear from the code. LCD_EN=

> needs to be 0 for 50ms, or...?
>=20
> If the panel requires specific reset handling, does it work right even
> currently when the panel is turned off and later turned on? The msleep
> is only used at boot time.

Okay, so I just realized there's an spi backlight driver used here, and
that backlight driver is actually handling the SPI transactions with the
panel, instead of the panel driver. So this looks quite messed up.

For a quick solution, can we just set the LCD_EN at boot time (with the
msleep), and not touch it after that?

 Tomi



--------------enig8F7467E38DAD39865B469EDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRG7h+AAoJEPo9qoy8lh71CI8P/RMP4RheaGqbNZKW9gEWk8KJ
2LVpV7NrZOVSgXfpOHUwL6mfxu4+0ePnBhho/pVjISQp/bU3Cq064Cb6De6eMh2l
o1KgQVcGHzDA+QEWZo2EZel6o71U4E9ONPrmCaLhhDJZvQ23ZE/r6kIUZGzQa887
V5IssXSfiE53eEN4o/S/nbL12fsu0d/1HU8SsFUct5V7RgyY1IBX7ppDl8l6P+5P
B6LXFa42on+3JmgklkJw6FVL/IgpnVzfL0XlOf+vM04/jjfRLF5MXmkv6RZKnnEb
JvkUwzHPeW6p/6OMpuY6qgi4UQgjN8r6YXYkoEmYmdVX9f9T0M+NuuMXuJXy2DZD
+tha4Evajt5rNUZH9OLo5NCajc1IeGhDGKyXV8RX3tqf/c05qwzXZKtKjWkZLIBb
u0l4RUKy+iSS6FKaPlgusGtudwBshTGCEkj/+WCm5zVrBxnr+JKtn3S3adwfQYXO
bTvckcJOG1JvBbr5GkaX2VQfl93ly8/4ckZJE6D6qdaS88OSsbtfrokDuxentoeE
jW9PC3rVKGfffyYTkw7tsNEQ7DZrqPZixtzpn5QkzP261mebrDoiJkJCzw0xOTtK
nBTqrLWHRz1R6A3wQRUyl8D5lEmY/3H8zRM8pvm4fgrWRu9qzVUAn6e0umwRE8cB
5cOx8O6J5lA7d5DLXqhX
=uqHj
-----END PGP SIGNATURE-----

--------------enig8F7467E38DAD39865B469EDB--
