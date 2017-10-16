From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] i2c: omap: Fix error handlign for clk_get()
Date: Mon, 16 Oct 2017 14:06:14 -0700
Message-ID: <20171016210614.15842-1-tony@atomide.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Claudio Foellmi <claudio.foellmi@ergon.ch>, Grygorii Strashko <grygorii.strashko@ti.com>, Tero Kristo <t-kristo@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Otherwise we can get the following if the fck alias is missing:

Unable to handle kernel paging request at virtual address fffffffe
...
PC is at clk_get_rate+0x8/0x10
LR is at omap_i2c_probe+0x278/0x6ec
...
[<c056eb08>] (clk_get_rate) from [<c06f4f08>] (omap_i2c_probe+0x278/0x6ec)
[<c06f4f08>] (omap_i2c_probe) from [<c0610944>] (platform_drv_probe+0x50/0xb0)
[<c0610944>] (platform_drv_probe) from [<c060e900>] (driver_probe_device+0x264/0x2ec)
[<c060e900>] (driver_probe_device) from [<c060cda0>] (bus_for_each_drv+0x70/0xb8)
[<c060cda0>] (bus_for_each_drv) from [<c060e5b0>] (__device_attach+0xcc/0x13c)
[<c060e5b0>] (__device_attach) from [<c060db10>] (bus_probe_device+0x88/0x90)
[<c060db10>] (bus_probe_device) from [<c060df68>] (deferred_probe_work_func+0x4c/0x14c)

Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -360,6 +360,7 @@ static int omap_i2c_init(struct omap_i2c_dev *omap)
 	unsigned long fclk_rate = 12000000;
 	unsigned long internal_clk = 0;
 	struct clk *fclk;
+	int error;
 
 	if (omap->rev >= OMAP_I2C_REV_ON_3430_3530) {
 		/*
@@ -378,6 +379,13 @@ static int omap_i2c_init(struct omap_i2c_dev *omap)
 		 * do this bit unconditionally.
 		 */
 		fclk = clk_get(omap->dev, "fck");
+		if (IS_ERR(fclk)) {
+			error = PTR_ERR(fclk);
+			dev_err(omap->dev, "could not get fck: %i\n", error);
+
+			return error;
+		}
+
 		fclk_rate = clk_get_rate(fclk);
 		clk_put(fclk);
 
@@ -410,6 +418,12 @@ static int omap_i2c_init(struct omap_i2c_dev *omap)
 		else
 			internal_clk = 4000;
 		fclk = clk_get(omap->dev, "fck");
+		if (IS_ERR(fclk)) {
+			error = PTR_ERR(fclk);
+			dev_err(omap->dev, "could not get fck: %i\n", error);
+
+			return error;
+		}
 		fclk_rate = clk_get_rate(fclk) / 1000;
 		clk_put(fclk);
 
-- 
2.14.2
