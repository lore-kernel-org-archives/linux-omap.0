From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4: support for manually updated display
Date: Fri, 19 Oct 2018 17:38:12 -0700
Message-ID: <20181020003812.GE43338@atomide.com>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon>
 <20180910174453.GV5662@atomide.com>
 <20181018221549.GB6364@amd>
 <20181019164450.GD43338@atomide.com>
 <20181019225827.s76wapp3cxrmp5af@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181019225827.s76wapp3cxrmp5af@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [181019 15:58]:
> I uploaded my current status here. It's not based on the newest
> -next, but contains the interesting patches from Laurent. Also
> the last few patches are not yet cleaned up, sorry for the mess.

Way to go, thanks :) Here's a quick fix for issues with loading
and unloading modules, seems like this should be fixed somewhere
else though?

Regards,

Tony

8< -----------------------
Unload of hdmi:

Unable to handle kernel NULL pointer dereference at virtual address 00000278
(hdmi_runtime_resume [omapdss]) from [<c060d944>] (__rpm_callback+0x144/0x1d8)
(__rpm_callback) from [<c060d9f8>] (rpm_callback+0x20/0x80)
(rpm_callback) from [<c060d580>] (rpm_resume+0x60c/0x828)
(rpm_resume) from [<c060d7e8>] (__pm_runtime_resume+0x4c/0x64)
(__pm_runtime_resume) from [<c06027ac>] (device_release_driver_internal+0x130/0x234)
(device_release_driver_internal) from [<c06028f4>] (driver_detach+0x38/0x6c)
(driver_detach) from [<c0601658>] (bus_remove_driver+0x4c/0xa4)
(bus_remove_driver) from [<c06041fc>] (platform_unregister_drivers+0x20/0x2c)
(platform_unregister_drivers) from [<c01f0ef8>] (sys_delete_module+0x1c0/0x230)
(sys_delete_module) from [<c0101000>] (ret_fast_syscall+0x0/0x28)


Unload of dsi:

Unable to handle kernel NULL pointer dereference at virtual address 00000278
(dsi_runtime_resume [omapdss]) from [<c060d944>] (__rpm_callback+0x144/0x1d8)
(__rpm_callback) from [<c060d9f8>] (rpm_callback+0x20/0x80)
(rpm_callback) from [<c060d580>] (rpm_resume+0x60c/0x828)
(rpm_resume) from [<c060d7e8>] (__pm_runtime_resume+0x4c/0x64)
(__pm_runtime_resume) from [<c0602364>] (driver_probe_device+0x38/0x164)
(driver_probe_device) from [<c0602574>] (__driver_attach+0xe4/0xe8)
(__driver_attach) from [<c0600418>] (bus_for_each_dev+0x70/0xb4)
(bus_for_each_dev) from [<c06015a8>] (bus_add_driver+0x198/0x1fc)
(bus_add_driver) from [<c06032ec>] (driver_register+0x74/0x108)
(driver_register) from [<c0102fe4>] (do_one_initcall+0x80/0x31c)
(do_one_initcall) from [<c01f0fc4>] (do_init_module+0x5c/0x1f8)
(do_init_module) from [<c01f2e0c>] (load_module+0x1360/0x16c0)
(load_module) from [<c01f33d4>] (sys_finit_module+0xbc/0xdc)
(sys_finit_module) from [<c0101000>] (ret_fast_syscall+0x0/0x28)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -5484,6 +5484,9 @@ static int dsi_runtime_resume(struct device *dev)
 	struct dsi_data *dsi = dev_get_drvdata(dev);
 	int r;
 
+	if (!dsi || !dsi->dss || !dsi->dss->dispc)
+		return -ENODEV;
+
 	r = dispc_runtime_get(dsi->dss->dispc);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -847,6 +847,9 @@ static int hdmi_runtime_resume(struct device *dev)
 	struct omap_hdmi *hdmi = dev_get_drvdata(dev);
 	int r;
 
+	if (!hdmi || !hdmi->dss || !hdmi->dss->dispc)
+		return -ENODEV;
+
 	r = dispc_runtime_get(hdmi->dss->dispc);
 	if (r < 0)
 		return r;
-- 
2.19.1
