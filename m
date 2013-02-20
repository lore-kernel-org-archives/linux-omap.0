From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/8] ARM: OMAP5: Update SOC id detection code for ES2
Date: Wed, 20 Feb 2013 17:29:40 +0200
Message-ID: <20130220152940.GE16652@arwen.pp.htv.fi>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
 <1361374034-21831-2-git-send-email-santosh.shilimkar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58409 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933698Ab3BTP3r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:29:47 -0500
Content-Disposition: inline
In-Reply-To: <1361374034-21831-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 20, 2013 at 08:57:07PM +0530, Santosh Shilimkar wrote:
>  	case 0xb998:
>  		switch (rev) {
>  		case 0:
> -		default:
>  			omap_revision =3D OMAP5432_REV_ES1_0;
> +			break;
> +		case 1:
> +			omap_revision =3D OMAP5432_REV_ES2_0;
> +			break;
> +		default:
> +			omap_revision =3D OMAP5432_REV_ES2_0;

no need for the duplication:

+		case 1:
+		default:
+			omap_revision =3D OMAP5432_REV_ES2_0;

will work just fine.

>  		}
>  		break;
> =20
>  	default:
>  		/* Unknown default to latest silicon rev as default*/
> -		omap_revision =3D OMAP5430_REV_ES1_0;
> +		omap_revision =3D OMAP5430_REV_ES2_0;

how about we default to 0xffffffff ? That's the highest possible
version, just not sure if our revision macros can cope with it.

--=20
balbi

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJOvkAAoJEIaOsuA1yqRE0gMP/1tkcuq1a2JU2qKO8ZaJY5ZU
cnW7e1+MjINWqzkqnncELz0EOkVpZEB6gxzGnJZW3ewgGCf+XHIn4bqSYHro65Ri
IGeb0OzgklUVDTiQay9Vz4KHJbygJRbJM+PEi07nSbILqRHe2qH4qJh+4/TipN6T
1SfjJXGP5jhJakVyoSvV2jegApR9nOlEeNzsvnMIhDytcq0cbzUDkGSc6grBDYbu
m8K4WHIx9heGRH49e8IB4ZbfRvwxUMJ0Cs4Hjm52sbBzbn2ucdJn3gF8z+PXOBnq
ZiEIgwi3icJ+wZO7ADyKOQy9Id6r2CgE2oEMBDxGq5N1EF7TAJNJmZkyfMp77gFN
zE7aja4n3JUP6EnihWrFTuuntBMC/AgoHNXRSJRTl+QDVBS7TT8bXnVg+aMy3yaG
FHjdo7e2OIFg2Endm184whsMAcTVKHwgjmnQNIJmBQ0I4IlbODchKe6OHyjPX82I
yC4HTKkRpPOyMgwwFFoMI5122q6MmKEiMH8v6DEWBb20t8iyD7Ez4DkYBnOFoe4p
eV2Ew0zs1VXGTofHHBD86B82xTxAJxnQII9jtW3xcI+RvcosiVY8Bk7tXBIbE1u6
3U/wyX7CkkfweKDeqpK0NlNqhBtuo0GfiihZbRb0QSP2LvtVSkMCgP/LJf5s/8/F
O2MBL7BlQMYVWDnn56Ei
=VWa4
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
