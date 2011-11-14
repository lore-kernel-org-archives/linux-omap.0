From: Felipe Balbi <balbi@ti.com>
Subject: Re: Help with clk API
Date: Mon, 14 Nov 2011 14:17:24 +0200
Message-ID: <20111114121723.GS2834@legolas.emea.dhcp.ti.com>
References: <20111111113159.GK19090@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FJ0JV+AOCbvjFtNn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51058 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751988Ab1KNMR3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Nov 2011 07:17:29 -0500
Received: by bke17 with SMTP id 17so5649590bke.0
        for <linux-omap@vger.kernel.org>; Mon, 14 Nov 2011 04:17:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111111113159.GK19090@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--FJ0JV+AOCbvjFtNn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 11, 2011 at 01:32:00PM +0200, Felipe Balbi wrote:
> I have a doubt about using clk API to change CLKSEL_UTMI_P1 bit for a
> silicon errata (OMAP4460 i693) implementation.
>=20
> According to errata, I need to switch from external to internal clock
> during USB port suspend, wait 1ms and switch back from internal to
> external.
>=20
> How can I do that with clk API ? Is it by changing clk parent ? Any tips
> would be helpful ;-) thanks

a gentle ping to this mail ;-)

--=20
balbi

--FJ0JV+AOCbvjFtNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOwQbTAAoJEIaOsuA1yqREp4gQAJa/mWp14SE51phzN23Kjlna
DiVZYRCBCEg/Bzfln7ZUcXALQ3i1eVAb61u4bj4YqdG7MLgR7Tm+NeFTK/8/5blq
KhAxOUqO+sxL4ATc23EoTFiuMVGiUnl8kbqbXWI1Tk5AN55VZKXQaPqQnsVjY+9a
+MvvXSyUb/Zgxhl9Tz3MQt1z1F5Ttm4fT4nIVr292DvmOBrnfB5QNdOXaLa4aIXp
S+DA0LKaniCZUJdt7vlFBvGfYSdGGdafgqmGKxPAEwwaRLYvj7ey+hlfRXxt3tOX
DTB+Rf1RyqQldhYm0JtvmfEhstrlY82ZJu1fZIFlfxUHCV5XzK76lU4N7ydgS9Gb
cFDUSA+E3edtuKCO2/v7jBYD1FutshSjXNDwqp3S85ep0sKOHcwJDvg8ONEcVYy7
LmsWZsk4G39/OjyGbVrpvWgH9CW0HTRcKm9VL1nk5lOuzFhDpu/FMpscAGML/U9r
V1B7cAWZCUF6yZH92SPijTrQLG8aXsWsNsG+9+ykk9nnABB1JnlGJlUGkLKRjwTY
IRNUHkVg3qC+pFWtOpyJSjLcGUFoCD10oFM2oIEfH2y8Hl0RUGYEAE6xJj3Y86Yk
ezLWrPTCFqUMN8wnTr1piSMblnckD/a1dtOliY8PYQW5/kGSZCVaLKXSNpmIrKOl
si8ZzEJPOk//kN48YV56
=8ADN
-----END PGP SIGNATURE-----

--FJ0JV+AOCbvjFtNn--
