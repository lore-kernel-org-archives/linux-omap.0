From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: Nokia N900 on 5.4 and 5.5
Date: Sat, 8 Feb 2020 02:49:28 +0100
Message-ID: <8a19bde5-f49f-ad58-3b3b-6df8a764f1f2@wizzup.org>
References: <79b91017-b52a-8aff-4b9c-913ae655f7bf@wizzup.org>
 <185CD173-C13C-4D56-B3DE-9A8D7784963C@goldelico.com>
 <20200207163623.GA64767@atomide.com>
 <da14d6bb-f241-2dd4-8e94-886217a40ed7@wizzup.org>
 <20200207165344.GB64767@atomide.com> <20200207170149.GC64767@atomide.com>
 <op.0fmv4jevhxa7s4@supervisor.net28>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5KSJZaIBkOOJfqshMBG8d4nx3nRtEXKOo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from a80-127-99-228.adsl.xs4all.nl ([80.127.99.228]:38312 "EHLO
        hetgrotebos.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726743AbgBHBsf (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 7 Feb 2020 20:48:35 -0500
In-Reply-To: <op.0fmv4jevhxa7s4@supervisor.net28>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arthur D." <spinal.by@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Kees Cook <keescook@chromium.org>, Nicolas Pitre <nico@fluxnic.net>, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5KSJZaIBkOOJfqshMBG8d4nx3nRtEXKOo
Content-Type: multipart/mixed; boundary="Y8Inm6glfJjerqXvHHeMGlZuzZVj1AimU"

--Y8Inm6glfJjerqXvHHeMGlZuzZVj1AimU
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 07/02/2020 21:20, Arthur D. wrote:
> Hi.
>=20
> I was able to build linux-5.5 and run it on N900 with no problems.
> Even WiFi works, mmc0 is in place too. It seems you're doing something
> wrong.

Well, I didn't try mmc0 on 5.5 (since it was also non-booting due to
issue below), so I will have to try that this weekend. The steps I
applied to build either kernels (5.1 with our patches, 5.4.18 and 5.5.2
are identical, except for the defconfig for our 5.1 branch)

> Were you able to build linux-5.1 with your scripts and run it on the
> phone? I mean the pure linux-5.1 without configs and changes done
> in https://github.com/maemo-leste/n9xx-linux.
>=20
> BTW, I didn't find STACKPROTECTOR_PER_TASK option to be enabled in
> omap2plus_defconfig.

Well, I can assure you it was turned on on my system after a
omap2plus_defconfig. I do run Gentoo Hardened on my daily systems, so
perhaps that somehow makes a difference in what defconfig is picked.

Either way - the option is turned on by default after I make
omap2plus_defconfig, and it breaks appended DTB loading, so I hope we
can look at fixing that.

Cheers,
Merlijn


--Y8Inm6glfJjerqXvHHeMGlZuzZVj1AimU--

--5KSJZaIBkOOJfqshMBG8d4nx3nRtEXKOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCXj4TqAAKCRAGN09rynK8
WqJbAP9xXnsepI8fIIHOFJ28JUbALVlp70tSLPwvYKNcqQvqiwEA/8g8gsgAWAnc
yHLtGXH+DJcdxNlB3n0nHz6Tj56fQQU=
=11R3
-----END PGP SIGNATURE-----

--5KSJZaIBkOOJfqshMBG8d4nx3nRtEXKOo--
