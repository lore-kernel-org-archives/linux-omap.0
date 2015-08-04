From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/7] phy: ti-pipe3: cleanup ti_pipe3_probe()
Date: Tue, 4 Aug 2015 11:00:28 -0500
Message-ID: <20150804160028.GG23659@saruman.tx.rr.com>
References: <1438701646-7876-1-git-send-email-kishon@ti.com>
 <1438701646-7876-2-git-send-email-kishon@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438701646-7876-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: rogerq-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2015 at 08:50:40PM +0530, Kishon Vijay Abraham I wrote:
> No functional change. Add separate functions for pll,
> clocks and syscon to make ti_pipe3_probe clean.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>

I think this needs to be splitted into smaller patches.

Seems like the very first patch would be to introduce a local struct
device pointer to be used. Than add each and every new function on their
own patch. This will help big time making your refactoring a lot clearer
and, should anything go wrong, we can atomically revert a specific
change, instead of loosing the entire refactor.

--=20
balbi

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwOGbAAoJEIaOsuA1yqREHbUP/i3RO4hl2GJzeN8vL6Edwkdm
+jhJ1GKYWUX7KQEZ74HKKG1oAORT3R095ruJtszq0nrbEhVyM/FaC8TwvZFhbtxK
4F7Id9kxjrQ1njFN87n4WfzUQlAAO2IuqFdSh+qKDAj2zTNYhMO8mcqQdLPYs3Kj
k4ew8RXsS8toHqpWnmH7L5w30WjiqOo8z3UUaVm3Zogdw6pNnYYidqoqBX8ZC42z
62LDHSmZ8CP7P4iAFr8kZSAXp9SZCamrVRTy2o8q5LpyduWCxIvdAmOpZcijlDlP
fYkZD4yP/1G03b9Fis+BOcXmXZKPJRYtZKMEer0zeVgxA6fP3XqUxaepRHJA4PDs
1xhHjuczw3e1wa3k8ZMTNjcFn4F+soMgIbAR4Y3QjIVXz2d7E7EMyWWcT2Io13zF
ceaISmghmdZcLnhQDOp27p4tPgeFWVjkG/4bgyiNUt847wnhhVZtfUx3pDFDIvEV
ct+Q2TpGVeHt0+pnMOPAlS5STN6um/FI9/zuGhGdOAqTVXV3gxNrNq7bhH6xwd5L
jbl8kqjR/Rf5GWiaWlTnibcv+TZNCYfN3z/RfiP3QcELcIs+ejbucGbI1qB1Fqnm
gfn6REfySExuh5Ppy2F67qETDRwawNNRf9WiwsMrg/zdRDs6fA9zghrjrJhiVWt1
dARmvr2TNn3123P+TSeN
=Vv01
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
