From: Felipe Balbi <balbi@ti.com>
Subject: Re: USB problem on beagleboard clone
Date: Fri, 14 Sep 2012 16:09:07 +0300
Message-ID: <20120914130905.GB21130@arwen.pp.htv.fi>
References: <5448984682E7954C9BFF27F747A9C6CA56E2C8@dolphin.TIGRIS.local>
 <5448984682E7954C9BFF27F747A9C6CA56E2CA@dolphin.TIGRIS.local>
 <20120914130755.GA21130@arwen.pp.htv.fi>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:36760 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751479Ab2INNNo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 09:13:44 -0400
Received: by lbbgj3 with SMTP id gj3so2735713lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 06:13:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120914130755.GA21130@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Maximilian Schwerin <Maximilian.Schwerin@tigris.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi again,

On Fri, Sep 14, 2012 at 04:07:56PM +0300, Felipe Balbi wrote:
> On Fri, Sep 14, 2012 at 02:57:49PM +0200, Maximilian Schwerin wrote:
> > Sorry :-( With log now.
> >=20
> > > -----Urspr=FCngliche Nachricht-----
> > > Von: linux-usb-owner@vger.kernel.org=20
> > > [mailto:linux-usb-owner@vger.kernel.org] Im Auftrag von=20
> > > Maximilian Schwerin
> > > Gesendet: Freitag, 14. September 2012 14:26
> > > An: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org
> > > Betreff: USB problem on beagleboard clone (PGP: Plain, Signed)
> > >=20
> > > Hi all,
> > >=20
> > > we've designed two beagle board clones (two different=20
> > > layouts) for a customer. After quite some time without any=20
> > > problems they are now seeing USB problems on some of the=20
> > > boards. I have so far not been able to reproduce the problem...
> > >=20
> > > The USB port of the OMAP the problems appear on is connected=20
> > > through a TPS65950 to a LAN9514 USB Hub + Ethernet Chip.=20
> > > Attached is the kernel output. I'm not even sure if this is=20
> > > related to our board, or if this might be a misbehaving device?!
> > >=20
> > > If someone has an idea what this could be and what I could do=20
> > > to fix or at least further debug the problem please speak up.
>=20
> I have never seen that error before on any of the boards I have. One
> question though, if the port is always Host, why are you using the OTG
> subsystem instead of the actual Host Subsystem which has an EHCI
> controller ?

Which kernel are you using ? Have you tried with v3.5 or something more
recent ?

--=20
balbi

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQUyxxAAoJEIaOsuA1yqREnrYP/3oe9aG68IE1PiWTO0CDAeHH
5kyQoq3NRs8RM2bCsvlqeJ+d3ihWrYarJkcMF/WZ+kg9ulqVWyAT9fwciNjtyDAl
aci+sCq+MVlg+8Xrbm3seTZzBeHVDDpwjO0Q2+CEtncB6Ljj74ZJ5yttdcsI4Yst
AjdyLUPmD+rlgYFs7QzjyarUHMC0nCWkCCN8N2HsrKzJyS9ZlBv1Oum8o0RCj/H8
Y7cgKs3N7VTnktr7VQ4BVeWrheDD28AG1JS2OW77R5ymBNjK2sMaJkapIxRgDlrN
SYiPxWKzC4kr+svQGdoq40Oa3DhS8ieTR5sc8Pv3O3qbFPLU5QrMKZOtdMbSTX2C
2D+vTVq9wg5FjfEuhBePA5LyFGm1yit8hgUnDEFjbsJV5UXrsjKNeDVNFC23CgTA
l6bI0+tm4i++AHigsvC5Zo5c9XYA2QtlZ6jmd4RXliG9zBpV8oA3oHjeWIEzoGFx
xb9Yc7+LthtkMMPNAkeMJLlCdhgf9SJttjjEluOw9Rmdpj3wr5l6nEXCNtf15eR2
Yk93fLtm2xk7HtDshygKtw3PWTqWo8N12HAHy70nikQ93c8N034OTO8B9QwZJGCp
F9E6AjUcz7Px1HQBBx5HHOZ0IyztmRUXonb5pjsXle4NT0aTHXW+vPSGyjqfXE1k
nhvYUHZLy7Htp6QeqB9Q
=OYjS
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
