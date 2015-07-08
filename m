From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 00/10] i2c/drm: fix i2c adapter device driver user counter
Date: Wed, 8 Jul 2015 15:54:55 +0300
Message-ID: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The 01/10 change adds and exports new of_get_i2c_adapter_by_node()
interface of i2c core, the rest of patches fix current users of
of_find_i2c_adapter_by_node() interface.

of_find_i2c_adapter_by_node() call requires quite often missing
put_device(), and i2c_put_adapter() releases a device locked by
i2c_get_adapter() only. In general module_put(adapter->owner) and
put_device(dev) are not interchangeable.

This is a common error reproduction scenario as a result of the
misusage described above (this is run on iMX6 platform with
HDMI and I2C bus drivers compiled as kernel modules for clearness):

    root@mx6q:~# lsmod | grep i2c
    i2c_imx                10213  0
    root@mx6q:~# lsmod | grep dw_hdmi_imx
    dw_hdmi_imx             3631  0
    dw_hdmi                11846  1 dw_hdmi_imx
    imxdrm                  8674  3 dw_hdmi_imx,imx_ipuv3_crtc,imx_ldb
    drm_kms_helper        113765  5 dw_hdmi,imxdrm,imx_ipuv3_crtc,imx_ldb
    root@mx6q:~# rmmod dw_hdmi_imx
    root@mx6q:~# lsmod | grep i2c
    i2c_imx                10213  -1

                                 ^^^^^

    root@mx6q:~# rmmod i2c_imx
    rmmod: ERROR: Module i2c_imx is in use

To fix existing users of these interfaces and to avoid any further
confusion and misusage in future, add one more interface
of_get_i2c_adapter_by_node(), it is similar to i2c_get_adapter() in
sense that an I2C bus device driver found and locked by user can be
correctly unlocked by i2c_put_adapter().

Mainly the change concerns DRM users of I2C bus device.

The change is based on torvalds/master branch, d6ac4ffc61a

RFC of the 01/10 change is http://www.spinics.net/lists/linux-i2c/msg20257.html

Vladimir Zapolskiy (10):
  i2c: add and export of_get_i2c_adapter_by_node() interface
  drm: dw_hdmi: use of_get_i2c_adapter_by_node interface
  drm: exynos_hdmi: use of_get_i2c_adapter_by_node interface
  drm: imx-tve: use of_get_i2c_adapter_by_node interface
  drm: panel-simple: use of_get_i2c_adapter_by_node interface
  drm: sti_hdmi: use of_get_i2c_adapter_by_node interface
  drm: tegra: use of_get_i2c_adapter_by_node interface
  drm: tilcdc: use of_get_i2c_adapter_by_node interface
  fbdev: omap2: connector-dvi: use of_get_i2c_adapter_by_node interface
  i2c: i2c-arb-gpio-challenge: use of_get_i2c_adapter_by_node interface

 drivers/gpu/drm/bridge/dw_hdmi.c                   | 14 ++++--
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  7 +--
 drivers/gpu/drm/imx/imx-tve.c                      | 56 +++++++++++++++-------
 drivers/gpu/drm/panel/panel-simple.c               |  9 ++--
 drivers/gpu/drm/sti/sti_hdmi.c                     | 19 +++-----
 drivers/gpu/drm/tegra/output.c                     | 19 ++++----
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c             |  6 +--
 drivers/i2c/i2c-core.c                             | 20 ++++++++
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c         |  3 +-
 .../video/fbdev/omap2/displays-new/connector-dvi.c |  2 +-
 include/linux/i2c.h                                |  6 +++
 11 files changed, 104 insertions(+), 57 deletions(-)

-- 
2.1.4
