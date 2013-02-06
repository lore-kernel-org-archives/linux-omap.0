From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Bad divider used for sysclk for DSS and ABE (CM_ABE_DSS_SYS_CLKSEL)
Date: Wed, 6 Feb 2013 13:33:24 +0200
Message-ID: <51123F84.3040101@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig60CAB2DEED0A6142E780C121"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51661 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab3BFLd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 06:33:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Jon Hunter <jon-hunter@ti.com>

--------------enig60CAB2DEED0A6142E780C121
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Paul,

OMAP4 TRM has a mention in CM_ABE_DSS_SYS_CLKSEL's description:

"Select SYS_CLK divided by 2. Must be used for
SYS_CLK > 26 MHz"

This doesn't seem to be enforced with the current kernel. OMAP4 blaze
has 38.4MHz sys clk, but above mentioned divider is 1.

I made a quick test with omapdss, so that omapdss sets the divider to 2
when initializing. Everything seemed to work fine, although everything
has been working fine with the divider 1 also. But I think it'd be wise
to adhere to the TRM.

Is this something that the bootloader should setup, or should kernel do
it (also)?

 Tomi


--------------enig60CAB2DEED0A6142E780C121
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJREj+EAAoJEPo9qoy8lh712poQAIncLFWM8QOzKpxhjOaLFZ/l
f68qXICFXQWr5djjfydWW2R0IC/J4yG5VUzZuGGh9RgzjS7rRbRGBT1as5mtvF4e
L3gitbjELg47Sleow6orhxi8EWxV97U0ynuRw0yccImnXDdL9IEPgLRNoA5/6Jze
YZUCvIxLJGP0KUgBjXBwXLVX90qqNJeU/CsIDnVGWXUhe5gTTwbKM3yi1dZxqEPi
RlIPmTLOsEe+GHDW39bnfFH7BrCyq7fAHDs9AV1ZpvvY/0DQbf168M1PCQuhvx4b
42GgDGa8FKaJlyLprZ3RSIcj3qFDEDwTFY/iTUWQwHz/jqvqLMbp0GY00zHlCgBt
EP4+HnIjGNgxHBG/Fl+ybH06/lebmRo9Gdt2uc2hgO2NeXbZZZLwpVhJaXOjvh3g
TSMIj1FFFV4Vp2ywcLyJ4dKfrp6EMpiXdpB6q2xcnm0ygZvAG2p4SHCc7i+yq0Nu
FA/3oWahK6kxI1rTCVBrE05u4Jql6gaJg5tT3jBbvdSJvdCSwbRzuobwLXvJzpyP
CwVzO56EqJHZoV7RoWwuRV4xpvxoaTkzy+SE5GhDSDD/dCnoyBTIpm/jO49rPrFD
mPn4xYwH03FveGECd9YPyZiPX9QQTnlIvtvWQSzE7ceYl520PnCrvQ5gM7pkfk0W
jQXPe7OCAdO/vr4Y5Q3v
=Gwzd
-----END PGP SIGNATURE-----

--------------enig60CAB2DEED0A6142E780C121--
