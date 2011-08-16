From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 2/4] OMAP4: Keyboard: Fix section mismatch in the board
 file
Date: Tue, 16 Aug 2011 09:53:33 +0300
Message-ID: <20110816065332.GC2305@legolas.emea.dhcp.ti.com>
References: <CAFULf_zAqFGcUfgfOMyrm8DLJhg1qXG+48W5u+pjBUwa=PmrRg@mail.gmail.com>
 <CAFULf_x_7GXMRY_rNDFk377R-ZWSOvM5KBqOe0a4cYbzGARnYA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:58158 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750869Ab1HPGxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Aug 2011 02:53:37 -0400
Received: by bkar19 with SMTP id r19so3528671bka.38
        for <linux-omap@vger.kernel.org>; Mon, 15 Aug 2011 23:53:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFULf_x_7GXMRY_rNDFk377R-ZWSOvM5KBqOe0a4cYbzGARnYA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bjarne Steinsbo <bsteinsbo@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2011 at 05:27:52PM +0200, Bjarne Steinsbo wrote:
> `keypad_pads' is referred to by `keypad_data' which is
> not __initdata, so `keypad_pads' should not be __initdata either.
>=20
> Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOShPsAAoJEAv8Txj19kN1HEEH+gLgDNjohcAjt9c4hfxpVE0X
SmzrO7C6KOpDwwBHYzO3rDUcc56lC7SuwU6rh6nhdlEhl+Y2iBK+ZufsQFR9Txh5
3gBd/Ma0HyWuwsAr4cIE/uqqhum/cMvkQInZO5ngNZQ8kTmsfLjJOQvBgE0dxsUr
0QKEJJDY882LoouyA4uc8gYltHew/SqqpA6tSYseru24qy69UTTX4Kr8vbN9dw40
Niu6iVuSDFtBG1sAzL7zVwSB7u0fZO7ILJ5HdI01z96EscKb0Y10UQcqnl8s9aCR
uiFQp1LzHmvEPO/4GdxRr2H3KyFRf4DNpeCF+smEjgm6DIXpy01M3pYN1NUVql0=
=Tbtf
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
