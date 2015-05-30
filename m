From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] Input: of_touchscreen - remove interdependence of max/fuzz values
Date: Sat, 30 May 2015 04:24:34 +0200
Message-ID: <1432952674-15228-1-git-send-email-sre@kernel.org>
References: <20150530022111.GA28241@earth>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20150530022111.GA28241@earth>
Sender: linux-input-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: Pavel Machek <pavel@ucw.cz>, maxime.ripard@free-electrons.com, kernel list <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Commit 3eea8b5d68c8 introduced a dependency between touchscreen-max-*
and touchscreen-fuzz-*, so that either both must be specified or none
of them. If only one of them is specified the other value will be
reset to 0. This commit restores the previous behaviour, that the
drivers default value will be used for the unspecified value.

Reported-By: Pavel Machek <pavel@ucw.cz>
Fixes: 3eea8b5d68c8 (Input: of_touchscreen - rework the DT parsing function)
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/input/touchscreen/of_touchscreen.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
index b82b520..7d2cf59 100644
--- a/drivers/input/touchscreen/of_touchscreen.c
+++ b/drivers/input/touchscreen/of_touchscreen.c
@@ -42,8 +42,11 @@ static void touchscreen_set_params(struct input_dev *dev,
 	}
 
 	absinfo = &dev->absinfo[axis];
-	absinfo->maximum = max;
-	absinfo->fuzz = fuzz;
+
+	if (max)
+		absinfo->maximum = max;
+	if (fuzz)
+		absinfo->fuzz = fuzz;
 }
 
 /**
@@ -65,23 +68,17 @@ void touchscreen_parse_of_params(struct input_dev *dev)
 
 	maximum = of_get_optional_u32(np, "touchscreen-size-x");
 	fuzz = of_get_optional_u32(np, "touchscreen-fuzz-x");
-	if (maximum || fuzz) {
-		touchscreen_set_params(dev, ABS_X, maximum, fuzz);
-		touchscreen_set_params(dev, ABS_MT_POSITION_X, maximum, fuzz);
-	}
+	touchscreen_set_params(dev, ABS_X, maximum, fuzz);
+	touchscreen_set_params(dev, ABS_MT_POSITION_X, maximum, fuzz);
 
 	maximum = of_get_optional_u32(np, "touchscreen-size-y");
 	fuzz = of_get_optional_u32(np, "touchscreen-fuzz-y");
-	if (maximum || fuzz) {
-		touchscreen_set_params(dev, ABS_Y, maximum, fuzz);
-		touchscreen_set_params(dev, ABS_MT_POSITION_Y, maximum, fuzz);
-	}
+	touchscreen_set_params(dev, ABS_Y, maximum, fuzz);
+	touchscreen_set_params(dev, ABS_MT_POSITION_Y, maximum, fuzz);
 
 	maximum = of_get_optional_u32(np, "touchscreen-max-pressure");
 	fuzz = of_get_optional_u32(np, "touchscreen-fuzz-pressure");
-	if (maximum || fuzz) {
-		touchscreen_set_params(dev, ABS_PRESSURE, maximum, fuzz);
-		touchscreen_set_params(dev, ABS_MT_PRESSURE, maximum, fuzz);
-	}
+	touchscreen_set_params(dev, ABS_PRESSURE, maximum, fuzz);
+	touchscreen_set_params(dev, ABS_MT_PRESSURE, maximum, fuzz);
 }
 EXPORT_SYMBOL(touchscreen_parse_of_params);
-- 
2.1.4

