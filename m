From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Strange OMAP3 LCD display regression - bisected.
Date: Mon, 3 Jun 2013 10:24:18 +0300
Message-ID: <51AC44A2.8050605@ti.com>
References: <20130602165019.655da2eb@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2SANKJBUOVPINTRSBFKCW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40232 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418Ab3FCHYZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jun 2013 03:24:25 -0400
In-Reply-To: <20130602165019.655da2eb@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>

------enig2SANKJBUOVPINTRSBFKCW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 02/06/13 09:50, NeilBrown wrote:

> The details:
>  I'm currently trying to move from a 3.7 kernel on my GTA04 to a 3.10-r=
c
>  kernel (hopefully to have 3.10 fully working by the time it comes out.=
=2E).

I presume the panel driver is not in the mainline? Is there anything
special with the panel, or is it just a "dummy" DPI panel that doesn't
need any kind of configuration?

>  Once I got it compiling and booting I found that while the display wor=
ked
>  perfectly at boot, after it has been turned off (ioctl(FBIOBLANK)) and=
 back
>  on again, it is all white - no discernible image at all.

I'll try blanking on my omap3 board with 3.10-rc (I think I haven't
tried it). Did you check if the DSS hardware lost context (visible from
the PM counters)?

>  A suspend/resume cycle at this point might bring it back, but it is of=
ten
>  shimmery (low vsync?) and once it had inverse colours.
>=20
>  I had noticed that the panel which normally gets a 22153 kHz pixel clo=
ck was
>  only getting a 21600 kHz clock.  This turned out to be due to the fact=

>  that dpi_calc_dispc_cb rejects odd divisors, and it used to use a divi=
sor of
>  '3'.

Normally panels should not be that picky. In my experience the pixel
clock has to be very far from the nominal, until the panel start to fail.=


However, the code in dpi_calc_dispc_cb only rejects odd divisors, if the
pixel clock is greater than 100MHz. So I don't understand how you're
seeing it affect here. Are you sure the pclk is ~22MHz?

>  I tried reverting the "OMAPDSS: fix TV-out issue with DSI PLL" patch f=
rom
>  3.10-rc as below, and it seems to behave better, returning from blank
>  properly. This is without disabling the "no odd divisors" code.

Odd, indeed. Without reverting the patch, the DSS uses a clock from the
PRCM as func clock and for pixel clock. As the common clock framework is
somehow involved in the breakage, maybe (pure guess) something related
to the PRCM clock is configured wrong.

And with reverting the above patch, DSS uses DSI PLL for fclk and pclk,
and DSI PLL in turn only needs sysclk, so maybe the possible problem
with PRCM doesn't affect this case.

 Tomi



------enig2SANKJBUOVPINTRSBFKCW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRrESiAAoJEPo9qoy8lh71yvkP/0Nvf74Tti+UMonPiqt0ZVJD
EEdDjjlldykE0Gyi2zb9EdX0qk/3z6VC1alswSeZJb3anvkF2TVjoXmmL7BB8WY0
Lnr6/iUJ3zVt2jp6OfcEUMc6F82SzWkxDRZcUb6eMN3pjMumKP3n5OWqety6HH6f
WWtUaA/D9GUxUDWQ1FWxlsmROLMaoHW21mkv/0MyRZhJi0c+lru5XG65McjELK0e
/ZsuMsBzjinD5ZtsBuQoSHw9rmsrWIFQsY+qGZzs9NNcIx0pSse/tE2V4VfAN+Sd
zrNQUGnLOabz/JxnBQGTFvK30mp6kReGkRzQsBDJTAmuI9uCwANgbHcJgYRd/4iN
mfnlk7ZB8j/WBkaQPT9e2FOWX1wcBIadpmJKr0URRpg1uu5y4Y7sBqKrkL1Ntgcw
4iWTLahL8AwlLofpiTjqNXc1RZtu0OT1QIGXILsTkTcCO8sCIDkqJ3AiTa6ewyP+
yQMFE0rRszMpiP7V4yyXFbBgVx/VO5SnV3650oWrf60TJ+9TiaA0+TtB3RSTbYGj
TlVJx70FyNZnzyFu+awqEH3Hg22zDSijesFJiRQt3973AEYclfcAy/0r/MIJGJ5S
qh82Lc3xjTGflbutdKv6p7c4sZ757p1EXIRjPAO8/R6vkM9CbTtxueZhMBYrs2f4
abatdTQ7g9zW5Cn/0DHP
=naoJ
-----END PGP SIGNATURE-----

------enig2SANKJBUOVPINTRSBFKCW--
