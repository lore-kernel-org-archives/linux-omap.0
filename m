From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: omap: fix "Too much work in one IRQ" irq
 handling
Date: Mon, 17 Nov 2014 15:41:53 +0100
Message-ID: <20141117144152.GA12644@katana>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com>
 <1416014452-6712-2-git-send-email-al.kochet@gmail.com>
 <20141115014859.GC808@saruman>
 <7C4EE58D-8956-40C2-B649-775B2F551D2A@gmail.com>
 <20141115034756.GA2917@saruman>
 <20141115035328.GA3289@saruman>
 <A47891AC-7453-43F0-9196-5133A1525C68@gmail.com>
 <20141116154558.GA7422@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36043 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbaKQOke (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Nov 2014 09:40:34 -0500
Content-Disposition: inline
In-Reply-To: <20141116154558.GA7422@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Alexander Kochetkov <al.kochet@gmail.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > submit write request to General Call Address. In that case ISR could
> > not correctly handle RDR (or XRDY, ARDY, or that ever). Thats becase
> > i2c-omap driver doesn't correctly handle i2c-controller's slave mode.
>=20
> right, Linux doesn't support being the slave. That's also a missing
> feature, not a bug.

This is going to change. I sent out RFC patches for slave support [1]
and will send V1 this week. This won't affect your driver, though,
unless you implement the backend into it.

Just to keep your heads up.

[1] http://thread.gmane.org/gmane.linux.kernel/1783295

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUagkwAAoJEBQN5MwUoCm2bIcP/RPzqjNW1MEWiqPCIEIKtmY5
K98BU4opTlzGselfnb6VIq+tY7odP0uCQD8GlY9hZEydbHOvmdcy/I8s7Hd8cZDB
DmfVXtgXRZqrYjg3SvvVA/GY3GW17UCbCtnm15MKOkGFY6sql3mLKeasoTAJCTt9
gbYNDMiMiZp7oOce/9OqapzSYLrLeYT5Llu8gY7v5G3wwWZfvc1rsUxN39tVSt53
jkMpcPLTef4jodw31/Mq+whunCP03Z+n39nMqJoFR4AtCDqSu6/Og2zy9s4LoF+5
qN4vnrjwUMxXMi+LENq86GiTYHbsRxxTDEw/8P8UbazANyrd8uSC1Q+6DtkGV4eN
o6IgibNAeoC7spn3z85hzB4LBRGwgtEZpH0PW0J6Z3nk+RopAvLQmMmHEkCt+MBx
hqvXWTUtr3K4mtoT8OF+Dh7vNH52XKuCOgpGY1AEJKYD3oHg9ZROuRN5dDFXZ75Z
3pBvFSS5kdjaZJkLc0jbhzKhV6/6TJUQdQRB8TUNZMruXFAZSnAKmDX6eplPKFSk
Q5fC8F8KmqThq3EWEiPP6TTKnf/EO4xTCjMSEilCT6Ej+wQaGIo/MqUdy/VoNLio
N8B5DjHgabM8T3fgcr2WR/FcAseGb3o+hK4Nk5sQve49NlGZvI0sgJKdS+f+CJbT
430T47a1gKduWDoCIxvO
=Uv2O
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
