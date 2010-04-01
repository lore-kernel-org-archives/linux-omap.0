From: "Hemanth V" <hemanthv@ti.com>
Subject: [PATCH 1/2] [STAGING] Synaptic : Remove non-standard multi touch   
        support
Date: Thu, 1 Apr 2010 18:46:19 +0530 (IST)
Message-ID: <37391.10.24.255.17.1270127779.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60133 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab0DANQ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Apr 2010 09:16:28 -0400
References: 
In-Reply-To: 
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@suse.de, devel@driverdev.osuosl.org
Cc: pavel@ucw.cz, linux-input@vger.kernel.org, linux-omap@vger.kernel.org

>From dbd87fbdf5be92351f81030a133e57d96634a3d3 Mon Sep 17 00:00:00 2001 From: Hemanth V <hemanthv@ti.com>
Date: Thu, 1 Apr 2010 17:26:49 +0530
Subject: [PATCH] Remove non-standard multi touch support


Signed-off-by: Hemanth V <hemanthv@ti.com>
---
 drivers/staging/dream/synaptics_i2c_rmi.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/dream/synaptics_i2c_rmi.c b/drivers/staging/dream/synaptics_i2c_rmi.c index 4de6bc9..7c1b980 100644
--- a/drivers/staging/dream/synaptics_i2c_rmi.c
+++ b/drivers/staging/dream/synaptics_i2c_rmi.c
@@ -108,9 +108,7 @@ static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
 	int f, a;
 	int base = 2;
 	int z = buf[1];
-	int w = buf[0] >> 4;
 	int finger = buf[0] & 7;
-	int finger2_pressed;

 	for (f = 0; f < 2; f++) {
 		u32 flip_flag = SYNAPTICS_FLIP_X;
@@ -150,14 +148,7 @@ static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
 		input_report_abs(ts->input_dev, ABS_Y, pos[0][1]);
 	}
 	input_report_abs(ts->input_dev, ABS_PRESSURE, z);
-	input_report_abs(ts->input_dev, ABS_TOOL_WIDTH, w);
 	input_report_key(ts->input_dev, BTN_TOUCH, finger);
-	finger2_pressed = finger > 1 && finger != 7;
-	input_report_key(ts->input_dev, BTN_2, finger2_pressed);
-	if (finger2_pressed) {
-		input_report_abs(ts->input_dev, ABS_HAT0X, pos[1][0]);
-		input_report_abs(ts->input_dev, ABS_HAT0Y, pos[1][1]);
-	}
 	input_sync(ts->input_dev);
 }

@@ -346,11 +337,6 @@ static void compute_areas(struct synaptics_ts_data *ts,
 			     -inactive_area_top, max_y + inactive_area_bottom,
 			     fuzz_y, 0);
 	input_set_abs_params(ts->input_dev, ABS_PRESSURE, 0, 255, fuzz_p, 0);
-	input_set_abs_params(ts->input_dev, ABS_TOOL_WIDTH, 0, 15, fuzz_w, 0); -	input_set_abs_params(ts->input_dev, ABS_HAT0X, -inactive_area_left, -			 
   max_x + inactive_area_right, fuzz_x, 0);
-	input_set_abs_params(ts->input_dev, ABS_HAT0Y, -inactive_area_top, -			     max_y + inactive_area_bottom, fuzz_y, 0);
 }

 static struct synaptics_i2c_rmi_platform_data fake_pdata;
@@ -486,7 +472,6 @@ static int __devinit synaptics_ts_probe(
 	__set_bit(EV_SYN, ts->input_dev->evbit);
 	__set_bit(EV_KEY, ts->input_dev->evbit);
 	__set_bit(BTN_TOUCH, ts->input_dev->keybit);
-	__set_bit(BTN_2, ts->input_dev->keybit);
 	__set_bit(EV_ABS, ts->input_dev->evbit);

 	compute_areas(ts, pdata, max_x, max_y);
-- 
1.5.6.3





