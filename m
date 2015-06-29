From: Felipe Balbi <balbi@ti.com>
Subject: Regression with today's next
Date: Mon, 29 Jun 2015 14:12:18 -0500
Message-ID: <20150629191218.GB1019@saruman.tx.rr.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5538006184587935672=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============5538006184587935672==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

commit 736e60ddc215b85e73bbf7da26e1cde84cc9500f (OMAPDSS: componentize
omapdss) caused a regression at least on AM437x SK board where Display
doesn't work anymore. Below you can find bisection log and a git show of
commit. I have tested that reverting said commit makes it work again.

Please fix, or revert.



git bisect start
# good: [b953c0d234bc72e8489d3bf51a276c5c4ec85345] Linux 4.1
git bisect good b953c0d234bc72e8489d3bf51a276c5c4ec85345
# bad: [e3984319760987beee59b1d017416671ebb89b4c] Add linux-next specific f=
iles for 20150629
git bisect bad e3984319760987beee59b1d017416671ebb89b4c
# bad: [0db9723cacf4d62bc3685fb15179b39ee4e17679] Merge branch 'next' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux
git bisect bad 0db9723cacf4d62bc3685fb15179b39ee4e17679
# bad: [e3d8238d7f5c3f539a29f5ac596cd342d847e099] Merge tag 'arm64-upstream=
' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad e3d8238d7f5c3f539a29f5ac596cd342d847e099
# good: [c70c5fb2b96dae0996fb0877d996458d3ca57eda] Merge tag 'pwm/for-4.2-r=
c1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-p=
wm
git bisect good c70c5fb2b96dae0996fb0877d996458d3ca57eda
# good: [acd53127c4adbd34570b221e7ea1f7fc94aea923] Merge tag 'scsi-misc' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good acd53127c4adbd34570b221e7ea1f7fc94aea923
# bad: [54245ed870c8cf9ff87fdf78955ffbc93b261e9f] Merge tag 'for-linus-2015=
0623' of git://git.infradead.org/linux-mtd
git bisect bad 54245ed870c8cf9ff87fdf78955ffbc93b261e9f
# bad: [5a602e157a9d91d5ce98d07c404097edba8ec9f3] Merge tag 'spi-v4.2' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
git bisect bad 5a602e157a9d91d5ce98d07c404097edba8ec9f3
# bad: [1a13e36a79f25f4cf506258637e96a07ac1451f2] Merge tag 'fbdev-4.2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux
git bisect bad 1a13e36a79f25f4cf506258637e96a07ac1451f2
# good: [9f5ddefdc979d7b71aa4d3d7cc456c76fee80fda] fbdev: propagate result =
of fb_videomode_from_videomode()
git bisect good 9f5ddefdc979d7b71aa4d3d7cc456c76fee80fda
# good: [e31cd7824d054d30ffc9f45550343123bc437e17] power_supply: bq24257: u=
se flags argument of devm_gpiod_get
git bisect good e31cd7824d054d30ffc9f45550343123bc437e17
# good: [a9fad6886f5229fc9989ac6cdd7ddecbf570a58f] OMAPDSS: HDMI: wait for =
framedone when stopping video
git bisect good a9fad6886f5229fc9989ac6cdd7ddecbf570a58f
# bad: [a9bd32a8b4c4c2670f9ed8cae63f9378b6df3ded] msm: msm_fb: Remove dead =
code
git bisect bad a9bd32a8b4c4c2670f9ed8cae63f9378b6df3ded
# good: [ede9269572da9206249f02ebe031ded025b84fd3] OMAPDSS: remove uses of =
__init/__exit
git bisect good ede9269572da9206249f02ebe031ded025b84fd3
# bad: [736e60ddc215b85e73bbf7da26e1cde84cc9500f] OMAPDSS: componentize oma=
pdss
git bisect bad 736e60ddc215b85e73bbf7da26e1cde84cc9500f
# good: [606ae4865a1947c04d52b97b5109cda90aebe892] OMAPDSS: reorder uninit =
calls
git bisect good 606ae4865a1947c04d52b97b5109cda90aebe892
# first bad commit: [736e60ddc215b85e73bbf7da26e1cde84cc9500f] OMAPDSS: com=
ponentize omapdss


