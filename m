From: Felipe Balbi <balbi@ti.com>
Subject: Re: Panda: USB crash with today's linux-next
Date: Mon, 14 May 2012 15:29:21 +0300
Message-ID: <20120514122920.GK22242@arwen.pp.htv.fi>
References: <1336996151.2333.3.camel@deskari>
 <20120514121527.GF22242@arwen.pp.htv.fi>
 <1336998251.2333.17.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9j9z4uig7ElIUlwi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:45231 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755880Ab2ENMbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 08:31:16 -0400
Received: by lahc1 with SMTP id c1so3577783lah.4
        for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 05:31:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336998251.2333.17.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>


--9j9z4uig7ElIUlwi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2012 at 03:24:11PM +0300, Tomi Valkeinen wrote:
> On Mon, 2012-05-14 at 15:15 +0300, Felipe Balbi wrote:
>=20
> > looks like MUSB is probing before transceiver driver... could it be ?
> > Can you check transceiver has actually probed ? I guess panda's using
> > twl6030-usb.c
>=20
> Ah. Perhaps it's then about this?
>=20
> [    0.352905] Skipping twl internal clock init and using bootloader valu=
e (unknown osc rate)
> [    0.354034] twl 1-0048: PIH (irq 39) chaining IRQs 352..372
> [    0.356079] VUSB: 3300 mV normal standby
> [    0.358123] genirq: Threaded irq requested with handler=3DNULL and !ON=
ESHOT for irq 356
> [    0.358215] twl6030_usb twl6030_usb: can't get IRQ 356, err -22
> [    0.358398] twl6030_usb: probe of twl6030_usb failed with error -22

sounds about right. Now, why can't it get the IRQ... Benoit, is this
related to your sparse irq/irq_domain changes ?

--=20
balbi

--9j9z4uig7ElIUlwi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsPqgAAoJEIaOsuA1yqREv7QP/1eHCfqTTZeyJT81qAqQaTyU
ZqMFFvoRF9pS0TMmReh8MG3umuc0xiQmt1NlkU/WPChn855BP9xnLDXEQOtcj0tY
4jWM4YUy3skzxh3tIyi+kn4yDIIt0C4Pj/9MtImNy1UKSskR/RAuubM24SBrankL
s4m8QKX4uQZcfiqyTH00+evjTGQ4lWl7uZkJj4qr3tVBkzf1rOokSM1KO2oz/CEv
EXcm/JyJHQWdBZzPEUOXcKNH89kqqclPZKfhShYvbHEDk27fNCndGE9Q8PklKzLg
+qegIxIR1e+7uGN14Vxa4HeKHuUUQFcT8Y0s2cE7kFxnB1U+uJAWMVi0yVkoBgxG
Vu82BqAvwgNPVbbTlGAKMXO5huLwEK1jvmFqoLJyczckicD86LTuEpQbE6oqMawb
1BseoLbCAvffYw52u+ZuGJ/oumGyLV/V4yUeAjk48b2vfciQvIej7i+vIU7a/5Qx
UNh6eRdyBkEdJhNg/iFdlDHQrsBULkOKMHTGXzOR1xH9OJUa9eZSMgp6GoPJ5BD5
G+lN3U6pfnN7ihp213Kg2mf3xz4hQ4IdQ1DGMM6GTsLN9DmXf1TvvX7/siG3Ten/
KOkXmg/J8dN6I/6ILlGKmehWJNZQ+6UOTuygFsKs8ANrQhR8gd/fjhme5uQ+irqp
onTN5N8CZhXFktnDFFNO
=MfS8
-----END PGP SIGNATURE-----

--9j9z4uig7ElIUlwi--
