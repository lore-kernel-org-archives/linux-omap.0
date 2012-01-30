From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH v2 1/8] staging: tidspbridge: more readable code
Date: Tue, 31 Jan 2012 00:12:17 +0100
Message-ID: <e8d9bf9abf11b193601a2524aaf8686b21b6e5f1.1327964066.git.vjaquez@igalia.com>
References: <cover.1327964066.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1327964066.git.vjaquez@igalia.com>
In-Reply-To: <cover.1327964066.git.vjaquez@igalia.com>
References: <cover.1327964066.git.vjaquez@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Armando Uribe <x0095078@ti.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

Uppercase function names are not pretty. Also the code flow readability=
 is
enhanced.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 drivers/staging/tidspbridge/rmgr/drv_interface.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers=
/staging/tidspbridge/rmgr/drv_interface.c
index 76cfc6e..85f6e8e 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -428,7 +428,7 @@ func_cont:
 }
=20
 #ifdef CONFIG_PM
-static int BRIDGE_SUSPEND(struct platform_device *pdev, pm_message_t s=
tate)
+static int bridge_suspend(struct platform_device *pdev, pm_message_t s=
tate)
 {
 	u32 status;
 	u32 command =3D PWR_EMERGENCYDEEPSLEEP;
@@ -441,7 +441,7 @@ static int BRIDGE_SUSPEND(struct platform_device *p=
dev, pm_message_t state)
 	return 0;
 }
=20
-static int BRIDGE_RESUME(struct platform_device *pdev)
+static int bridge_resume(struct platform_device *pdev)
 {
 	u32 status;
=20
@@ -453,9 +453,6 @@ static int BRIDGE_RESUME(struct platform_device *pd=
ev)
 	wake_up(&bridge_suspend_data.suspend_wq);
 	return 0;
 }
-#else
-#define BRIDGE_SUSPEND NULL
-#define BRIDGE_RESUME NULL
 #endif
=20
 static struct platform_driver bridge_driver =3D {
@@ -464,8 +461,10 @@ static struct platform_driver bridge_driver =3D {
 		   },
 	.probe =3D omap34_xx_bridge_probe,
 	.remove =3D __devexit_p(omap34_xx_bridge_remove),
-	.suspend =3D BRIDGE_SUSPEND,
-	.resume =3D BRIDGE_RESUME,
+#ifdef CONFIG_PM
+	.suspend =3D bridge_suspend,
+	.resume =3D bridge_resume,
+#endif
 };
=20
 static int __init bridge_init(void)
--=20
1.7.8.3
