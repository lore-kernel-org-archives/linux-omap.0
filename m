From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 02/27] OMAPDSS: remove DT hacks for regulators
Date: Tue, 17 Dec 2013 08:42:58 +0200
Message-ID: <52AFF272.5080205@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <1387205794-32246-3-git-send-email-tomi.valkeinen@ti.com> <20131216184247.GB26293@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="4AcoMNAo11RCkhiGJFV1sVj27CaQm5vPu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38547 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824Ab3LQGnC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 01:43:02 -0500
In-Reply-To: <20131216184247.GB26293@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

--4AcoMNAo11RCkhiGJFV1sVj27CaQm5vPu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-16 20:42, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 06:59]:
>> For booting Panda and 4430SDP with DT, while DSS did not support DT, w=
e
>> had to had small hacks in the omapdss driver to get the regulators. Wi=
th
>> DT now supported in DSS, we can remove those hacks.
>=20
> This too we should probably keep for a while and remove after we've
> converted DSS over to DT?

Hmm, yes, this one can be moved at the end of the series, as at that
point the DT is supported for Panda and 4430SDP.

 Tomi



--4AcoMNAo11RCkhiGJFV1sVj27CaQm5vPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSr/JyAAoJEPo9qoy8lh71BpsP/12zRXe8w/3WjQDMb9tZqs9u
p9beQXhB7xYw8i5LicOYaKd2yrMzvMOPufrRetwSSxjmBtJI3cKKHBa5Mxxp64It
1P9uxlLn3tPD14tnBFF7Bbl9oD3WtMsfBW1/1SWW8XthrxCf9ySvkJfjYmwam/Kg
R5PO+uC5t5x31BJeq1mnzhJIbJrGq7JPeXhTvkLR+TEJ06P42hmKbSk/EPTejWxo
b1okVfMx+CB9kDyYpFnLnQwFpODDjgxXHU+Pjwhz9JK+OqkYR+c04q0Shuf4gFWS
sJDsoAcu2Q5567ptPlpFLbk4XBA4NsSBAW9ecBBwox/ISJJlZsNJWimNaCq0jp0w
A2Mv/kz/w+3MuWJ+OkM9x2lBH4bO+7fA2tASyDVizJP1SU1FVa89jVjgT90+YMPN
SXT3ZJZ5jogkBsX2mLGCrvke+xGMWGdJyKT7jqAKvOujUc3205EyHk2kJpAAK1pP
4810iCBUKONXbg9gO1Fi1z9MB/baM8ZQ8ljAWUcIc+IweF9ZyylvWNhoc+S+md2H
O/dF7z8kO/q7sICW+St/njzO1jf+glBlE5iilcN1Nf/QnW7bibCaTiy2V4kZPCI5
Wx3YtAXQvVVRgT/83yWd+gvXgMVittz0Ml0+oqQULDeTRk9TutLrxHN0RY+umo+b
mTT78bOsoeiJFvIM6VpZ
=JdHE
-----END PGP SIGNATURE-----

--4AcoMNAo11RCkhiGJFV1sVj27CaQm5vPu--
