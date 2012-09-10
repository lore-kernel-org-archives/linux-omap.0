From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.6-rc5
Date: Mon, 10 Sep 2012 08:51:20 +0300
Message-ID: <20120910055118.GA19264@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1209091743430.28047@utopia.booyaka.com>
 <alpine.DEB.2.00.1209091814380.28047@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:59649 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810Ab2IJFzu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 01:55:50 -0400
Received: by lbbgj3 with SMTP id gj3so942570lbb.19
        for <linux-omap@vger.kernel.org>; Sun, 09 Sep 2012 22:55:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209091814380.28047@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andreas =?iso-8859-1?Q?M=FCller?= <schnitzeltony@googlemail.com>, grinberg@compulab.co.il, Sourav Poddar <sourav.poddar@ti.com>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 09, 2012 at 06:15:04PM +0000, Paul Walmsley wrote:
> > * 4430ES2 Panda: UART corruption during long transmit buffers
> >   - Presumably due to either a missing hardware workaround or a bug in
> >     the OMAP serial driver
> >=20
> * 3730 Beagle XM: does not serial wake from off-idle suspend when console
>   UART doesn't clock gate ("debug ignore_loglevel")
>   - Not shown in the current test logs; cause unknown

How do you trigger these two ? Can you share whatever script you wrote
for this to fail ? I'm assuming the bugs are only triggered on those two
particular platforms, so it could just be missing workaround on both
cases (?)

--=20
balbi

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQTX/WAAoJEIaOsuA1yqREILkP+wSDPP8KHwyS3uoCZvoKCsUl
Vr2FiAxj3noUrx6o4U21ASSxKAD6c96gJsbq1saGWOBsWO3BgypuMB1Jb4E3UQsm
p/sHdmgles/Q3jGiqMpGWC/9lQzaPehnd+/AZwdB6Akt4mNPJoiBMqDtAfd5Bf9R
C42oTasvvV8F2FLSIx42beLEg+3uCq1ASiXjcpkb0/ZbyYw7yXr77cjhF9ok0gSk
IzMBoO8Fe/CjaGGxlzRIkOYBjzNelAH10fGTNcy7LmA+OobL7gUGu3a0ge4CB5Ts
9D9OhL1gOcu2L2HU+G2cbGluviDUmj18V0O5rCM8SrYD4YgXIEvVhH14dK57Hwu3
VrOrUMaIwlzDreB5KsS+XStfA6W4s6EQoMM20TMfFqwimYbFfoLl9qX7lt1X6ZKt
VbpYWs9pDg1lUP3QuaDeV62b2cTZF80XT7FoF+stqimLvgK5rSgvxwYKE842XJ3N
5yqVFWHquVpzKbz7PZ7kReDzX/83fFZmQQzeFpkuef/Rb9d5i7PlG2b6hlfh0IbA
GeNTI4bBhgw7wDG8ek1tF9CkBw5Gh2k60S4L7vwIztl3zUlnspf8qc1hPoqd83mE
CG6egsm5n+rmO2RzTOQ5gZWB3RFffqUZ8hVI/1uVmGm5u5UTw5CNNQEHpY0XtxtB
xs/ZSnheuNqIiPq2mp5t
=yGKw
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
