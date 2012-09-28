From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Converting vrfb.c
Date: Fri, 28 Sep 2012 15:04:07 +0300
Message-ID: <1348833847.2437.36.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-MTJT/0hLbu2IOqnvssYs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:35602 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222Ab2I1MEN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 08:04:13 -0400
Received: by bkcjk13 with SMTP id jk13so3252869bkc.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 05:04:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>


--=-MTJT/0hLbu2IOqnvssYs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm a bit at loss how to deal with drivers/video/omap2/vrfb.c.

VRFB is part of the SDRAM controller on OMAP2 and OMAP3. vrfb.c uses the
following functions from sdrc.h:

omap2_sms_write_rot_control();
omap2_sms_write_rot_size();
omap2_sms_write_rot_physical_ba();

There are no other dependencies to the sdrc.c.

Those functions are quite simple:

void omap2_sms_write_rot_control(u32 val, unsigned ctx)
{
	sms_write_reg(val, SMS_ROT_CONTROL(ctx));
}

void omap2_sms_write_rot_size(u32 val, unsigned ctx)
{
	sms_write_reg(val, SMS_ROT_SIZE(ctx));
}

void omap2_sms_write_rot_physical_ba(u32 val, unsigned ctx)
{
	sms_write_reg(val, SMS_ROT_PHYSICAL_BA(ctx));
}

vrfb.c is in turn used by omapfb and omap v4l2 driver.


So... Should I just remove the sdrc.h dependency and make vrfb.c ioremap
those SMS registers itself? Those three registers are VRFB specific, so
they are not used by anyone else. In that case I'd need to pass the SMS
base address to vrfb.c somehow.

Or should I have some kind of platform data passed to vrfb.c, which
contains func pointers to the above three functions?

Or should vrfb.c be moved into mach-omap2/? But then how would omapfb
call it? Passing vrfb functions as pointers in omapfb platform data?

 Tomi


--=-MTJT/0hLbu2IOqnvssYs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQZZI3AAoJEPo9qoy8lh71axgP/jFN6nc41/7Lb35K4gOzrLzl
55ehVXeUcBPraFdHw3EPjqmzmaIsEQk1KRdw/yfFmkNxqziETuVrJerKqNQ9RrUY
bYo+cC0wjnADxFAQcSFGTD17wj+JdX0trj9KqtdIoA74RgJ4k4zhzKp7XN8VSQSn
6HnMGHODflCLnLLeIblpaYXcKYnonCn5Cvp2cYNDUwld4fbiLude5/C6K9X/hilN
WvNQg00+7byUra9LUtqulPquHHpijF6CqfdYbpZbl56LZ0dc1ptV/CDxD3M6NWzL
kSX3gvbNRhRKDHTWerBBIQAE88QguC9dJ4L5bbYjkuHylw5PT3bwSC4Yf1qtPTVp
WNjDAleXNzn1ubK4DOcqaIXE0wTGw4YaernmZNlwTI5W8hcysZepHXfxCxFvwG2Q
UUZmw+VUlTVzh1sCr+N2sSSaGS3F+Qi8CjCIiU/71Ck+GdUKqVEL99BWArrvT7P4
gY2e7tNmJMIb1THDyG6Es14glP1broNQCk6nkBkHM9blo4K5auujcT/eIFAav9An
mn2h1Uy+IxUoKSbmP3bJvA/tF2sIp8t4Sq6am9QYEN+VWqD5xTbDktYftjR0WOoT
La3uaEJ0Q+1x6JuFlmJzhncrR5kyAID1SnKekKs8Q85Ya6qQeesMrXs0JHR2gDPv
TmBhL3SJ+IW7c3QRG0mf
=zv7x
-----END PGP SIGNATURE-----

--=-MTJT/0hLbu2IOqnvssYs--

