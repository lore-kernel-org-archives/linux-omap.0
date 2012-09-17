From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3 1/4] lis3: lis3lv02d: remove lis3lv02d driver DT init
Date: Mon, 17 Sep 2012 12:53:19 +0530
Message-ID: <1347866602-2088-2-git-send-email-anilkumar@ti.com>
References: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56605 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab2IQHYT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 03:24:19 -0400
In-Reply-To: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org, eric.piel@tremplin-utc.net, jic23@cam.ac.uk, greg@kroah.com, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com, dmitry.torokhov@gmail.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Remove lis3lv02d driver device tree initialization from core driver
and move it to individual drivers. With the current implementation
some pdata parameters are missing if we use lis3lv02d_init_device()
in lis3lv02d_i2c driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/misc/lis3lv02d/lis3lv02d.c |    8 ++------
 drivers/misc/lis3lv02d/lis3lv02d.h |    1 +
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 79349ec..026021e 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -944,7 +944,7 @@ static void lis3lv02d_8b_configure(struct lis3lv02d *lis3,
 }
 
 #ifdef CONFIG_OF
-static int lis3lv02d_init_dt(struct lis3lv02d *lis3)
+int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 {
 	struct lis3lv02d_platform_data *pdata;
 	struct device_node *np = lis3->of_node;
@@ -1084,7 +1084,7 @@ static int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 }
 
 #else
-static int lis3lv02d_init_dt(struct lis3lv02d *lis3)
+int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 {
 	return 0;
 }
@@ -1100,10 +1100,6 @@ int lis3lv02d_init_device(struct lis3lv02d *lis3)
 	irq_handler_t thread_fn;
 	int irq_flags = 0;
 
-	err = lis3lv02d_init_dt(lis3);
-	if (err < 0)
-		return err;
-
 	lis3->whoami = lis3lv02d_read_8(lis3, WHO_AM_I);
 
 	switch (lis3->whoami) {
diff --git a/drivers/misc/lis3lv02d/lis3lv02d.h b/drivers/misc/lis3lv02d/lis3lv02d.h
index 4cf0779..b5505fa 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.h
+++ b/drivers/misc/lis3lv02d/lis3lv02d.h
@@ -326,5 +326,6 @@ void lis3lv02d_joystick_disable(struct lis3lv02d *lis3);
 void lis3lv02d_poweroff(struct lis3lv02d *lis3);
 int lis3lv02d_poweron(struct lis3lv02d *lis3);
 int lis3lv02d_remove_fs(struct lis3lv02d *lis3);
+int lis3lv02d_init_dt(struct lis3lv02d *lis3);
 
 extern struct lis3lv02d lis3_dev;
-- 
1.7.9.5

