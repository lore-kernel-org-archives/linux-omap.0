From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 3/4] usb: musb: OMAP4430: Remove incorrect call to
 omap4430_phy_init()
Date: Tue, 16 Aug 2011 09:54:02 +0300
Message-ID: <20110816065401.GD2305@legolas.emea.dhcp.ti.com>
References: <CAFULf_xEyAzJjxm6U+eVbdidSa3soVmn8J9NcJ=w8Fhf65yQaw@mail.gmail.com>
 <20110812094824.GQ19467@legolas.emea.dhcp.ti.com>
 <CAFULf_xk4xWLq4zhGokpTqoh95eUe3sg1vvVg_KCbJ3VXDkkRg@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:42419 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020Ab1HPGyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Aug 2011 02:54:07 -0400
Received: by bkbzt4 with SMTP id zt4so3571486bkb.28
        for <linux-omap@vger.kernel.org>; Mon, 15 Aug 2011 23:54:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFULf_xk4xWLq4zhGokpTqoh95eUe3sg1vvVg_KCbJ3VXDkkRg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bjarne Steinsbo <bsteinsbo@gmail.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2011 at 05:28:07PM +0200, Bjarne Steinsbo wrote:
> Don't call omap4430_phy_init(dev) before dev is initialized.
> The real omap4430_phy_init(dev) call is done at the end of
> this function.
>=20
> Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>

Tony, you can have this one through your OMAP tree:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOShQJAAoJEAv8Txj19kN1S5YIAJxVDiVHL32iaocAQcLNz3Hg
7NTelJn1lDwdp8nFIxUEK7Iv45ueeqwLsJ81phm7+VF8CCG4xkBBru1XtiSsIbKd
n+7MXrs/fDTpjrijzTKyWGQAbrGAagEEE9lQul7a9Cc5ziWhQgD8HPMLWwboTEXA
kDWQNC7UrE8n7LT+rP4WEc782YdG8k7HmoEMAu9uiA+LDuiHpUjw4ljrwojMTJxY
rJtg85VfrwDuRJzaQTFu4YNbN1N3RJvuPSQ1eKRdImNM4iao2Mi8MYJitOUv7tEk
izory1LEelPO5N/4gT7ex1eRgqJkwGqKNx2gBfpqwrQwTuXp8tZP3IUTVsu5q4w=
=ed1J
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
