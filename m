From: Felipe Balbi <balbi@ti.com>
Subject: Re: rts-gpio DT binding
Date: Tue, 18 Mar 2014 12:22:38 -0500
Message-ID: <20140318172238.GK14373@saruman.home>
References: <20140318165536.GH14373@saruman.home>
 <53287CAF.9040708@newflow.co.uk>
 <20140318171110.GI14373@saruman.home>
 <20140318171841.GJ14373@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OX2aLCKeO1apYW07"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50538 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947AbaCRRY0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2014 13:24:26 -0400
Content-Disposition: inline
In-Reply-To: <20140318171841.GJ14373@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mark Jackson <mpfj-list@newflow.co.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--OX2aLCKeO1apYW07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 18, 2014 at 12:18:41PM -0500, Felipe Balbi wrote:
> hi,
>=20
> On Tue, Mar 18, 2014 at 12:11:10PM -0500, Felipe Balbi wrote:
> > On Tue, Mar 18, 2014 at 05:04:47PM +0000, Mark Jackson wrote:
> > > On 18/03/14 16:55, Felipe Balbi wrote:
> > > > Hi Mark,
> > > >=20
> > > > I'm looking at the omap-serial driver and saw that you added rts-gp=
io
> > > > binding in commit 4a0ac0f55b18dc297a87a85417fcf068658bf103 (OMAP: a=
dd
> > > > RS485 support) but, as it turns out, gpio0_13 and gpio2_15 are both
> > > > actual RTS signals.
> > > >=20
> > > > Instead of adding that extra GPIO handling, why didn't you just mux
> > > > those signals as RTS and enable auto-RTS/auto-CTS feature ?
> > > >=20
> > > > It looks to me like that's highly unnecessary binding.
> > >=20
> > > I agree !!
> > >=20
> > > I think it was to allow delays pre- and post- sending the comms data.
> > >=20
> > > Several RS485 drivers require a "warm up" time before they will
> > > transmit data correctly, and also need a "cool down" time to prevent
> > > clipping of the last few bits of data.
> > >=20
> > > IIRC the built-in RTS handling did not allow for this.
> >=20
> > you might be right here. I can't find anywhere to write rts delays.
> > Weird... digging TRM.
>=20
> hmm, you can change RTS value manually if you don't use auto-RTS. Just
> write MCR BIT(1) to toggle that line.
>=20
> The "warm up" time you mention, however, can be coped with by means of
> RX FIFO trigger level. TRM mentions that far end could send another byte
> after RTS has been deasserted. So if we set RX trigger level to always
> have room for one extra byte, then we will never loose data and the
> "warm up" time is probably negligible.
>=20
> Am I missing something ?

another small gem hidden in the TRM:

	"You must ensure that TCR[3:0] > TCR[7:4], whenever auto-RTS or
	software flow control is enabled to avoid a misoperation of the
	device. In FIFO interrupt mode with flow control, you have to
	also ensure that the trigger level to HALT transmission is
	greater or equal to receive FIFO trigger level (either TLR[7:4]
	or FCR[7:6]); otherwise, FIFO operation stalls."

so there are quite a few things needed to get this working properly.

--=20
balbi

--OX2aLCKeO1apYW07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTKIDeAAoJEIaOsuA1yqREkyYQALQ2+XTeslfqQXRpFJ3b6Mq/
KJaGa0JvOhqWd4qGlNfEe1bac9kNyxZzJQM7+8gC+CHVHuYmmMmdtxD0AVXCuARf
WR9ybHvqV5MswyAP72rboeRtHlxhJunLulMPo48yb1JA2d5wG1uxdPgI389Z6TIm
CJ+ykSfTKuilB6gUbmiGmqXMY9ndy9aDXddi0iPdl9nuETwJx6hKbT7vXIlf1jR2
VmvQpTe4KHl4c/GCETxUiW8TRtNMf60nBt2FH1A6XOMfRcCzuXCUXE7+3UTQ6fxk
uxi/YEHupWBV6E0jguXhGvorqj3l1rzOcbaxlaueYWPEQHSX+8uR9WMlOTuRKedQ
f+k9R3KuWTHe0MXXlZAGaL49PY2ujC6LvJHDlJK0xrLrLbGEzQB3rx1R8bTP8I4J
Q7iRJOgwiEVbyPic5o1Q2cP8cXJV2AtJI1A1X5K/ktnk8VJAnbgBlxFw5BUKd612
+vBHx+s41WX846ow5DxgzNdfut1hS3axAe5jRd+JynUJCooZmV/cxvz8cyS8rVkN
ZlTLb4vB4nZj5cp264X3s9UMShDlFCKuiI83jXwSXCxUKFf2OGJg4QhdZeeftcMs
5al0aDtMdgfjPopu+eGkGworXRfjlQrGHZJnj9HswAnUebchy4BKvzDfe3PxFCoV
Zf1JVXvxksSz00VAT03y
=1nAE
-----END PGP SIGNATURE-----

--OX2aLCKeO1apYW07--