commit 736e60ddc215b85e73bbf7da26e1cde84cc9500f
Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Thu Jun 4 15:22:23 2015 +0300

    OMAPDSS: componentize omapdss
   =20
    omapdss kernel module contains drivers for multiple devices, one for
    each DSS submodule. The probing we have at the moment is a mess, and
    doesn't give us proper deferred probing nor ensure that all the devices
    are probed before omapfb/omapdrm start using omapdss.
   =20
    This patch solves the mess by using the component system for DSS
    submodules.
   =20
    The changes to all DSS submodules (dispc, dpi, dsi, hdmi4/5, rfbi, sdi,
    venc) are the same: probe & remove functions are changed to bind &
    unbind, and new probe & remove functions are added which call
    component_add/del.
   =20
    The dss_core driver (dss.c) acts as a component master. Adding and
    matching the components is simple: all dss device's child devices are
    added as components.
   =20
    However, we do have some dependencies between the drivers. The order in
    which they should be probed is reflected by the list in core.c
    (dss_output_drv_reg_funcs). The drivers are registered in that order,
    which causes the components to be added in that order, which makes the
    components to be bound in that order. This feels a bit fragile, and we
    probably should improve the code to manage binds in random order.
    However, for now, this works fine.
   =20
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
    Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/om=
ap2/dss/dispc.c
index e3417af63451..c8e34163211a 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -39,6 +39,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/component.h>
=20
 #include <video/omapdss.h>
=20
@@ -3882,8 +3883,9 @@ void dispc_free_irq(void *dev_id)
 EXPORT_SYMBOL(dispc_free_irq);
=20
 /* DISPC HW IP initialisation */
-static int omap_dispchw_probe(struct platform_device *pdev)
+static int dispc_bind(struct device *dev, struct device *master, void *dat=
a)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
 	u32 rev;
 	int r =3D 0;
 	struct resource *dispc_mem;
@@ -3955,12 +3957,27 @@ err_runtime_get:
 	return r;
 }
=20
-static int omap_dispchw_remove(struct platform_device *pdev)
+static void dispc_unbind(struct device *dev, struct device *master,
+			       void *data)
 {
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
=20
 	dss_uninit_overlay_managers();
+}
+
+static const struct component_ops dispc_component_ops =3D {
+	.bind	=3D dispc_bind,
+	.unbind	=3D dispc_unbind,
+};
=20
+static int dispc_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &dispc_component_ops);
+}
+
+static int dispc_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &dispc_component_ops);
 	return 0;
 }
=20
@@ -4013,7 +4030,8 @@ static const struct of_device_id dispc_of_match[] =3D=
 {
 };
