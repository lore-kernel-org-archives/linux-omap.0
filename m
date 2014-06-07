From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 3/9] drm/tilcdc: slave: fix dangling sysfs connector node
Date: Sat,  7 Jun 2014 00:02:02 -0300
Message-ID: <1402110128-30471-4-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: stable-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, David Airlie <airlied@linux.ie>, Russell King <linux@arm.linux.org.uk>, Rob Clark <robdclark@gmail.com>, Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add a drm_sysfs_connector_remove call when we destroy the panel to make
sure the connector node in sysfs gets deleted.

This is required for proper unload and re-load of this driver as a
module. Without this, we would get a warning at re-load time like so:

   tda998x 0-0070: found TDA19988
   ------------[ cut here ]------------
   WARNING: CPU: 0 PID: 825 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x54/0x=
74()
   sysfs: cannot create duplicate filename '/class/drm/card0-HDMI-A-1'
   Modules linked in: [..]
   CPU: 0 PID: 825 Comm: modprobe Not tainted 3.15.0-rc4-00027-g9dcdef4=
 #82
   [<c0013bb8>] (unwind_backtrace) from [<c0011824>] (show_stack+0x10/0=
x14)
   [<c0011824>] (show_stack) from [<c0034e8c>] (warn_slowpath_common+0x=
68/0x88)
   [<c0034e8c>] (warn_slowpath_common) from [<c0034edc>] (warn_slowpath=
_fmt+0x30/0x40)
   [<c0034edc>] (warn_slowpath_fmt) from [<c01243f4>] (sysfs_warn_dup+0=
x54/0x74)
   [<c01243f4>] (sysfs_warn_dup) from [<c0124708>] (sysfs_do_create_lin=
k_sd.isra.2+0xb0/0xb8)
   [<c0124708>] (sysfs_do_create_link_sd.isra.2) from [<c02ae37c>] (dev=
ice_add+0x338/0x520)
   [<c02ae37c>] (device_add) from [<c02ae6e8>] (device_create_groups_va=
rgs+0xa0/0xc4)
   [<c02ae6e8>] (device_create_groups_vargs) from [<c02ae758>] (device_=
create+0x24/0x2c)
   [<c02ae758>] (device_create) from [<c029b4ec>] (drm_sysfs_connector_=
add+0x64/0x204)
   [<c029b4ec>] (drm_sysfs_connector_add) from [<bf0b1b40>] (slave_mode=
set_init+0x120/0x1bc [tilcdc])
   [<bf0b1b40>] (slave_modeset_init [tilcdc]) from [<bf0b2be8>] (tilcdc=
_load+0x214/0x4c0 [tilcdc])
   [<bf0b2be8>] (tilcdc_load [tilcdc]) from [<c029955c>] (drm_dev_regis=
ter+0xa4/0x104)
      [..snip..]
   ---[ end trace 4df8d614936ebdee ]---
   [drm:drm_sysfs_connector_add] *ERROR* failed to register connector d=
evice: -17

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/tilcdc/tilcdc_slave.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave.c b/drivers/gpu/drm/ti=
lcdc/tilcdc_slave.c
index a37924e..28c8478 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_slave.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
@@ -176,6 +176,7 @@ struct slave_connector {
 static void slave_connector_destroy(struct drm_connector *connector)
 {
 	struct slave_connector *slave_connector =3D to_slave_connector(connec=
tor);
+	drm_sysfs_connector_remove(connector);
 	drm_connector_cleanup(connector);
 	kfree(slave_connector);
 }
--=20
2.0.0.rc2
