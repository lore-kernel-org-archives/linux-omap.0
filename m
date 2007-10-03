From: Felipe Balbi <felipebalbi@users.sourceforge.net>
Subject: [PATCH] VIDEO: OMAP: BACKLIGHT: Fix compiling issues due to API
	changes
Date: Wed,  3 Oct 2007 16:28:05 -0400
Message-ID: <1191443285-913-1-git-send-email-felipebalbi@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.lima@indt.org.br>

This patch fixes compilation for omap_bl.c due to removal of
old class_dev

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Acked-by: Lu=C3=ADs Cargnini <lvcargnini@gmail.com>
---
 drivers/video/backlight/omap_bl.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/omap_bl.c b/drivers/video/backlight/=
omap_bl.c
index 3249bf8..2072f28 100644
--- a/drivers/video/backlight/omap_bl.c
+++ b/drivers/video/backlight/omap_bl.c
@@ -76,7 +76,7 @@ static void omapbl_blank(struct omap_backlight *bl, int=
 mode)
 static int omapbl_suspend(struct platform_device *pdev, pm_message_t sta=
te)
 {
 	struct backlight_device *dev =3D platform_get_drvdata(pdev);
-	struct omap_backlight *bl =3D class_get_devdata(&dev->class_dev);
+	struct omap_backlight *bl =3D dev_get_drvdata(&dev->dev);
=20
 	omapbl_blank(bl, FB_BLANK_POWERDOWN);
 	return 0;
@@ -85,7 +85,7 @@ static int omapbl_suspend(struct platform_device *pdev,=
 pm_message_t state)
 static int omapbl_resume(struct platform_device *pdev)
 {
 	struct backlight_device *dev =3D platform_get_drvdata(pdev);
-	struct omap_backlight *bl =3D class_get_devdata(&dev->class_dev);
+	struct omap_backlight *bl =3D dev_get_drvdata(&dev->dev);
=20
 	omapbl_blank(bl, bl->powermode);
 	return 0;
@@ -97,7 +97,7 @@ static int omapbl_resume(struct platform_device *pdev)
=20
 static int omapbl_set_power(struct backlight_device *dev, int state)
 {
-	struct omap_backlight *bl =3D class_get_devdata(&dev->class_dev);
+	struct omap_backlight *bl =3D dev_get_drvdata(&dev->dev);
=20
 	omapbl_blank(bl, state);
 	bl->powermode =3D state;
@@ -107,7 +107,7 @@ static int omapbl_set_power(struct backlight_device *=
dev, int state)
=20
 static int omapbl_update_status(struct backlight_device *dev)
 {
-	struct omap_backlight *bl =3D class_get_devdata(&dev->class_dev);
+	struct omap_backlight *bl =3D dev_get_drvdata(&dev->dev);
=20
 	if (bl->current_intensity !=3D dev->props.brightness) {
 		if (dev->props.brightness < 0)
@@ -127,7 +127,7 @@ static int omapbl_update_status(struct backlight_devi=
ce *dev)
=20
 static int omapbl_get_intensity(struct backlight_device *dev)
 {
-	struct omap_backlight *bl =3D class_get_devdata(&dev->class_dev);
+	struct omap_backlight *bl =3D dev_get_drvdata(&dev->dev);
 	return bl->current_intensity;
 }
=20
@@ -182,7 +182,7 @@ static int omapbl_probe(struct platform_device *pdev)
 static int omapbl_remove(struct platform_device *pdev)
 {
 	struct backlight_device *dev =3D platform_get_drvdata(pdev);
-	struct omap_backlight *bl =3D class_get_devdata(&dev->class_dev);
+	struct omap_backlight *bl =3D dev_get_drvdata(&dev->dev);
=20
 	backlight_device_unregister(dev);
 	kfree(bl);
--=20
1.5.3.3.131.g34c6d