=20
 static struct platform_driver omap_dispchw_driver =3D {
-	.remove         =3D omap_dispchw_remove,
+	.probe		=3D dispc_probe,
+	.remove         =3D dispc_remove,
 	.driver         =3D {
 		.name   =3D "omapdss_dispc",
 		.pm	=3D &dispc_pm_ops,
@@ -4024,7 +4042,7 @@ static struct platform_driver omap_dispchw_driver =3D=
 {
=20
 int __init dispc_init_platform_driver(void)
 {
-	return platform_driver_probe(&omap_dispchw_driver, omap_dispchw_probe);
+	return platform_driver_register(&omap_dispchw_driver);
 }
=20
 void dispc_uninit_platform_driver(void)
diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap=
2/dss/dpi.c
index a06e7558280f..fb45b6432968 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/of.h>
 #include <linux/clk.h>
+#include <linux/component.h>
=20
 #include <video/omapdss.h>
=20
@@ -783,8 +784,9 @@ static void dpi_uninit_output_port(struct device_node *=
port)
 	omapdss_unregister_output(out);
 }
=20
-static int omap_dpi_probe(struct platform_device *pdev)
+static int dpi_bind(struct device *dev, struct device *master, void *data)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
 	struct dpi_data *dpi;
=20
 	dpi =3D devm_kzalloc(&pdev->dev, sizeof(*dpi), GFP_KERNEL);
@@ -802,16 +804,32 @@ static int omap_dpi_probe(struct platform_device *pde=
v)
 	return 0;
 }
=20
-static int omap_dpi_remove(struct platform_device *pdev)
+static void dpi_unbind(struct device *dev, struct device *master, void *da=
ta)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
+
 	dpi_uninit_output(pdev);
+}
+
+static const struct component_ops dpi_component_ops =3D {
+	.bind	=3D dpi_bind,
+	.unbind	=3D dpi_unbind,
+};
=20
+static int dpi_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &dpi_component_ops);
+}
+
+static int dpi_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &dpi_component_ops);
 	return 0;
 }
=20
 static struct platform_driver omap_dpi_driver =3D {
-	.probe		=3D omap_dpi_probe,
-	.remove         =3D omap_dpi_remove,
+	.probe		=3D dpi_probe,
+	.remove		=3D dpi_remove,
 	.driver         =3D {
 		.name   =3D "omapdss_dpi",
 		.suppress_bind_attrs =3D true,
diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap=
2/dss/dsi.c
index c4c27c09c62f..b3606def5b7b 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -40,6 +40,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/component.h>
=20
 #include <video/omapdss.h>
 #include <video/mipi_display.h>
@@ -5274,8 +5275,9 @@ static int dsi_init_pll_data(struct platform_device *=
dsidev)
 }
=20
 /* DSI1 HW IP initialisation */
-static int omap_dsihw_probe(struct platform_device *dsidev)
+static int dsi_bind(struct device *dev, struct device *master, void *data)
 {
+	struct platform_device *dsidev =3D to_platform_device(dev);
 	u32 rev;
 	int r, i;
 	struct dsi_data *dsi;
@@ -5484,8 +5486,9 @@ err_runtime_get:
 	return r;
 }
=20
-static int omap_dsihw_remove(struct platform_device *dsidev)
+static void dsi_unbind(struct device *dev, struct device *master, void *da=
ta)
 {
+	struct platform_device *dsidev =3D to_platform_device(dev);
 	struct dsi_data *dsi =3D dsi_get_dsidrv_data(dsidev);
=20
 	of_platform_depopulate(&dsidev->dev);
@@ -5502,7 +5505,21 @@ static int omap_dsihw_remove(struct platform_device =
*dsidev)
 		regulator_disable(dsi->vdds_dsi_reg);
 		dsi->vdds_dsi_enabled =3D false;
 	}
+}
+
+static const struct component_ops dsi_component_ops =3D {
+	.bind	=3D dsi_bind,
+	.unbind	=3D dsi_unbind,
+};
=20
+static int dsi_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &dsi_component_ops);
+}
+
+static int dsi_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &dsi_component_ops);
 	return 0;
 }
=20
@@ -5569,8 +5586,8 @@ static const struct of_device_id dsi_of_match[] =3D {
 };
