From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 1/4] OMAP4: clockdata: Make compiler shut up about
 possible uninitialized variable
Date: Tue, 16 Aug 2011 09:53:12 +0300
Message-ID: <20110816065311.GB2305@legolas.emea.dhcp.ti.com>
References: <CAFULf_yAOTABxF_OV2xacF2CMhNVEguwSpgDHNbkeKKZif4ncA@mail.gmail.com>
 <CAFULf_wBTEVHYTPyJqWt09gNaenWHiVJCLvNdeRG204TkeBe6Q@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49478 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020Ab1HPGxQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Aug 2011 02:53:16 -0400
Received: by bkat2 with SMTP id t2so5429018bka.35
        for <linux-omap@vger.kernel.org>; Mon, 15 Aug 2011 23:53:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFULf_wBTEVHYTPyJqWt09gNaenWHiVJCLvNdeRG204TkeBe6Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bjarne Steinsbo <bsteinsbo@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2011 at 05:27:35PM +0200, Bjarne Steinsbo wrote:
> Stop `warning: 'cpu_clkflg' may be used uninitialized in this
> function' from compiler.
>=20
> Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOShPXAAoJEAv8Txj19kN1A2YH/jzaFsWT9zA8MRFqJWY0ZxRF
jQNpSZXwEvxcWPgyD3+IAMRpI9LR68rs4StI3b7LcaqHeZ/6tard6GSmwHwr5Wss
w4xerOaiRupX3afGC3trpjXC6rzmz1qKgrB930rWso7rdDrn6CgWBgWc2yP5yk0w
3PCsfOro8wqCZxAYsFitEw0LkpdT+EFMwFCz+T/9vEwFoCjyjtVdgXeAhxoKjnx3
ViFGy2X4W8JRCh3BWc39mugOYYpW+ituryztvHz2TXpPaIeYexu03mTfPhodbG5W
J6o0PrFZkqbCPx1VW7A5+i3G+azMUY1W0KbruXee82iWRUHsvXIcWj1vJ+kX9XM=
=UIpj
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
