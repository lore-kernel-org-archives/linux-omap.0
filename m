From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/4] video: switch OMAP LCD MIPI driver to use the common
 MIPI DSI header
Date: Fri, 7 May 2010 11:07:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005071106280.4777@axis700.grange>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/omap/lcd_mipid.c |   37 ++++++++++++++-----------------------
 1 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/video/omap/lcd_mipid.c b/drivers/video/omap/lcd_mipid.c
index abe1c76..523393e 100644
--- a/drivers/video/omap/lcd_mipid.c
+++ b/drivers/video/omap/lcd_mipid.c
@@ -23,23 +23,14 @@
 #include <linux/workqueue.h>
 #include <linux/spi/spi.h>
 
+#include <video/mipi_dsi.h>
+
 #include <plat/lcd_mipid.h>
 
 #include "omapfb.h"
 
 #define MIPID_MODULE_NAME		"lcd_mipid"
 
-#define MIPID_CMD_READ_DISP_ID		0x04
-#define MIPID_CMD_READ_RED		0x06
-#define MIPID_CMD_READ_GREEN		0x07
-#define MIPID_CMD_READ_BLUE		0x08
-#define MIPID_CMD_READ_DISP_STATUS	0x09
-#define MIPID_CMD_RDDSDR		0x0F
-#define MIPID_CMD_SLEEP_IN		0x10
-#define MIPID_CMD_SLEEP_OUT		0x11
-#define MIPID_CMD_DISP_OFF		0x28
-#define MIPID_CMD_DISP_ON		0x29
-
 #define MIPID_ESD_CHECK_PERIOD		msecs_to_jiffies(5000)
 
 #define to_mipid_device(p)		container_of(p, struct mipid_device, \
@@ -152,14 +143,14 @@ static void set_data_lines(struct mipid_device *md, int data_lines)
 		par = 0x170;
 		break;
 	}
-	mipid_write(md, 0x3a, (u8 *)&par, 2);
+	mipid_write(md, MIPI_DCS_SET_PIXEL_FORMAT, (u8 *)&par, 2);
 }
 
 static void send_init_string(struct mipid_device *md)
 {
 	u16 initpar[] = { 0x0102, 0x0100, 0x0100 };
 
-	mipid_write(md, 0xc2, (u8 *)initpar, sizeof(initpar));
+	mipid_write(md, 0xc2, (u8 *)initpar, sizeof(initpar) * 2);
 	set_data_lines(md, md->panel.data_lines);
 }
 
@@ -184,9 +175,9 @@ static void set_sleep_mode(struct mipid_device *md, int on)
 	int cmd, sleep_time = 50;
 
 	if (on)
-		cmd = MIPID_CMD_SLEEP_IN;
+		cmd = MIPI_DCS_ENTER_SLEEP_MODE;
 	else
-		cmd = MIPID_CMD_SLEEP_OUT;
+		cmd = MIPI_DCS_EXIT_SLEEP_MODE;
 	hw_guard_wait(md);
 	mipid_cmd(md, cmd);
 	hw_guard_start(md, 120);
@@ -203,7 +194,7 @@ static void set_sleep_mode(struct mipid_device *md, int on)
 
 static void set_display_state(struct mipid_device *md, int enabled)
 {
-	int cmd = enabled ? MIPID_CMD_DISP_ON : MIPID_CMD_DISP_OFF;
+	int cmd = enabled ? MIPI_DCS_SET_DISPLAY_ON : MIPI_DCS_SET_DISPLAY_OFF;
 
 	mipid_cmd(md, cmd);
 }
@@ -258,9 +249,9 @@ static u16 read_first_pixel(struct mipid_device *md)
 	u8 red, green, blue;
 
 	mutex_lock(&md->mutex);
-	mipid_read(md, MIPID_CMD_READ_RED, &red, 1);
-	mipid_read(md, MIPID_CMD_READ_GREEN, &green, 1);
-	mipid_read(md, MIPID_CMD_READ_BLUE, &blue, 1);
+	mipid_read(md, MIPI_DCS_GET_RED_CHANNEL, &red, 1);
+	mipid_read(md, MIPI_DCS_GET_GREEN_CHANNEL, &green, 1);
+	mipid_read(md, MIPI_DCS_GET_BLUE_CHANNEL, &blue, 1);
 	mutex_unlock(&md->mutex);
 
 	switch (md->panel.data_lines) {
@@ -330,9 +321,9 @@ static void ls041y3_esd_check_mode1(struct mipid_device *md)
 {
 	u8 state1, state2;
 
-	mipid_read(md, MIPID_CMD_RDDSDR, &state1, 1);
+	mipid_read(md, MIPI_DCS_GET_DIAGNOSTIC_RESULT, &state1, 1);
 	set_sleep_mode(md, 0);
-	mipid_read(md, MIPID_CMD_RDDSDR, &state2, 1);
+	mipid_read(md, MIPI_DCS_GET_DIAGNOSTIC_RESULT, &state2, 1);
 	dev_dbg(&md->spi->dev, "ESD mode 1 state1 %02x state2 %02x\n",
 		state1, state2);
 	/* Each sleep out command will trigger a self diagnostic and flip
@@ -459,7 +450,7 @@ static int panel_enabled(struct mipid_device *md)
 	u32 disp_status;
 	int enabled;
 
-	mipid_read(md, MIPID_CMD_READ_DISP_STATUS, (u8 *)&disp_status, 4);
+	mipid_read(md, MIPI_DCS_GET_DISPLAY_STATUS, (u8 *)&disp_status, 4);
 	disp_status = __be32_to_cpu(disp_status);
 	enabled = (disp_status & (1 << 17)) && (disp_status & (1 << 10));
 	dev_dbg(&md->spi->dev,
@@ -537,7 +528,7 @@ static int mipid_detect(struct mipid_device *md)
 		return -ENOENT;
 	}
 
-	mipid_read(md, MIPID_CMD_READ_DISP_ID, display_id, 3);
+	mipid_read(md, MIPI_DCS_GET_DISPLAY_ID, display_id, 3);
 	dev_dbg(&md->spi->dev, "MIPI display ID: %02x%02x%02x\n",
 		display_id[0], display_id[1], display_id[2]);
 
-- 
1.6.2.4

