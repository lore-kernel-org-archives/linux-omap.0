From: Felipe Balbi <balbi@ti.com>
Subject: Re: rts-gpio DT binding
Date: Wed, 19 Mar 2014 09:59:58 -0500
Message-ID: <20140319145957.GB27752@saruman.home>
References: <20140318165536.GH14373@saruman.home>
 <53287CAF.9040708@newflow.co.uk>
 <20140318171110.GI14373@saruman.home>
 <53296017.3090104@newflow.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53469 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965211AbaCSPBq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Mar 2014 11:01:46 -0400
Content-Disposition: inline
In-Reply-To: <53296017.3090104@newflow.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: balbi@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 19, 2014 at 09:15:03AM +0000, Mark Jackson wrote:
> On 18/03/14 17:11, Felipe Balbi wrote:
> > On Tue, Mar 18, 2014 at 05:04:47PM +0000, Mark Jackson wrote:
> >> On 18/03/14 16:55, Felipe Balbi wrote:
> >>> Hi Mark,
> >>>
> >>> I'm looking at the omap-serial driver and saw that you added rts-gpio
> >>> binding in commit 4a0ac0f55b18dc297a87a85417fcf068658bf103 (OMAP: add
> >>> RS485 support) but, as it turns out, gpio0_13 and gpio2_15 are both
> >>> actual RTS signals.
> >>>
> >>> Instead of adding that extra GPIO handling, why didn't you just mux
> >>> those signals as RTS and enable auto-RTS/auto-CTS feature ?
> >>>
> >>> It looks to me like that's highly unnecessary binding.
> >>
> >> I agree !!
> >>
> >> I think it was to allow delays pre- and post- sending the comms data.
> >>
> >> Several RS485 drivers require a "warm up" time before they will
> >> transmit data correctly, and also need a "cool down" time to prevent
> >> clipping of the last few bits of data.
> >>
> >> IIRC the built-in RTS handling did not allow for this.
> >=20
> > you might be right here. I can't find anywhere to write rts delays.
> > Weird... digging TRM.
> >=20
> >> It also allows the RTS signal to be "inverted", again required for
> >> some RS485 driver chips.
> >>
> >> However, I'll dig into why I did this and report back.
> >=20
> > cool, thanks
>=20
> Okay ... it comes back to me now.
>=20
> When using RS485 drivers, we're not actually using RTS as a "Ready
> To Send", we're really using it as an "enable RS485 driver".
>=20
> I just used the "RTS" mnemonic as "we're now wanting to send some
> data so please now enable the RS485 driver", rather than the normal
> "I'm ready for your to send me some data".
>=20
> So it's the opposite function.
>=20
> Maybe it was a poor choice of abbreviation ?
>=20
> As I said before, RS485 drivers might have active or active low
> enables, so we might need to invert the "RTS" polarity.  This is
> not handled by the hardware RTS signal.
>=20
> Is that a good enough explanation ?

fair, but considering you can toggle RTS by hand with writes to MCR
register, I still don't see the need for remuxing the lines as GPIOs.

Just don't use auto-RTS and toggle the line by hand with MCR, no ?

--=20
balbi

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTKbDtAAoJEIaOsuA1yqREhe4P/2ibP2HLW1Qc0AFFmKci/JVY
Fq7mGgiFvR/L5ltf2vxdCzHmXvciQh5hkMClT1Zl53yq443KePFjit8mEVeYbXwl
BeSnkpH0wfqcwuNz7LPx1YeHx0aOrePBGJXox3R6sqiWexzJhYYfruKtV7auY37n
10lBRyZwPz1akebbhzStSUGM+3VGAuEI1Ma4Pn4DpZxqdWd512H8mq3fuvhPTGk4
vK4awUd9JCpeIKbIrECVgpwuVJdQ+SseYIblTF/AODDR25UhJFC5Y+ylK+xyUKm2
a5PMeAwT9yNC9BNLhc83eLfUFG/ikb/DeS/uxTZi8agUMOzBSewCIlro3oBi3onI
s8DYMs3eC/fg1pmTa3MmNHYBxT1c1yUKJJTQwtdkTt1fTnhYxUFuTTk20KsZ+vB6
vdEnZwXzNN+Cuujkbe3Mxe6T/Jzg9ykWWIRjj0A4B1+t8oTEbOZ8a9pETOMXUAvk
d6bJly/T1/YQ/hrD2c6trehMzOqm21M3KbRBHWYQidPtRPsJzj9RHwvDefN8+fS9
womHCCjqrqtnQwez/ku7BlmyLPYTpVLWtHtNJMCFY7Ly8XAuFLECYFXFjp2CwblQ
K2Qp+rKefu+dTFemfRrL49kVmmogINoKggaXkoGF0Jws7MRT+63KTDegxSH525jA
XXTrzLtM0HY9byOe6jgp
=gILk
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
