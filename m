From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 0/5] drm/panel-simple: Add panel parameters for ortustech-com37h3m05dtc/99dtc and sharp-lq070y3dg3b
Date: Mon, 24 Jun 2019 20:44:59 +0200
Message-ID: <0842FF88-D8E0-441B-837B-769C2EF6C1CB@goldelico.com>
References: <cover.1559905870.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1559905870.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, tomi.valkeinen@ti.com, imirkin@alum.mit.edu, marek.belisko@gmail.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 07.06.2019 um 13:11 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> V3:
> * add bindings documentation (suggested by sam@ravnborg.org)
>=20
> V2 2019-06-05 07:07:05:
> * fix typo in 99dtc panel compatible string (reported by =
imirkin@alum.mit.edu)
>=20
> V1 2019-06-04 14:53:00:
>=20
> Since v5.2-rc1 OMAP is no longer using a special display driver =
architecture
> for DPI panels, but uses the general drm/panel/panel-simple.
>=20
> So we finally can add SoC independent panel definitions for two panel =
models
> which we already had worked on quite a while ago (before device tree =
was
> introduced):
>=20
> 	https://patchwork.kernel.org/patch/2851295/
>=20
>=20
>=20
> H. Nikolaus Schaller (5):
>  drm/panel: simple: Add Sharp LQ070Y3DG3B panel support
>  drm/panel: simple: Add Ortustech COM37H3M panel support
>  dt-bindings: drm/panel: simple: add ortustech,com37h3m05dtc panel
>  dt-bindings: drm/panel: simple: add ortustech,com37h3m99dtc panel
>  dt-bindings: drm/panel: simple: add sharp,lq070y3dg3b panel
>=20
> .../display/panel/ortustech,com37h3m05dtc.txt | 12 ++++
> .../display/panel/ortustech,com37h3m99dtc.txt | 12 ++++
> .../display/panel/sharp,lq070y3dg3b.txt       | 12 ++++
> drivers/gpu/drm/panel/panel-simple.c          | 63 +++++++++++++++++++
> 4 files changed, 99 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.tx=
t
> create mode 100644 =
Documentation/devicetree/bindings/display/panel/ortustech,com37h3m99dtc.tx=
t
> create mode 100644 =
Documentation/devicetree/bindings/display/panel/sharp,lq070y3dg3b.txt
>=20
> --=20
> 2.19.1
>=20

any progress towards merging this somewhere? It did not yet arrive in =
linux-next.

BTW: should also be applied to 5.2

BR and thanks,
Nikolaus
