From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/7] ARM: OMAP2+: Fix error handling for
 omap2_clk_enable_init_clocks
Date: Tue, 13 Jan 2015 19:21:48 -0600
Message-ID: <20150114012148.GE18523@saruman>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
 <1421190837-4692-3-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57367 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbbANBW4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 20:22:56 -0500
Content-Disposition: inline
In-Reply-To: <1421190837-4692-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2015 at 03:13:52PM -0800, Tony Lindgren wrote:
> We need to check if we got the clock before trying to do anything
> with it. Otherwise we will get something like this:
>=20
> Unable to handle kernel paging request at virtual address fffffffe
> ...
> [<c04bef78>] (clk_prepare) from [<c00338a4>] (omap2_clk_enable_init_clock=
s+0x50/0x8)
> [<c00338a4>] (omap2_clk_enable_init_clocks) from [<c0876838>] (dm816x_dt_=
clk_init+0)
> ...
>=20
> Let's add check for the clock and WARN if the init clock was not
> found.
>=20
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Just one minor nit below, other than that:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/clock.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 6ad5b4d..89a0732 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -620,6 +620,11 @@ void omap2_clk_enable_init_clocks(const char **clk_n=
ames, u8 num_clocks)
> =20
>  	for (i =3D 0; i < num_clocks; i++) {
>  		init_clk =3D clk_get(NULL, clk_names[i]);
> +		if (IS_ERR(init_clk)) {
> +			WARN(1, "omap clock: could not find init clock %s\n",
> +			     clk_names[i]);

you can combine the if with the WARN():

		if (WARN(IS_ERR(init_clk), "could not find init clock %s\n",
			clk_names[i]))

not that I also removed that "omap clock" prefix because WARN() will
print the file name anyway.

> +			continue;
> +		}
>  		clk_prepare_enable(init_clk);
>  	}
>  }
> --=20
> 2.1.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtcSsAAoJEIaOsuA1yqRE7KcQAJ0Rnm7kHLPJqg8nR450H4Iy
HIwsd6fiuMBLOjdkqz7Uw7u3bZ2a4EW6w3S04sxs3hFGn5ePEoayhxkeB6H8jSSB
ieOkKPVFrIqiT8VyPIG91GBf7pUjaQYloQPS/bHYGBIb6tcuuF8v9ZphilZ9mlFG
GUPb2lSmD97AdarjMP1UC9TlQDanBLY1QFtrp67PY48/s8VDR9MGV27CGOFuqI1R
0g1VoM4uhIZKEGcc2VWbE6j0/UIgWfER9fq3qA7thtiLBMLtjFl0rcw1fUwEDlL5
dFtxfE4xhgEVRc24lZ+5fvTkf4emaQ3KCy44KqyYwNxyCnh8Br1U5umB9Jf60s63
v5azCn5W90lXAvBmmzT66kSUMQoB+VSrilGjbDTP4kiBVKHAf9SZ5nbGjAyoBjBZ
3VfQUxQ0/JHTWxEBqqYa+4Zj6PqyXbGorPc5OSGhKnJfEaJb0ZzMtvrQhAq9hbBU
lT5tz7DH+/ZIeeC9Z3wd0RQelGTjzq8uj1Ej/jjO2iHjRMwP9ERpn67eML3522Cq
V6AsnE1/2GHazuIvNGv8dGbq9OofhhihOSVo/Ll4nvELZs7NYTYCMMlrmGZxW6cl
aWES1z7QOexbRy0QNFr7fY62aExsEwSQHuCTMzbcuj5e6hwJlBzx2suKHk0g6qVx
A4yE4C0DnBKcPPD4iGGI
=2TYj
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--
