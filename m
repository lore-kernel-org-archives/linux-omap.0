From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCHv2 7/9] drm/panel: simple: add
 newhaven,nhd-4.3-480272ef-atxl LCD
Date: Tue, 10 Jul 2018 12:11:44 +0200
Message-ID: <20180710101144.GE1504@ulmo>
References: <20180618132242.8673-1-tomi.valkeinen@ti.com>
 <20180618132242.8673-8-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0471524162=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180618132242.8673-8-tomi.valkeinen@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============0471524162==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 04:22:40PM +0300, Tomi Valkeinen wrote:
> Add support for newhaven,nhd-4.3-480272ef-atxl to panel-simple.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> ---
>  .../panel/newhaven,nhd-4.3-480272ef-atxl.txt  |  7 +++++
>  drivers/gpu/drm/panel/panel-simple.c          | 29 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/newha=
ven,nhd-4.3-480272ef-atxl.txt

Applied after reordering the new entry to be in the proper alphabetical
ordering.

Thierry

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEhl4ACgkQ3SOs138+
s6GWCQ/9FVgpJWa61AhFFDXegDzsuSVH5YGSmXZ4KRcXviCsd9e1C7vmjBYXWQ3S
q1rB12JpzssS5p/ArAaMuWZDf6n3T93o25bnEFi3qA83RpORtijtPzJdQXuH8DwS
/xdh5k3/vEOTuoROh6lbwNLrVhNfaFqKPz9RPgMqXSKK7OPN4p8/CoVlCxOem1H8
VR/Ne2FVmYP3g7MHHo+Ze/QQthi60Uaz4hATlarNfoys8Oj8cLxDvY4K8+OtgpK5
1VfvRSoM6sviOeBToVB3ip1kPADcreQOnONG8ywG/AcOUQJTZgKd1hFomSWVb2zQ
o1qv63czJiNUo/+sMjro0YcUyjbsS52CLccuQqjSNwNNx2crfk4uwA22xfQUdZOz
8Umc/FW87YlSNpcBxNyCbl0Nyx0Y2qw2UjtAiK78qhaF3Ed7SF+eVWuqGhskmcs1
KXky2ig7UTY2z9Der6ymgDbS4CasJ1fTt6vYa08QI+qJoCLZmxFYx8wtFyz+RT7b
+cETTku3327x4GVR+LNmdVRgZuvLzUjOasLAf36HJpVbT8PlY+gP3Nd/WXG9PcEB
d8c5Oom9nFEAXxVYuOh5qveqTAy1P0UHBwHB3wya89tLOUlDplNrAFS10hg3yp2h
BkCwA0EA82wA520dc5ijtCPxxcHL51GuK227qrM/nq1x8VdhnSA=
=qSiu
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--

--===============0471524162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0471524162==--
