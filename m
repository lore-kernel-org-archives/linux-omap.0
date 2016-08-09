From: Jyri Sarha <jsarha@ti.com>
Subject: [GIT PULL] drm/tilcdc atomic modeset support and some non critical
 fixes
Date: Tue, 9 Aug 2016 22:17:33 +0300
Message-ID: <6d5d3ce6-e43f-9489-2dff-af6c3fb85e68@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1442280680=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dave Airlie <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-omap@vger.kernel.org

--===============1442280680==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="DdIFQgjU1iEqeeu03N45QtCvpbeRvsBnB"

--DdIFQgjU1iEqeeu03N45QtCvpbeRvsBnB
Content-Type: multipart/mixed; boundary="F3DgGI7vq0eL6KtqkoJJlMIF0DXjsR089"
From: Jyri Sarha <jsarha@ti.com>
To: Dave Airlie <airlied@linux.ie>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Message-ID: <6d5d3ce6-e43f-9489-2dff-af6c3fb85e68@ti.com>
Subject: [GIT PULL] drm/tilcdc atomic modeset support and some non critical
 fixes

--F3DgGI7vq0eL6KtqkoJJlMIF0DXjsR089
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Dave,
Please pull tilcdc atomic modeset support and some non critical fixes.

The patches were under review [1] and there were no comments any
more to the v2 series. Code has been rebased and tested on top of
latest drm-next and the only change needed was to adapt to the
drm_atomic_helper_swap_state() parameter change.

[1] https://lists.freedesktop.org/archives/dri-devel/2016-June/112071.htm=
l

The following changes since commit 5c6c201ccbaf9d3901f829441d457293f7ca8e=
f4:

  drm: Paper over locking inversion after registration rework
(2016-08-08 16:08:25 +1000)

are available in the git repository at:

  https://github.com/jsarha/linux drm-next-tilcdc-atomic

for you to fetch changes up to e0e344e620b11b76376027087574f8ae1c7807fd:

  drm/tilcdc: Change tilcdc_crtc_page_flip() to tilcdc_crtc_update_fb()
(2016-08-08 23:05:19 +0300)

----------------------------------------------------------------
Jyri Sarha (29):
      drm/tilcdc: Restore old dpms state in pm_resume()
      drm/tilcdc: Move LCDC_SYNC_LOST handling inside if (ver =3D=3D 2)
statement
      drm/tilcdc: Write to LCDC_END_OF_INT_IND_REG at the end of IRQ
function
      drm/tilcdc: Move waiting of LCDC_FRAME_DONE IRQ into stop()
      drm/tilcdc: Increase time out for waiting frame done interrupt
      drm/tilcdc: Call drm_crtc_vblank_on() and *_off() in start() and
stop()
      drm/tilcdc: Refer to panel.txt and tfp410.txt bindings in tilcdc.tx=
t
      drm/tilcdc: Avoid error print by of_graph_get_next_endpoint()
      drm/tilcdc: Fix tilcdc component master unloading
      drm/tilcdc: Make tilcdc_crtc_page_flip() public
      drm/tilcdc: Make tilcdc_crtc_page_flip() work if crtc is not yet on=

      drm/tilcdc: Add dummy primary plane implementation
      drm/tilcdc: Initialize dummy primary plane from crtc init
      drm/tilcdc: Add tilcdc_crtc_mode_set_nofb()
      drm/tilcdc: Add tilcdc_crtc_atomic_check()
      drm/tilcdc: Add atomic mode config funcs
      drm/tilcdc: Add drm_mode_config_reset() call to tilcdc_load()
      drm/tilcdc: Set DRIVER_ATOMIC and use atomic crtc helpers
      drm/tilcdc: Remove obsolete crtc helper functions
      drm/tilcdc: Remove tilcdc_verify_fb()
      drm/tilcdc: panel: Set crtc panel info at init phase
      drm/tilcdc: panel: Add atomic modeset helpers to connector funcs
      drm/tilcdc: tfp410: Set crtc panel info at init phase
      drm/tilcdc: tfp410: Add atomic modeset helpers to connector funcs
      drm/tilcdc: Enable and disable interrupts in crtc start() and stop(=
)
      drm/tilcdc: Use drm_atomic_helper_resume/suspend()
      drm/tilcdc: Get rid of legacy dpms mechanism
      drm/tilcdc: Remove unnecessary pm_runtime_get() and *_put() calls
      drm/tilcdc: Change tilcdc_crtc_page_flip() to tilcdc_crtc_update_fb=
()

 .../devicetree/bindings/display/tilcdc/tilcdc.txt  |   4 +
 drivers/gpu/drm/tilcdc/Makefile                    |   1 +
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               | 375
+++++++++++----------
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                | 207 ++++++------
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |  12 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |  13 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel.c              |  11 +-
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              | 132 ++++++++
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c             |   8 +-
 9 files changed, 465 insertions(+), 298 deletions(-)
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_plane.c



--F3DgGI7vq0eL6KtqkoJJlMIF0DXjsR089--

--DdIFQgjU1iEqeeu03N45QtCvpbeRvsBnB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXqixUAAoJEJA2s1DX1hlBf+UP/1VrVzIQvBQr7V7jJ0nW2QeJ
V/3jRIrLSCgEDLpnCljkABLNVMQu5MPLOJleqhl7YO1WkZYmZlhzTAf1R5sBDXOt
7bSCeLx8W06Cm+fpHL2BhffabIP+cFJ9XgZ4P0QfMbHNS6ILvSo1vAyt7Gf9xIqZ
qSgRHSuAbTMXngI6ULFZ4ADk25eL5kPx8wzd2EqxEDEUaD4COXc4qQdkU3roN/5P
29iPgPMkRtPlhmAI5yOUP+ZvBtHS9jlIfrozqpTexZ+LX12uFh6E1enwPXUWUjZs
sGEyYG3kINfp+57R5FfL3z6Z+f3OO4mL/fAbb2Ac9rXgJXdDrGgehcjCLuxcZmVC
enYJtcMAA+g9WpcJjcR1I/Jy2mOrWFA6aw6402YkSXZUD3DSEptWE9Qe7+T0qNsW
VumyAVxY6QDxdWLdK+++u2joAy8hx++Y58BNKHEG3iJE/frhJC44Q/BUabh2J8ny
5gUlKwb4NIeGkfT0zGL9jfTBC7xXGHW9Z+1jb3E2xLhWUYDKIdGtLto3Woa+H+Sy
kcVTfF0ZK0qZQg11bu3T3PX0/iSFaYL7kuoYCCF8xjWjGFWX0yC2c9u/ykTqH5++
nuaZTKea4DcVaLRu4ilR7yF4Vd93BXiBMKhLlVbOE9m7ywvfzbDiNJ7OpgNkbCrW
tSHbm45Id2WHgYVSJms8
=jG4S
-----END PGP SIGNATURE-----

--DdIFQgjU1iEqeeu03N45QtCvpbeRvsBnB--

--===============1442280680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1442280680==--
