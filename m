From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm: omapdrm: Fix oops on rmmod
Date: Fri, 24 Mar 2017 09:13:47 +0200
Message-ID: <22a5e58f-6198-bd16-a103-3859c0f026ef@ti.com>
References: <20170323170459.20906-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0270986667=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170323170459.20906-1-tony@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--===============0270986667==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8j8Ha2weTmAbGNLlDIhf8EVPGb7c3aFsK"

--8j8Ha2weTmAbGNLlDIhf8EVPGb7c3aFsK
Content-Type: multipart/mixed; boundary="grFAeFJEd1eEgurav2SgUtdail2mSDXB2";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Message-ID: <22a5e58f-6198-bd16-a103-3859c0f026ef@ti.com>
Subject: Re: [PATCH] drm: omapdrm: Fix oops on rmmod
References: <20170323170459.20906-1-tony@atomide.com>
In-Reply-To: <20170323170459.20906-1-tony@atomide.com>

--grFAeFJEd1eEgurav2SgUtdail2mSDXB2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/03/17 19:04, Tony Lindgren wrote:
> Looks like in Linux next we can now get an oops when unloading omapdrm:=

>=20
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
> ...
> LR is at omap_drm_irq_uninstall+0xb0/0xe0 [omapdrm]
> ...
> [<bf6806a8>] (omap_drm_irq_uninstall [omapdrm]) from [<bf67f260>]
> (pdev_remove+0x50/0x88 [omapdrm])
> [<bf67f260>] (pdev_remove [omapdrm]) from [<c058fa28>]
> (platform_drv_remove+0x24/0x3c)
> [<c058fa28>] (platform_drv_remove) from [<c058ddb8>]
> (device_release_driver_internal+0x160/0x1f4)
> [<c058ddb8>] (device_release_driver_internal) from [<c058de90>]
> (driver_detach+0x38/0x6c)
> [<c058de90>] (driver_detach) from [<c058d0b8>]
> (bus_remove_driver+0x4c/0xa0)
> [<c058d0b8>] (bus_remove_driver) from [<c058fb1c>]
> (platform_unregister_drivers+0x24/0x30)
> [<c058fb1c>] (platform_unregister_drivers) from [<c01e26e8>]
> (SyS_delete_module+0x150/0x218)
> [<c01e26e8>] (SyS_delete_module) from [<c01077a0>]
> (ret_fast_syscall+0x0/0x1c)
>=20
> Fix the issue by checking get_vblank_counter() before trying to
> call it.

Yep, there was a change in the DRM core that broke omapdrm. I've been
trying to understand how to fix this. I hope I can send a patch today.

 Tomi


--grFAeFJEd1eEgurav2SgUtdail2mSDXB2--

--8j8Ha2weTmAbGNLlDIhf8EVPGb7c3aFsK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY1McsAAoJEPo9qoy8lh71LTUP/jJyH4ApuWz9i12Ua2Hvlevk
PHeeqmfqUo+CpD/2fHBi6tual7q7R+2bsxu4w1UQ8AiOPXJVtzUySAbUC4ywqMPH
latp8WI+tYKDgIAYVlebRMS2eptZgJvow/8RAplmHjBiYDs58dHhFjftEOyZk8ce
qkOLfsKcKZA49v2Xq7YqOfZoRMmIYRHb2j8a/ARhwe2OBRIflCaHxF/J2FxSm36+
uslvXbkINFmfbw9iyPTjMeBs4zsyTdpkHcxJOYVLwJW7xeQj/zvtq64DG3VrwWYF
bcr7swF0W0LYmorwBL0NfQJBZBKcNlE408xDj1YkJocPV4DG+vwbcATd5dO6s10y
8TkZuYQ/Sf6PIHwWFRqhrVuGHA1q1c15QQc/URvu12/9kCqUjj4Vs3LuOL9fkzD5
cIVi30pkl+HqhVU5GGyYGkT+eca2c0UU5iFEY9/0epYwmStOzVnmKv+rHpvYYSyt
RhVnROn3JvTx/m2hapOOC/T/hYDbEt/0alQc0fcrzXRBSObOpGWg0Ya7mtlpBLJC
LlzdU4xY06zDO87xU6RLrDUDHEYMqZH5Cb4xoTyFhtYAc3M9zVKJTH3ToodbfxGj
As2pFoJYnwIe0SUyt90ICl6Au3tDHIvQpyT/OUY2LX36OANgO5YfnAshTDduqW+5
6KhgOo3Z0ga7FB5krbbt
=nF9e
-----END PGP SIGNATURE-----

--8j8Ha2weTmAbGNLlDIhf8EVPGb7c3aFsK--

--===============0270986667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0270986667==--
