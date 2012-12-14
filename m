From: Felipe Balbi <balbi@ti.com>
Subject: Re: MUSB-HDRC Gadget driving VBUS inappropriately
Date: Fri, 14 Dec 2012 14:13:19 +0200
Message-ID: <20121214121319.GB16600@arwen.pp.htv.fi>
References: <C3E8C797-AE49-4638-B41B-B3AE180D3426@gmail.com>
 <CANOLnONT=dFx581WFRn_b9Q=ngJpfzx+A56b-7po4xVZVqisyw@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44218 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436Ab2LNMUb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 07:20:31 -0500
Content-Disposition: inline
In-Reply-To: <CANOLnONT=dFx581WFRn_b9Q=ngJpfzx+A56b-7po4xVZVqisyw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Ian Coolidge <iancoolidge@gmail.com>, linux-usb@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, balbi@ti.com, felipe.contreras@gmail.com, icoolidge@trellisware.com

--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 14, 2012 at 02:13:07PM +0200, Grazvydas Ignotas wrote:
> On Fri, Dec 14, 2012 at 11:53 AM, Ian Coolidge <iancoolidge@gmail.com> wr=
ote:
> > we find that with about a 2% chance, the gadget comes up in some kind o=
f firmware failed state, driving VBUS.
> > In this condition, we found that MUSB_DEVCTL_SESSION bit was set.
> > I understand this to be indicative of MUSB thinking it is in host mode,=
 which agrees with the driven VBUS.
> > Further, in this state, I found that usually, there was one interrupt f=
rom twl4030_usb, but NO interrupts from musb-hdrc.
>=20
> I'm also also often seeing this and don't know any workaround except
> powercycling the board :(
> This was kind or relieved for me after I changed it to deinit musb on
> shutdown/reset (3.3 should have that patch merged), however if you
> randomly reset the board, there is still something like 30-50% chance
> musb will come up dead, and on proper reset it's still something like
> 5% chance like you reported.

hehe, then you should've reported earlier :-)

Anyway, I really think this has something to do with some bogus
set_vbus() calls.

Likely that looking at probe() path for checks for MUSB_DEVCTL_VBUS will
probably show you something which is wrong. Maybe the driver is assuming
that if VBUS bitfield is zero, then it kicks host side, or something.

Go over that part of the code and you probably will find something.

--=20
balbi

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQyxffAAoJEIaOsuA1yqREnXYQAKN5TmgJs9VGygIDAZ1FpUZn
LLdriKjSisvQl6g4yxdJ+q/DAroz4ZjfJeGUruFq/H9GXiMroD9wIwjpkBwHsZGI
+vmQLZvd7EcsFAt10eWXpxG00D3g/W3vv81jIIzNwfgnoDzlc6kMxiTe/XVmWoCP
Wf3Cwg/6ueg2xCoi9ljS80Up3czkAbf8i0uWvN45cN0m2JJ2Kc0ltp4LpEQBZbCq
VvuRPiJsF+cGMrklIo9lenEP2uA/uHngm3n31Xrwm9ftpng+WvzfQyF47o/L3+/J
ePyv+OUmOQeb9J7UlIOPKi1cidSq5L2vq9XUpmJiLOzkBGXo9jqiZXOpLgGwxoF8
49zmGddmLMmP2hX1qvSjFJM8E0DAjnP+J0qv/+uK4NjBOsuOO0NLHBI6kVxabHsa
ZSA6xBB8Zr/+1JYIxcjejwlgzK01rmAbl3t8cTuVQdrjJdBh8nONIdcpsrqncxDN
CSqJiVqVS3TjPuOwMW6+7FX0HXhypuB7hvW3QJqY80ZUuQa9tcZUnfgDHaftc79/
6QAjZOIvKz3V+8d5YzjmuxGN1aaG/zHSY8zJTE3xpEgQb6CpLSBtETkY/DqdVAR6
b5Tu7K08KA748XEXP5+k3smJZmqTPuSQJoyWdMnMH2pxDPjMKRBihu3pNAIwAAH+
9kKvLyCJLllZztEpyDHX
=kwXu
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
