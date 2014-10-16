From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/5] OMAPFB: remove wrong __exit and __exit_p()
Date: Thu, 16 Oct 2014 08:19:39 -0500
Message-ID: <20141016131939.GB3480@saruman>
References: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
 <1413452387-25452-2-git-send-email-tomi.valkeinen@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48062 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaJPNTs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2014 09:19:48 -0400
Content-Disposition: inline
In-Reply-To: <1413452387-25452-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2014 at 12:39:44PM +0300, Tomi Valkeinen wrote:
> omapfb device can be unbound, so using __exit_p() for the driver's
> remove callback is wrong.
>=20
> Remove __exit_p() and __exit from the driver's remove.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

and why was my version dropped ?

http://marc.info/?l=3Dlinux-fbdev&m=3D141331137230988&w=3D2

--=20
balbi

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUP8XrAAoJEIaOsuA1yqREgDAQAIJYW4IWUg65yuGQXOVHDGp7
Dj6+i1llYQrO19i51SjgzX3UB21hCZY3yib2r7QcZf6vXCw3qdpT7z7l9yVZEG7m
WMRRtYCTT1PbA6r7rbTaOQjsVhwZ3g4rxmVSpV9pe2l6axiDA0ItMiCu5gphHLdt
wqKAoMdGqYZMMOW8H0Ixqn9CilQkawIXb9f5m5P+C/Bw56OdnpwdfoVP+fgrTz6b
xa8GEHlNxlpY9fm/cAlM+CSqnO6P4RMxpL2P6tpf80uyidsDkRO/7NkSi3xPdua5
ERjvhLVQduyA7wfW7rK12K8iknIXVUc6QBynD0Vklp7imtlqvqYonpowHoorpdvg
1a32YNsKVxe+EOb4ILepmfIA86N/mdi5zxqZndGEwVweBEsdQotpHy9DbIY4unqj
tZbxGmUoRs06xw8x2Ho4gErLwpKIs+QCz7iBBApgpRDcLLLszXlGM7/fVs7toj3X
ltj7lnDMLEUn5ZbLMuNQ4AnHJK4unv7OZ0PSbKHfrnooBu8pezmbhkzjIM2eZtDv
2Z0Lk9lFoAhixGlSNHbk9suGvaQ6zi+AViL17bZF7DhPc9aYta41jgoCJP6DVc1p
U2J9095RTxXqXFNBF3wP8ESLJ887t8FN9Pq0yNYZR28icphnBke2sKq3KC+TmfUr
wSYDS7OWosreXVfI565a
=yIRh
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