=20
 static struct platform_driver omap_dsihw_driver =3D {
-	.probe		=3D omap_dsihw_probe,
-	.remove         =3D omap_dsihw_remove,
+	.probe		=3D dsi_probe,
+	.remove		=3D dsi_remove,
 	.driver         =3D {
 		.name   =3D "omapdss_dsi",
 		.pm	=3D &dsi_pm_ops,
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap=
2/dss/dss.c
index 3397cbf484b0..612b093831d5 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -39,6 +39,7 @@
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/suspend.h>
+#include <linux/component.h>
=20
 #include <video/omapdss.h>
=20
@@ -1088,8 +1089,9 @@ static int dss_video_pll_probe(struct platform_device=
 *pdev)
 }
=20
 /* DSS HW IP initialisation */
-static int omap_dsshw_probe(struct platform_device *pdev)
+static int dss_bind(struct device *dev)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
 	struct resource *dss_mem;
 	u32 rev;
 	int r;
@@ -1159,6 +1161,10 @@ static int omap_dsshw_probe(struct platform_device *=
pdev)
=20
 	dss_runtime_put();
=20
+	r =3D component_bind_all(&pdev->dev, NULL);
+	if (r)
+		goto err_component;
+
 	dss_debugfs_create_file("dss", dss_dump_regs);
=20
 	pm_set_vt_switch(0);
@@ -1167,6 +1173,7 @@ static int omap_dsshw_probe(struct platform_device *p=
dev)
=20
 	return 0;
=20
+err_component:
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
 	dss_uninit_ports(pdev);
@@ -1182,10 +1189,14 @@ err_setup_clocks:
 	return r;
 }
=20
-static int omap_dsshw_remove(struct platform_device *pdev)
+static void dss_unbind(struct device *dev)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
+
 	dss_initialized =3D false;
=20
+	component_unbind_all(&pdev->dev, NULL);
+
 	if (dss.video1_pll)
 		dss_video_pll_uninit(dss.video1_pll);
=20
@@ -1197,7 +1208,46 @@ static int omap_dsshw_remove(struct platform_device =
*pdev)
 	pm_runtime_disable(&pdev->dev);
=20
 	dss_put_clocks();
+}
+
+static const struct component_master_ops dss_component_ops =3D {
+	.bind =3D dss_bind,
+	.unbind =3D dss_unbind,
+};
=20
+static int dss_component_compare(struct device *dev, void *data)
+{
+	struct device *child =3D data;
+	return dev =3D=3D child;
+}
+
+static int dss_add_child_component(struct device *dev, void *data)
+{
+	struct component_match **match =3D data;
+
+	component_match_add(dev->parent, match, dss_component_compare, dev);
+
+	return 0;
+}
+
+static int dss_probe(struct platform_device *pdev)
+{
+	struct component_match *match =3D NULL;
+	int r;
+
+	/* add all the child devices as components */
+	device_for_each_child(&pdev->dev, &match, dss_add_child_component);
+
+	r =3D component_master_add_with_match(&pdev->dev, &dss_component_ops, mat=
ch);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static int dss_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &dss_component_ops);
 	return 0;
 }
=20
@@ -1243,7 +1293,8 @@ static const struct of_device_id dss_of_match[] =3D {
 MODULE_DEVICE_TABLE(of, dss_of_match);
=20
 static struct platform_driver omap_dsshw_driver =3D {
-	.remove         =3D omap_dsshw_remove,
+	.probe		=3D dss_probe,
+	.remove		=3D dss_remove,
 	.driver         =3D {
 		.name   =3D "omapdss_dss",
 		.pm	=3D &dss_pm_ops,
@@ -1254,7 +1305,7 @@ static struct platform_driver omap_dsshw_driver =3D {
=20
 int __init dss_init_platform_driver(void)
 {
-	return platform_driver_probe(&omap_dsshw_driver, omap_dsshw_probe);
+	return platform_driver_register(&omap_dsshw_driver);
 }
=20
 void dss_uninit_platform_driver(void)
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/om=
ap2/dss/hdmi4.c
index 31deebbc32dc..d35312d69025 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -32,6 +32,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/component.h>
 #include <video/omapdss.h>
 #include <sound/omap-hdmi-audio.h>
=20
@@ -646,8 +647,9 @@ static int hdmi_audio_register(struct device *dev)
 }
=20
 /* HDMI HW IP initialisation */
-static int omapdss_hdmihw_probe(struct platform_device *pdev)
+static int hdmi4_bind(struct device *dev, struct device *master, void *dat=
a)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
 	int r;
 	int irq;
=20
@@ -713,8 +715,10 @@ err:
 	return r;
 }
=20
-static int omapdss_hdmihw_remove(struct platform_device *pdev)
+static void hdmi4_unbind(struct device *dev, struct device *master, void *=
data)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
+
 	if (hdmi.audio_pdev)
 		platform_device_unregister(hdmi.audio_pdev);
=20
@@ -723,7 +727,21 @@ static int omapdss_hdmihw_remove(struct platform_devic=
e *pdev)
 	hdmi_pll_uninit(&hdmi.pll);
=20
 	pm_runtime_disable(&pdev->dev);
+}
+
+static const struct component_ops hdmi4_component_ops =3D {
+	.bind	=3D hdmi4_bind,
+	.unbind	=3D hdmi4_unbind,
+};
=20
+static int hdmi4_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &hdmi4_component_ops);
+}
+
+static int hdmi4_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &hdmi4_component_ops);
 	return 0;
 }
