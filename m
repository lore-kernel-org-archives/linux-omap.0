From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] MFD: Change TWL6025 references to TWL6032
Date: Wed, 19 Jun 2013 20:36:52 +0100
Message-ID: <20130619193652.GJ1403@sirena.org.uk>
References: <1371644642-934-1-git-send-email-oleksandr.kozaruk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5456465805090371840=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371644642-934-1-git-send-email-oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============5456465805090371840==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qRu+kOci6Aaql5G6"
Content-Disposition: inline


--qRu+kOci6Aaql5G6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2013 at 03:24:02PM +0300, Oleksandr Kozaruk wrote:

> There are non-mainline branches that use twl6032 by its name (for example
> git://git.omapzoom.org/kernel/omap.git). There is intention to add support
> of twl6032 device in mainline, but we'd like to know if we can use twl6032
> instead of twl6025 in our new patches, that we are going to provide.
> Related discussion: https://patchwork.kernel.org/patch/2686331/

It's always been OK to use the new name, the only question was if it was
better to keep the old name supported as well.  Given that the chips are
essentially nonexistant now your current approach seems sensible so

Reviwed-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

--qRu+kOci6Aaql5G6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwghRAAoJELSic+t+oim91rMQAJUAcSoRIh6J8WgAp3MuXH6I
wHaM1UWySf8ULxIdOorogkQ4oIRoK4Tb9bP9BnvN36X4SEG6l/A850Awvg+LX5k+
vQwEwzekW9BG/KgzYbz6172Nym9WjDQJx9mnCo0W/FCSSr4v95pZHyZsV6ZX64K5
wwkORVriKT00Tc2q7x++qFKw6oUKVCyfeFXLXbs+rTreZuwZk9hK+2ZigfKoetkw
GNQ1fI3O65eAmUtETPPmfNRnmVypF5Nll4UgcqpTNDrwZfQPvcVe/eq9MVLpp+f4
gl8zS2VpcSfMR0MY/9zgbiPYQPQSYDqiGQ14naEJOm8hUYGnxd8TB31TjoGIwXXm
TqhMfSKpDiWAUsCprcfym8ZC7CGm1B/JNABLg389t4B7MLesVGR/MfhxncSFHb3H
wnbsTUG08JAY6ejC5EkcHgHtNwxONptbRJt/YGrdqvExmCMAae+5Q5mY0SsnYDzv
2vox1lJzHr4Qu3Tqxain3i5LOCNBp+3Iwym5YfvqQc+H4XdWbCAscfc6/xl1YlU1
ihTbHoLBUps608p+gLPdfN0DTDm292DBrYSofR40Dl+8XnLAwBgIpO6rcttKiwI3
7lIsKwQ9gqDAA9sKFLgN1TM+mbQ47QFW6RykoYB5aczMEcUnPZjQMAlf9kX5qX46
1d2wtP4/y/vCUWiTyjYo
=lZSA
-----END PGP SIGNATURE-----

--qRu+kOci6Aaql5G6--

--===============5456465805090371840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5456465805090371840==--
