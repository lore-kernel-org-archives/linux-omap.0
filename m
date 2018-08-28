From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] memory: Convert to using %pOFn instead of
 device_node.name
Date: Tue, 28 Aug 2018 12:42:11 +0200
Message-ID: <20180828104211.GA9386@ulmo>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-29-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-29-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 08:52:30PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>=20
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c           | 18 +++++++-----------
>  drivers/memory/samsung/exynos-srom.c |  4 ++--
>  drivers/memory/tegra/mc.c            |  6 +++---
>  drivers/memory/tegra/tegra124-emc.c  | 12 ++++++------
>  4 files changed, 18 insertions(+), 22 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluFJwEACgkQ3SOs138+
s6EBJA/+LbK0Pndw2X6MqTI5f05rIP/mKjhRkiqnK05yE7yN2wp0Cnw9ojCsz3Rs
sRlxaNQp5l8FtnZm9UYmzLIidjOS9AACtrkR8uYaOQK0JyGUIhH9EssjN9tzZr7o
1akD1NR8NeGsJQxpc/vnw7rx6rVjWwmYrPNE8O5osXqrin3/RQeBm93Wk9Pi/OLK
UP7A/CUXNFMGM43jqThk4C6k3scA6f8OPVPeYosqlMyyMkuiKjGN2sgF19wjKlV7
5kXzqDPAoEMKYVuXnzYapQYBRaFzvrouvFDGbg/EOzwFyKjz0ZJM5XIs/4gj9mNO
RmysJ6nR1057ff0zL1wERQUlaV+/FXq7iU9G0Gr9o4wWDKkA36AKN0kFMCFgF+RR
NQdNhjtyayt5vmp9IQsa8KulbEYLdRGamO+fS2Q3ZB4qtmVQuxQwtBSirpE3dPUR
cgyoonqPmV/D8wjCvX0LQqlCcAsTwnzrPuPg+48UCYWgxFRXbtxugPzCfKierbUP
IXbc9uiUxAB09K8Xgqa9zRIQaoe+Q1KQWpl2GvCrz8sneyUpC/eujui0BbEDBXtV
8w9uYypfKMy0Ij2JQN5/brd/HdsNP3ssfjG6S7d2oDWxCroyYyHiygAdPFU9u7c5
bdquQEHSIOZffLL/ymOZ+87WjfKxT6NizWI57CMC0MXOR3JsQ44=
=vAak
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
