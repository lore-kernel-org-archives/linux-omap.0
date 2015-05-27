From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 0/6] Use DRM component API in tilcdc to connect to
 tda998x
Date: Wed, 27 May 2015 11:37:03 +0300
Message-ID: <5565822F.3090201@ti.com>
References: <cover.1431083641.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dkETE9A5OHOrMJOuD20j696t8IxlBVFPh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60020 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791AbbE0IhX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 May 2015 04:37:23 -0400
In-Reply-To: <cover.1431083641.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr

--dkETE9A5OHOrMJOuD20j696t8IxlBVFPh
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 08/05/15 14:27, Jyri Sarha wrote:
> For all that I know this should be good for taking.
>=20
> Changes since v4
> * Rebased on top linux-4.1-rc2
> * Drop "drm/tilcdc: Decrement refcount of ep-node from of_graph_get_nex=
t_..."
> * Make connector_funcs const in struct tilcdc_drm_private because
>   struct drm_connector's helper_private has been qualified as const in
>   linux-4.1
> * Check if a subcomponent has already triggered the unloading.
>   - Fixes an oops if the external encoder is unloaded first and tilcdc =
after
> * Add comment to explain hijacking of external drm connectors helper hi=
jacking
>=20
> Changes since v3 version of the patch-set:
> * drm/tilcdc: Add support for external tda998x encoder
>  - Hijack external connectors helper functions
>  - Remove select of nonexistent DRM_TILCDC_INIT in tilcdc Kconfig
>  - Correct author mail address to tilcdc_exteral.h
> * drm/tilcdc: Add DRM_TILCDC_SLAVE_COMPAT for ti,tilcdc,slave binding
>  - Add a header file for tilcdc_slave_compat.dtb symbol declarations
>=20
> Changes since v2 version of the patch-set:
> - use obj-y in Makefle for tilcdc subdir in:
>   "drm/tilcdc: Force building of DRM_TILCDC_SLAVE_COMPAT"
> - move to last:
>   "drm/tilcdc: Decrement refcount of ep-node from of_graph_get_next_end=
point"
>=20
> Changes since first version of the patch-set:
> - Rename DRM_TILCDC_INIT to DRM_TILCDC_SLAVE_COMPAT and make it visible=

> - Add separate:=20
>   drm/tilcdc: Decrement refcount of ep-node from of_graph_get_next_endp=
oint
> - Reduce info-level spam
> - Use component_master_add_with_match()
> - Be more explicit about tda998x being the only supported external enco=
der
>=20
> Remove tilcdc slave support and connect to tda998x trough its
> component DRM API. For dtb backward compatibility the code creates at
> boot time a DT overlay based on the earlier binding. The overlay
> conforms to the new graph based binding.
>=20
> The "drm/tilcdc: Decrement refcount of ep-node from
> of_graph_get_next_endpoint" should probably not be merged. The "of:
> Decrement refcount of previous endpoint in of_graph_get_next_endpoint"
> is eventually going to be merged and before that leaking of two
> of-node refcount increments each time the module is loaded is not that
> serious. The of-nodes live forever anyway.
>=20
> The merge of the dts patch can be delayed until the next merger
> window, when the other patches are already in. The
> DRM_TILCDC_SLAVE_COMPAT should keep the bbb HDMI operational until
> then.
>=20
> The first patch is just a bugfix and can be applied or dropped
> independently.

This works fine for me, and looks ok. There is a minor problem in the
Kconfig, where you define DRM_TILCDC_SLAVE_COMPAT before DRM_TILCDC.
That causes menuconfig to show the items wrongly.

 Tomi


--dkETE9A5OHOrMJOuD20j696t8IxlBVFPh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZYIvAAoJEPo9qoy8lh71jh4P/0Q+ulQ+unW37B6oJhQTg4cU
DWZghNM5IR6NoUOfWxDwYtFnfw3hpgTtdOqtfusYoujihrz0sbD5RUYBSZ6FXe8w
X7nKlBLme9MqVqybD+gWmX4mwK2rOKir7vo0YI0ZOEvAJlVbcwPM3c4R+nmf8DbM
VA5Pj+yuWMow9PpMe+d9wbaRo5efcEJTW5GkxcHh27da4ul5mlCiE45ibjXoU9NR
/URAnRNHT4Fy9TMoqLcb4/8slDAxo8bG0YgliZwMxLaf3im/e0H+rRCKSxH106Y3
L/8jxxTcNxiC0/fvijCdlAwLave5yCP0islMkBVUpGIX1Vc9ijRcUeeM0kxA1pO7
ffptLyYq7n+SG2sigMN3x2Tq9JBUJNXGeLk2nJz4hUEIv57w09Ip87WYhpKGc8Dc
ibwdAvfdaNUf/RkkS797D3Qb7wgO4zZP7HadMQmNhUe8LYhFQTL7J6RGv9lJ0LkC
be/s6Pb/4VvHqoa6vYL/z9UNjH7dLJmgPpF4K1gqacjk2/J83IyhY+Z6g/MsQ2c+
3H9IXQOW0ERayRd2mhZonpSTPdJngRsDPavfPW5bPDvknE8L7aH8HAiaHFeLPFcr
r7pxjv0yYbOXt6KXFgrqbhW7RE0SD4q2H50KmyHpe6M4zljpEPByIrXdEAXe4/rF
fIGpAPk9WKC47EC1sL3n
=5bok
-----END PGP SIGNATURE-----

--dkETE9A5OHOrMJOuD20j696t8IxlBVFPh--
