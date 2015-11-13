From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 6/8] drivers:input:ads7846(+tsc2046): recognise old binding for coordinate flipping
Date: Fri, 13 Nov 2015 21:35:57 +0100
Message-ID: <f036e0d2b019ae9463e108f48643c16a80936ddb.1447446957.git.hns@goldelico.com>
References: <cover.1447446957.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447446957.git.hns@goldelico.com>
In-Reply-To: <cover.1447446957.git.hns@goldelico.com>
References: <cover.1447446957.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Haibo Chen <haibo.chen@freescale.com>, Andrey Gelman <andrey.gelman@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>, Aaron Sierra <asierra@xes-inc.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

By this patch we still recognise the old binding ti,swap-xy in parallel to
the common binding touchscreen-swapped-x-y. This keeps compatibility
to older (out-of-tree) device tree binaries.

We do this in a separate patch so that it can be easily reverted in the
future to retire the old API. A notice is printed to remind developers
of using old API.

We also fix the bindings name for all in-tree device tree sources in
a separate patch.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/touchscreen/ads7846.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4525f00..b9896fd 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1259,7 +1259,11 @@ static const struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
 	of_property_read_u16(node, "ti,vref-mv", &pdata->vref_mv);
 	pdata->keep_vref_on = of_property_read_bool(node, "ti,keep-vref-on");
 
-	pdata->swap_xy = of_property_read_bool(node, "touchscreen-swapped-x-y");
+	pdata->swap_xy = of_property_read_bool(node, "ti,swap-xy");
+	if (pdata->swap_xy)
+		dev_notice(dev, "please update device tree to use touchscreen-swapped-x-y");
+	pdata->swap_xy |= of_property_read_bool(node,
+						"touchscreen-swapped-x-y");
 
 	of_property_read_u16(node, "ti,settle-delay-usec",
 			     &pdata->settle_delay_usecs);
-- 
2.5.1