=20
@@ -756,8 +774,8 @@ static const struct of_device_id hdmi_of_match[] =3D {
 };
=20
 static struct platform_driver omapdss_hdmihw_driver =3D {
-	.probe		=3D omapdss_hdmihw_probe,
-	.remove         =3D omapdss_hdmihw_remove,
+	.probe		=3D hdmi4_probe,
+	.remove		=3D hdmi4_remove,
 	.driver         =3D {
 		.name   =3D "omapdss_hdmi",
 		.pm	=3D &hdmi_pm_ops,
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/om=
ap2/dss/hdmi5.c
index a57f5e8f9aea..7f875788edbc 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -37,6 +37,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/component.h>
 #include <video/omapdss.h>
 #include <sound/omap-hdmi-audio.h>
=20
@@ -681,8 +682,9 @@ static int hdmi_audio_register(struct device *dev)
 }
=20
 /* HDMI HW IP initialisation */
-static int omapdss_hdmihw_probe(struct platform_device *pdev)
+static int hdmi5_bind(struct device *dev, struct device *master, void *dat=
a)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
 	int r;
 	int irq;
=20
@@ -748,8 +750,10 @@ err:
 	return r;
 }
=20
-static int omapdss_hdmihw_remove(struct platform_device *pdev)
+static void hdmi5_unbind(struct device *dev, struct device *master, void *=
data)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
+
 	if (hdmi.audio_pdev)
 		platform_device_unregister(hdmi.audio_pdev);
=20
@@ -758,7 +762,21 @@ static int omapdss_hdmihw_remove(struct platform_devic=
e *pdev)
 	hdmi_pll_uninit(&hdmi.pll);
=20
 	pm_runtime_disable(&pdev->dev);
+}
+
+static const struct component_ops hdmi5_component_ops =3D {
+	.bind	=3D hdmi5_bind,
+	.unbind	=3D hdmi5_unbind,
+};
=20
+static int hdmi5_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &hdmi5_component_ops);
+}
+
+static int hdmi5_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &hdmi5_component_ops);
 	return 0;
 }
=20
@@ -792,8 +810,8 @@ static const struct of_device_id hdmi_of_match[] =3D {
 };
=20
 static struct platform_driver omapdss_hdmihw_driver =3D {
-	.probe		=3D omapdss_hdmihw_probe,
-	.remove         =3D omapdss_hdmihw_remove,
+	.probe		=3D hdmi5_probe,
+	.remove		=3D hdmi5_remove,
 	.driver         =3D {
 		.name   =3D "omapdss_hdmi5",
 		.pm	=3D &hdmi_pm_ops,
diff --git a/drivers/video/fbdev/omap2/dss/rfbi.c b/drivers/video/fbdev/oma=
p2/dss/rfbi.c
index 8ec810bce0b6..1525a494d057 100644
--- a/drivers/video/fbdev/omap2/dss/rfbi.c
+++ b/drivers/video/fbdev/omap2/dss/rfbi.c
@@ -36,6 +36,7 @@
 #include <linux/semaphore.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/component.h>
=20
 #include <video/omapdss.h>
 #include "dss.h"
@@ -946,8 +947,9 @@ static void rfbi_uninit_output(struct platform_device *=
pdev)
 }
=20
 /* RFBI HW IP initialisation */
-static int omap_rfbihw_probe(struct platform_device *pdev)
+static int rfbi_bind(struct device *dev, struct device *master, void *data)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
 	u32 rev;
 	struct resource *rfbi_mem;
 	struct clk *clk;
@@ -1005,8 +1007,10 @@ err_runtime_get:
 	return r;
 }
