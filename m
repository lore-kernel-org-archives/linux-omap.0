From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH v2 5/8] staging: tidspbridge: remove header inclusions
Date: Tue, 31 Jan 2012 00:12:21 +0100
Message-ID: <bfe22b3bafff240ea51008b2cca4a4cdacde958e.1327964066.git.vjaquez@igalia.com>
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

drv_interface.c include several header files that are not really used.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 drivers/staging/tidspbridge/rmgr/drv_interface.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers=
/staging/tidspbridge/rmgr/drv_interface.c
index 7a6401a..4531920 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -16,11 +16,8 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
=20
-/*  ----------------------------------- Host OS */
-
 #include <plat/dsp.h>
=20
-#include <dspbridge/host_os.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
@@ -38,10 +35,8 @@
=20
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/clk.h>
-#include <dspbridge/sync.h>
=20
 /*  ----------------------------------- Platform Manager */
-#include <dspbridge/dspapi-ioctl.h>
 #include <dspbridge/dspapi.h>
 #include <dspbridge/dspdrv.h>
=20
@@ -49,10 +44,8 @@
 #include <dspbridge/pwr.h>
=20
 #include <dspbridge/resourcecleanup.h>
-#include <dspbridge/chnl.h>
 #include <dspbridge/proc.h>
 #include <dspbridge/dev.h>
-#include <dspbridge/drv.h>
=20
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 #include <mach-omap2/omap3-opp.h>
--=20
1.7.8.3
