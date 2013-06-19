From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 4/4] regulator: Palmas: Add TPS659038 support
Date: Wed, 19 Jun 2013 17:42:24 +0100
Message-ID: <20130619164224.GZ1403@sirena.org.uk>
References: <1371621470-22279-1-git-send-email-j-keerthy@ti.com>
 <1371621470-22279-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3483100587476789950=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371621470-22279-5-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
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
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============3483100587476789950==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="puacTriGDskFP02p"
Content-Disposition: inline


--puacTriGDskFP02p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 11:27:50AM +0530, Keerthy wrote:
> From: J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>=20
> Add TPS659038 support.
>=20
> Signed-off-by: J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

This doesn't apply against my current tree as the PMIC bindings document
isn't in mainline yet.

Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

assuming there's a tree where that does exist.

--puacTriGDskFP02p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwd9tAAoJELSic+t+oim97boP/13KOIGcQ/KOAq97/yNqWjNg
Qyed+YxGGzlTRS8zenpmrsrBhOh3bSWFIJ14bjqN0NzgdcwZJMqiBM1mXB90Rpcd
otJHjq9hJB8KBM5/40e65iRzdnmZQjs6DJM4vkwRCIMBhYNAYZyUMYZpApusGb0f
HDc7q7SeTHZaeUJ1bCXG8JfizUmY/CWUxHa3q3O6nlhV0WjYKRIXJy4QnEc9umgB
BDbi/z02U6FMMQ6SU7ZnqWQMyIOHy8Aq9MFKbho9q9EfDs7cNmbO4NcbNZtvDDUA
ZIyt9p/9l+FRAZK5DQ6+Zk38EhBybrDnRrhNXC9gwOg9qMLSAM/ke0wZ7YR5UZxU
02l9SKAqETHKYOHmSUcDHKBAadG6hl9NXdQzjkl8S9fEdx0XAhwAP+Q8wRpbRZHr
gG1czpVeqBDzXkzfKZvlFjSSkABjjrJFptUZchLNIcNV27sVtlny+ArusA08CB3T
9I8BZGkI1OYSu7mHaraGY27PfK1HWZ+4dKQb1L4zA/clH1sb8JMxFOzvScKsB/Ki
QJtOCkCaapWaHeJdeZpJdU670wIVknJUgq7y8YlVqJVjBG7S0a8d4363j8uHF4vq
q3aS+EBLnXMGmHcaGCICcfFGCb+eS+2wJa+K/AE6w4SuapADhcdwVl3oERrFpjU2
uNexqo/6tEraYCq3mfIN
=kjBq
-----END PGP SIGNATURE-----

--puacTriGDskFP02p--

--===============3483100587476789950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3483100587476789950==--
