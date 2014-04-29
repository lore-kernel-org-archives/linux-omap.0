From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Tue, 29 Apr 2014 08:26:01 +0300
Message-ID: <535F37E9.8090609@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com> <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com> <535A42D6.5090107@ti.com> <535A4470.2000509@ti.com> <535A5C0A.7040808@ti.com> <535A6C40.10609@ti.com> <20140425153150.GA20807@atomide.com> <535DFAAE.1010606@ti.com> <20140428164528.GM20807@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aW7xL0G510T3VRpS2oq46Lgo4jjwU2FL2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57983 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbaD2F0a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 01:26:30 -0400
In-Reply-To: <20140428164528.GM20807@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--aW7xL0G510T3VRpS2oq46Lgo4jjwU2FL2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/04/14 19:45, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140427 23:53]:
>> On 25/04/14 18:31, Tony Lindgren wrote:
>>
>>> Chances are any mux register in the syscon area already works with
>>> pinctrl-single,pins or pinctrl-single,bits option. The ones in the
>>> padconf area should be already mapped so the driver just has to
>>> request them.
>>
>> If using the padconf (say omap4_padconf_global for omap4), doesn't tha=
t
>> mean we need to have platform specific bits in the driver? Isn't that
>> something we've been trying to remove all the time?
>=20
> No, it's all done in a Linux generic way during driver probe, see
> drivers/base/pinctrl.c. You just need to define the default pins
> in the .dts files. If you need dynamic remuxing in the driver,
> you can define other named states that the driver can then toggle
> with pinctrl_select_state().

omap4_padconf_global is a syscon node, not pinctrl. As syscon just gives
a raw regmap to its memory area, the driver needs to know about the OMAP
control registers to use it.

Pinctrl-single cannot be used for CONTROL_DSIPHY register, as the
register contents are a bit funny and DSI1 and DSI2 bits are mixed
together. And CONTROL_DSIPHY is already in the memory region defined by
the omap4_padconf_global, so I guess it wouldn't be good to map parts of
the same memory region in a pinctrl node.

 Tomi



--aW7xL0G510T3VRpS2oq46Lgo4jjwU2FL2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTXzfsAAoJEPo9qoy8lh71XCcQAIJT/Dqo/RczlTs2VhDNeiAQ
mrllqfvdxhLzv2dZfnBhBcmovw/34ZP+k1TaLJjDYpsOPtFta/yn72XmatCquZXP
nV1sWCpUbosot/eq2WvuJqylN+HW9XxDUBhp2YeuCH+PLOGywYm2J8gr6mYIPMgp
AiPcHEehDlygqUG1BHhCPQvvOCwzssm501J2KhqEKreQoWvPhS0VA3XSXSYWX4+Q
e3A0b06IjstZHkkqDTZuHs1EoOd3atvMTIt1AF9ymdV+yFx9VEUP4ba1TuWOhBLl
j9TnPb0siXwGA+SLcvKfC+tMUgi8Iv7ZANgg/T0qxagHpAVRKytBrKTZP6ufwftz
KCMOe9lRgNRM+Yd6E1K0fmtm//QJC9kOSSWAwaqgydYwze4Z2OQqwjNIJkCSww3j
7GVPyy3JTXu/K7Feo2LO53G33L5LElS5IOKBK8o//n6FrRt5kgLO69p2495ew3MM
++7r9xfDEmSb57mXVuMlqLFJdD4fmGLW7/sz2ikVNyJ9C5ZFdMa2S3e9MlJg7aON
yB6H2OJRcVDwDri24XNBN5gdHWQbuJ8evUnzmnMX6Pz//iIxU8WLqjtHvqKiTnmt
30SgpmmTKQbYPTXcGMX0sg5INVwMNyS7h0zsjqKuj12WyPEoxHN9zyDfxM+85CCf
uc25DwarM1s9FJxNw2ly
=LxzS
-----END PGP SIGNATURE-----

--aW7xL0G510T3VRpS2oq46Lgo4jjwU2FL2--
