From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: OMAP4: Update IRQ flags for the HPD IRQ
 request
Date: Tue, 22 May 2012 10:41:03 +0300
Message-ID: <1337672463.4125.0.camel@deskari>
References: <1337654841-28378-1-git-send-email-ricardo.neri@ti.com>
	 <1337654841-28378-2-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-jac4VfmtrPGJcHAzD6RR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:56139 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753917Ab2EVHlN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 03:41:13 -0400
Received: by lagz14 with SMTP id z14so5924832lag.21
        for <linux-omap@vger.kernel.org>; Tue, 22 May 2012 00:41:10 -0700 (PDT)
In-Reply-To: <1337654841-28378-2-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org


--=-jac4VfmtrPGJcHAzD6RR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-21 at 21:47 -0500, Ricardo Neri wrote:
> genirq requires that the IRQ requests that do not provided a handler to
> use the IRQF_ONESHOT flag. This is to prevent situations in which the irq=
 line
> is reenabled while the interrupt is still asserted. While this situation =
may
> not happen in edge type interrupts, genirq still requires to use IRQF_ONE=
SHOT.
>=20
> Also, remove the IRQF_DISABLED as the flag is now a NOOP and has been
> deprecated.

Thanks, I'll apply.

 Tomi


--=-jac4VfmtrPGJcHAzD6RR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPu0MPAAoJEPo9qoy8lh7172wP/ReZRPdgWxEQHOix8PIMr/sm
5MoAcJz/fUsssfCQP1hI78UjPnDF1BdfYiFAgq5u5jxNaEu/UbCUeCuYh9tiQ4km
orl0lT9YeaL+38VnEJnchv6Ai50Leg/1/WmsMXtNBgLH/SNv2blU2K1YuoBKWib2
xSKfNgLklYzLU0rnEPWoAL42t47YBi/ZsydMXIabZ+39mhoZAmx6El8HqEq16+ss
z21gghKHVnwXBD6GhkYixAa9ljfKMjBKqu3fO08bSuRUBjD01wgLl/JjWk+I8XgR
3iH49wJgRHrmjmZwhyvAArZ/58M74rR84N2RMD0XpN493V3gAYeZYZng5E9Z+0cL
WuIAkozX9Pouj8ckuf87cDL7lk7MvZLZhdWivbTHXUfklcTxdJRgePEhIXay8LKH
rrUe+p9kjRM3ThZbG2RZXPoVH+2r4WRef72+wAYWE5nmInjWdsV1PZkD/UvGjy5g
sxXY3Kz9QtZAK/TjpfC+hEOvSij/oiKFq08+X8Ri1jiy1/ifahSowlcOoVsyC5hR
X2j0IXib4Q1jIVC3gBHc3tsYqLb53RT0Q8Mef1Hxq26Rr1LfE/lFJ2I3KajdgN9N
NlzI6H0M1w+yHMipEv1++5HmLqaIFvbNBqr8bQrXf8t34+D3Uv2uwwh7NvxPT3Uq
INFAqCXdTcNMR7Bg0kQ2
=LqIe
-----END PGP SIGNATURE-----

--=-jac4VfmtrPGJcHAzD6RR--