=20
-static int omap_rfbihw_remove(struct platform_device *pdev)
+static void rfbi_unbind(struct device *dev, struct device *master, void *d=
ata)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
+
 	rfbi_uninit_output(pdev);
=20
 	pm_runtime_disable(&pdev->dev);
@@ -1014,6 +1018,22 @@ static int omap_rfbihw_remove(struct platform_device=
 *pdev)
 	return 0;
 }
=20
+static const struct component_ops rfbi_component_ops =3D {
+	.bind	=3D rfbi_bind,
+	.unbind	=3D rfbi_unbind,
+};
+
+static int rfbi_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &rfbi_component_ops);
+}
+
+static int rfbi_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &rfbi_component_ops);
+	return 0;
+}
+
 static int rfbi_runtime_suspend(struct device *dev)
 {
 	dispc_runtime_put();
@@ -1038,8 +1058,8 @@ static const struct dev_pm_ops rfbi_pm_ops =3D {
 };
=20
 static struct platform_driver omap_rfbihw_driver =3D {
-	.probe		=3D omap_rfbihw_probe,
-	.remove         =3D omap_rfbihw_remove,
+	.probe		=3D rfbi_probe,
+	.remove         =3D rfbi_remove,
 	.driver         =3D {
 		.name   =3D "omapdss_rfbi",
 		.pm	=3D &rfbi_pm_ops,
diff --git a/drivers/video/fbdev/omap2/dss/sdi.c b/drivers/video/fbdev/omap=
2/dss/sdi.c
index a873118f1e0e..5843580a1deb 100644
--- a/drivers/video/fbdev/omap2/dss/sdi.c
+++ b/drivers/video/fbdev/omap2/dss/sdi.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/string.h>
 #include <linux/of.h>
+#include <linux/component.h>
=20
 #include <video/omapdss.h>
 #include "dss.h"
@@ -357,8 +358,10 @@ static void sdi_uninit_output(struct platform_device *=
pdev)
 	omapdss_unregister_output(out);
 }
=20
-static int omap_sdi_probe(struct platform_device *pdev)
+static int sdi_bind(struct device *dev, struct device *master, void *data)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
+
 	sdi.pdev =3D pdev;
=20
 	sdi_init_output(pdev);
@@ -366,16 +369,32 @@ static int omap_sdi_probe(struct platform_device *pde=
v)
 	return 0;
 }
=20
-static int omap_sdi_remove(struct platform_device *pdev)
+static void sdi_unbind(struct device *dev, struct device *master, void *da=
ta)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
+
 	sdi_uninit_output(pdev);
+}
+
+static const struct component_ops sdi_component_ops =3D {
+	.bind	=3D sdi_bind,
+	.unbind	=3D sdi_unbind,
+};
=20
+static int sdi_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &sdi_component_ops);
+}
+
+static int sdi_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &sdi_component_ops);
 	return 0;
 }
