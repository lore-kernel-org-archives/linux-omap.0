From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v3 05/10] video: da8xx-fb: store current display information
Date: Tue, 15 Jan 2013 19:02:03 +0530
Message-ID: <92fd51db47d336228809626d54212a3703d174bf.1358250489.git.afzal@ti.com>
References: <cover.1358250489.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1358250489.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

store current videomode and controller data so that reconfiguring can
be done easily. Reconfiguring would be required in fb_set_par, which
is going to be added soon.

If these details are not stored, the work probe does to retrieve these
information would have to repeated at the place of reconfiguring and
modifying platform data would be necessary to handle controller data
changes like bpp.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/video/da8xx-fb.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 18834fa..d060f14 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -178,6 +178,8 @@ struct da8xx_fb_par {
 #endif
 	void (*panel_power_ctrl)(int);
 	u32 pseudo_palette[16];
+	struct fb_videomode	mode;
+	struct lcd_ctrl_config	cfg;
 };
 
 static struct fb_var_screeninfo da8xx_fb_var;
@@ -1310,6 +1312,8 @@ static int fb_probe(struct platform_device *device)
 	}
 
 	fb_videomode_to_var(&da8xx_fb_var, lcdc_info);
+	fb_var_to_videomode(&par->mode, &da8xx_fb_var);
+	par->cfg = *lcd_cfg;
 
 	if (lcd_init(par, lcd_cfg, lcdc_info) < 0) {
 		dev_err(&device->dev, "lcd_init failed\n");
-- 
1.7.9.5
