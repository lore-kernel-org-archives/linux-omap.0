From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC PATCH 1/6] ARM: OMAP2+: hwmod: add parent_hwmod support
Date: Thu, 20 Nov 2014 09:56:37 +0200
Message-ID: <546D9EB5.9090505@ti.com>
References: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com> <1412863399-9508-2-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1411200702440.9204@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="0Vv5w6Ik6bibXA6OjxjSv6tPT9geExXFQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52430 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbaKTH4m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2014 02:56:42 -0500
In-Reply-To: <alpine.DEB.2.02.1411200702440.9204@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Archit Taneja <archit.taneja@gmail.com>

--0Vv5w6Ik6bibXA6OjxjSv6tPT9geExXFQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 20/11/14 09:03, Paul Walmsley wrote:
> Hi
>=20
> On Thu, 9 Oct 2014, Tomi Valkeinen wrote:
>=20
>> Add parent_hwmod pointer to omap_hwmod. This can be set to point to a
>> "parent" hwmod that needs to be enabled for the "child" hwmod to work.=

>>
>> This is used at hwmod setup time: when doing the initial setup and
>> reset, first enable the parent hwmod, and after setup and reset is don=
e,
>> restore the parent hwmod to postsetup_state.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> This one has been updated here to add some kerneldoc documentation. =20
> Please let me know if you have any objections.

Thanks, looks good to me. Sorry I missed adding the kernel doc.

 Tomi



--0Vv5w6Ik6bibXA6OjxjSv6tPT9geExXFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUbZ61AAoJEPo9qoy8lh71KHEP/j1lFzeLc+Gnu3qOo1ixgHcg
Tkjkp+wz6M1/fEfr6lHBXHNT1FyXLJYcSZvf36Cf/AqRbjW+J5F4+CjRj9kKZIBF
eShCrbZykU0a8adKOxcJF8dRzZ0aqqdk9VWIP79Tt7uyP6OLHDJ6bJyh5VuFW++v
VBQO25d8GoMr5fx29P8JVC2CWvZFsSrsW90FUxDKNhpqTOzRO0cAj/1AUIfV1R70
yFfvW4dRzUlIPwr8c3/mp/8WiyOHbiRr4GpB/sDP0I5empL+bt/yXx7kOPY8xFw0
GDw2UmRdoD77v/Py6tJwnhEBFJZbr3s46EjNQQ1PTovGPjYdZLTHCYDNDQ5ANgwH
Ilh3XqPFiH1nCE5IO0R42j1woV/CQ4K7TLQ45oD7IRaLYthQG8hICYbEPMGtP0B4
Ukp2kH49JlTKaofSFBPEW57CBwb8518GFOio+LV51Ni5iUffskOj74QYHFwuLJnG
QPU0d/wJO7FXfQWY+I7hH768ucMrXlDBtUYRwiNB7ARygTAqb1kDaUFFCUjymM4W
N3xuQ/aXajwzerege/MC4bqYi83t94aedXK9KHECv8Db8oLKYCgnh9s5mf1HzC24
r9esM1yY36bNxJ3wCuB5FdPx5rG4c8EBX7iBGmGaaxznhtscEeNdFQ0kvsmWhtog
wXEHWsicyXmgefew4Ewc
=lrY9
-----END PGP SIGNATURE-----

--0Vv5w6Ik6bibXA6OjxjSv6tPT9geExXFQ--
