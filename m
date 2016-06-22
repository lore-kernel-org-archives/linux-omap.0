From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/9] regulator: tps65217: Enable suspend configuration
Date: Wed, 22 Jun 2016 11:16:11 +0100
Message-ID: <20160622101611.GI28202@sirena.org.uk>
References: <1466412218-5906-1-git-send-email-j-keerthy@ti.com>
 <1466412218-5906-2-git-send-email-j-keerthy@ti.com>
 <20160621190848.GF28202@sirena.org.uk>
 <576A64EA.4000607@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <576A64EA.4000607-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, russ.dill-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 22, 2016 at 03:44:02PM +0530, Keerthy wrote:

> Hence saving it in a static array and using it later in the ops functions to
> disable or enable regulator during suspend.

Why a static array and not part of the dynamically allocated driver
data?

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXamVpAAoJECTWi3JdVIfQ2FEH/1KSem8eNAWDCdpOmy8v8jJe
ixmSH+oUNIfKsXMPg8eVIVycXLX2lo7ez277dsxqWXZ8m6Dgi8OGrF0pAdsZhF2Y
VOzn4F+7tcDHuJe6PmymHpMvj6Q7SSd6Kieda7Ic7mozFzYh8/OV5Mb9hfM/WO31
0hbJtVWzORTaEKWmSBI2k7kmTmPEM0Kwc4tFO8q2zeQ1Q8B2WczVYg2n3Mf+ZxDy
h8/8fB7mflvPhg8KkOhUCiepJRkQJagDbdI+qZEgPD62WOBW49jLbvqAmlviDspx
YuplJ5zc4u1LDmZfrPlETCfOpqLvQGYMlGeBQ9TAexQr+UdJSHrGhmsd5W7cTWI=
=jzNr
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