=20
 static struct platform_driver omap_sdi_driver =3D {
-	.probe		=3D omap_sdi_probe,
-	.remove         =3D omap_sdi_remove,
+	.probe		=3D sdi_probe,
+	.remove         =3D sdi_remove,
 	.driver         =3D {
 		.name   =3D "omapdss_sdi",
 		.suppress_bind_attrs =3D true,
diff --git a/drivers/video/fbdev/omap2/dss/venc.c b/drivers/video/fbdev/oma=
p2/dss/venc.c
index e7fad0e19d43..99ca268c1cdd 100644
--- a/drivers/video/fbdev/omap2/dss/venc.c
+++ b/drivers/video/fbdev/omap2/dss/venc.c
@@ -35,6 +35,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/component.h>
=20
 #include <video/omapdss.h>
=20
@@ -852,8 +853,9 @@ err:
 }
=20
 /* VENC HW IP initialisation */
-static int omap_venchw_probe(struct platform_device *pdev)
+static int venc_bind(struct device *dev, struct device *master, void *data)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
 	u8 rev_id;
 	struct resource *venc_mem;
 	int r;
@@ -912,12 +914,28 @@ err_runtime_get:
 	return r;
 }
=20
-static int omap_venchw_remove(struct platform_device *pdev)
+static void venc_unbind(struct device *dev, struct device *master, void *d=
ata)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
+
 	venc_uninit_output(pdev);
=20
 	pm_runtime_disable(&pdev->dev);
+}
=20
+static const struct component_ops venc_component_ops =3D {
+	.bind	=3D venc_bind,
+	.unbind	=3D venc_unbind,
+};
+
+static int venc_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &venc_component_ops);
+}
+
+static int venc_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &venc_component_ops);
 	return 0;
 }
=20
@@ -950,7 +968,6 @@ static const struct dev_pm_ops venc_pm_ops =3D {
 	.runtime_resume =3D venc_runtime_resume,
 };
=20
-
 static const struct of_device_id venc_of_match[] =3D {
 	{ .compatible =3D "ti,omap2-venc", },
 	{ .compatible =3D "ti,omap3-venc", },
@@ -959,8 +976,8 @@ static const struct of_device_id venc_of_match[] =3D {
 };
=20
 static struct platform_driver omap_venchw_driver =3D {
-	.probe		=3D omap_venchw_probe,
-	.remove         =3D omap_venchw_remove,
+	.probe		=3D venc_probe,
+	.remove		=3D venc_remove,
 	.driver         =3D {
 		.name   =3D "omapdss_venc",
 		.pm	=3D &venc_pm_ops,

--=20
balbi

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVkZiSAAoJEIaOsuA1yqRECMcQAJA9bTO2stL8MLlr77rQBvWe
LisY3k+lZWn39QuKDCryPLAUICrHn6Rd3A7gR2il4FbrZTMCRp+q43FvxhjpaMvo
Mxcd5ngnvA7jId9HvfQB5Q7x+y4Nh6P6uZgMOFud5LUynrNEO1leVSq3hukP3FmB
MjSxdPgrJrpwBZAw8/RnhLRPY44la/0Oul/mw+Wrbr3bBHXtg99ZeAobFBlaqgGb
998+v58bKamA7KnT9pCtWctu4WYrWWh1aL7iO8k38REMgwJGRhyAWkI19QDIkyw+
fbTWhoDoFgSh1xUmXOrLF2fOvKyc6yZ1xuFJ0wWpUtvqWTA/KZht9Ql2bb5oEOZN
DiHkURRMIgnWKyr+iHuhlkicikhw7MgDEf3QND+1ImFJa0Vkw4logvOSpWqhgyES
YkwAUDclxUeyXD09DWYt2aHrsI3g6yT+BEA40xc1KTc7Lq0MIn/OS++02rijfoxC
xEytv6c4HPeBrBo1YTe+ohUSBgGoDy8aEDWNd2KyFUBXr62WMTwt03eFEs46toRE
/mncVJVhkKkulaj6NyYtiejv1nvb+il+btfwCK8UP/6tiadfj1X/plBQ7m+Gnb5f
0SX1vQEOblvr/0snb+iJWHZrbz1CeJY40dFW8y9rnH1tjNjTp53X8keHslZaBEYJ
bMq9WiaMBoqMTwQBbwnq
=Suuu
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--


--===============5538006184587935672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5538006184587935672==--
