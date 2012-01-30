From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH v2 6/8] staging: tidspbridge: remove trivial assert
Date: Tue, 31 Jan 2012 00:12:22 +0100
Message-ID: <24823056ec30b5aa47ac56198b0b571fcf80ec73.1327964066.git.vjaquez@igalia.com>
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

The function dsp_deinit() always return true, so assert its output is
pointless. As consequence the variable were the returned value is store=
d, is
no longer needed.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 drivers/staging/tidspbridge/rmgr/drv_interface.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers=
/staging/tidspbridge/rmgr/drv_interface.c
index 4531920..97c40ff 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -531,7 +531,6 @@ err1:
 static int __devexit omap34_xx_bridge_remove(struct platform_device *p=
dev)
 {
 	dev_t devno;
-	bool ret;
 	int status =3D 0;
 	struct drv_data *drv_datap =3D dev_get_drvdata(bridge);
=20
@@ -551,9 +550,8 @@ static int __devexit omap34_xx_bridge_remove(struct=
 platform_device *pdev)
=20
 	if (driver_context) {
 		/* Put the DSP in reset state */
-		ret =3D dsp_deinit(driver_context);
+		dsp_deinit(driver_context);
 		driver_context =3D 0;
-		DBC_ASSERT(ret =3D=3D true);
 	}
=20
 func_cont:
--=20
1.7.8.3
