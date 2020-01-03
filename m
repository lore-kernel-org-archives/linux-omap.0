From: Sebastian Reichel <sre@kernel.org>
Subject: Re: v5.5-rc4: OMAP build failure
Date: Fri, 3 Jan 2020 20:23:02 +0100
Message-ID: <20200103192302.bzbcqojhop2jwxpt@earth.universe>
References: <20200103081807.GE15023@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vmv3u76x5arek23d"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200103081807.GE15023@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--vmv3u76x5arek23d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 03, 2020 at 10:18:07AM +0200, Aaro Koskinen wrote:
> Hi,
>=20
> Build fails when CONFIG_RESET_CONTROLLER is not set:
>=20
>   LD      .tmp_vmlinux1
> arm-linux-gnueabi-ld: drivers/soc/ti/omap_prm.o: in function `omap_prm_re=
set_init':
> /home/aakoskin/git/devel/linux/drivers/soc/ti/omap_prm.c:345: undefined r=
eference to `devm_reset_controller_register'
> make[5]: *** [/home/aakoskin/git/devel/linux/Makefile:1078: vmlinux] Erro=
r 1
>=20
> Some missing dependency?

https://patchwork.kernel.org/patch/11294205/

-- Sebastian

--vmv3u76x5arek23d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4PlJAACgkQ2O7X88g7
+ppafg/7B0co+4GDi8yKvtzTW7Rufju8kzQao2Y7+DxMrGb6Yy7tMkHlVIH2OYg+
2kjAjOmKCMYPOmBpc45OvPU4NwgLfCJGBp6VPBeGWe0GUaqr1LRcgESd+lN8bQGw
oKcsUgyNNuMPR2JDKGkyd8tuFhEULDFm442qz+loQgteIphiLJao9gWK/7KLZ4s5
157CsFmpl3h+sAvmeQSHoAXJINEvRUP4r+qvwPONlwsOCYzN47E5SGD7f/kPAsGh
eM6TTa4UcwlyJseL61BrQsIeLPSd8N214aXcYAgoT5Ct4i0CjAMFbASFQoPBvbG3
Racm/AMXF3eOOTiFjGxvZOoETmCYp0LGKJq+97DsnCOA8cZxlSD+RS3EThJrql2O
PmCf6WDoaSdJoVwHhBOztMBMj8NWpFVmA/cUiNxt5GtlQ6SxIaCpvB7eTChLYHY0
jPi7cjllcNyeNksghklFKWCEJ+1HeEHvD8RwzaMB5KLWKJnwK0Wz5VGPbKkLJ/rT
q1CJZQwiqovPYOanpI42Tk0fm4+JE5OOyWTQR/uDNndB+p0ctKavTg62LW/AOu94
v0mkUwdzHXomWbuFakTE177hREKAC51kga58fdAmHdQgaWxk6vD/QezgtNqfI8vP
xyHpisnHrRrVXr15AnBAdPZYWzhKXwZLjnlEO7N5leuc8avMjxU=
=fpqB
-----END PGP SIGNATURE-----

--vmv3u76x5arek23d--
