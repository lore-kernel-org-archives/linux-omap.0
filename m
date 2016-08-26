From: Andrey Utkin <andrey_utkin@fastmail.com>
Subject: [PATCH] omapdrm: dss: drop unneeded of_node_put() on ref passed to of_get_next_parent()
Date: Fri, 26 Aug 2016 15:23:21 +0300
Message-ID: <20160826122321.4787-1-andrey_utkin@fastmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Dave Airlie <airlied@gmail.com>, Peter Chen <peter.chen@nxp.com>, Rob Clark <robdclark@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Andrew Bradford <bradfa@gmail.com>, kernel@pyra-handheld.com, letux-kernel@openphoenux.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Andrey Utkin <andrey_utkin@fastmail.com>
List-Id: linux-omap@vger.kernel.org

Fixes runtime error:

[    8.842806] OF: ERROR: Bad of_node_put() on /encoder/ports/port@1/endpoint
[    8.842812] CPU: 1 PID: 1494 Comm: systemd-udevd Not tainted 4.8.0-rc1-letux-custom #17
[    8.842815] Hardware name: Generic OMAP5 (Flattened Device Tree)
[    8.842831] [<c010b519>] (unwind_backtrace) from [<c010900b>] (show_stack+0xb/0xc)
[    8.842841] [<c010900b>] (show_stack) from [<c02bb281>] (dump_stack+0x6d/0x98)
[    8.842849] [<c02bb281>] (dump_stack) from [<c02bc91b>] (kobject_put+0x93/0x140)
[    8.842935] [<c02bc91b>] (kobject_put) from [<bf889433>] (omapdss_of_find_source_for_first_ep+0x2e/0x58 [omapdss])
[    8.843014] [<bf889433>] (omapdss_of_find_source_for_first_ep [omapdss]) from [<bf94f233>] (hdmic_probe+0x56/0x170 [connector_hdmi])
[    8.843030] [<bf94f233>] (hdmic_probe [connector_hdmi]) from [<c03216cd>] (platform_drv_probe+0x33/0x62)
[    8.843040] [<c03216cd>] (platform_drv_probe) from [<c03201db>] (driver_probe_device+0x11f/0x284)
[    8.843049] [<c03201db>] (driver_probe_device) from [<c032038d>] (__driver_attach+0x4d/0x98)
[    8.843057] [<c032038d>] (__driver_attach) from [<c031f085>] (bus_for_each_dev+0x3d/0x46)
[    8.843064] [<c031f085>] (bus_for_each_dev) from [<c031facb>] (bus_add_driver+0xe3/0x170)
[    8.843073] [<c031facb>] (bus_add_driver) from [<c0320d79>] (driver_register+0x59/0x88)
[    8.843083] [<c0320d79>] (driver_register) from [<bf95200b>] (hdmi_connector_driver_init+0xa/0x13 [connector_hdmi])
[    8.843095] [<bf95200b>] (hdmi_connector_driver_init [connector_hdmi]) from [<c010178d>] (do_one_initcall+0xc5/0xf0)
[    8.843108] [<c010178d>] (do_one_initcall) from [<c01b329b>] (do_init_module+0x3b/0x318)
[    8.843118] [<c01b329b>] (do_init_module) from [<c017f33d>] (load_module+0x13f3/0x1722)
[    8.843126] [<c017f33d>] (load_module) from [<c017f7b1>] (SyS_finit_module+0x51/0x74)
[    8.843135] [<c017f7b1>] (SyS_finit_module) from [<c0105bc1>] (ret_fast_syscall+0x1/0x18)

Signed-off-by: Andrey Utkin <andrey_utkin@fastmail.com>
---
 drivers/gpu/drm/omapdrm/dss/dss-of.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dss-of.c b/drivers/gpu/drm/omapdrm/dss/dss-of.c
index e256d87..3e2b191 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss-of.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss-of.c
@@ -132,7 +132,6 @@ static struct device_node *omapdss_of_get_remote_port(const struct device_node *
 		return NULL;
 
 	np_parent = of_get_next_parent(np);
-	of_node_put(np);
 
 	return np_parent;
 }
-- 
2.9.2
