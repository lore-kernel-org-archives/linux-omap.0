From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] arm/arm64: DT: Fix GICv2 CPU interface size
Date: Wed, 25 Jun 2014 15:31:34 +0200
Message-ID: <20140625133134.GQ19730@lukather>
References: <1403692675-26503-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z8BXP3CGI0FdUons"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403692675-26503-1-git-send-email-marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Z8BXP3CGI0FdUons
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2014 at 11:37:54AM +0100, Marc Zyngier wrote:
> All the Cortex-{A7,A15} implementations are using a GICv2. Same for
> the current arm64 platforms.
>=20
> Turns out that most of these platforms have described their GIC CPU
> interface size as being 4kB. while it is actually 8kB (the GICC_DIR
> register lives at offset 0x1000).
>=20
> This was found when converting the GIC driver to use EOImode=3D=3D1 on
> GICv2-based systems. It uses the GICC_DIR register, and the result
> is a very early firework...
>=20
> Signed-off-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>

Just tested this on an Allwinner A31.

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Tested-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Z8BXP3CGI0FdUons
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTqs82AAoJEBx+YmzsjxAgJtUP/j0Vbx/KdLy5szq5yRrNYza8
n7XWqbf5uDMr/AUlmZh7E0ITdjlgGkjnT7K4zJUKndH+vem9NqMSS7aDzRG70TgH
NVFrx3YagfixvZtpdxXH1z1RsbXj4v6/yOQPf8EO1GQR2dw8p3jPyL+Qsi9mXYFw
EmZMwpWPIs0FSvQfq1pX+uvnM1Brw9gVzcounHHk81t3d1rgio3JFCo84zcqM8YD
wIs1JQB/2k+PN7g30hM1yFjtkKSDzBgiQDo9I9hZnwjZXZ884+qXhT1DbWf8fXH4
yRYgE0ZVtTjlIZn43UCM3IVwOv1Mkeztl2WYdBbr5ugU7nNY28SO7n1MzSoOjMyq
9Y2nnYYc+JVtB9KCJWj0lcsI4yopMLPjNyHWkHgTeMRwOla1DoCmA91COF5C/Pl0
y+hhdcdDotsvId1BImRb8FwMfmBAPyWUlReGiT7CsUxkiDgNmZgodBwo3FVSz0NM
wqvb23FVwRK81z1mR2ubXdAMBOrz6g6dJqvdlAq5rbdS4RZyUacnY1JMjA3GIyp2
+LJSJXCNEtdcqMNp+zZy5z05ceJ0VSVJB9JpfgxdAZQBF8shAU6JCQ0EoojTNW8r
caG3XHGLJuf2ryfvWj7Bqz9fTUShm5Fk3dpMsQ6+ze/CW+1R3HGWnBK1rvyWRUse
wPqsESa8j5xxgj4IJbcH
=kC28
-----END PGP SIGNATURE-----

--Z8BXP3CGI0FdUons--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
