From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 2/4] lis3lv02d: DT: add wakeup unit 2 and wakeup threshold
Date: Sat, 21 Mar 2015 21:19:03 +0100
Message-ID: <1426969145-4478-3-git-send-email-sre@kernel.org>
References: <1426969145-4478-1-git-send-email-sre@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:59404 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbbCUUTg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 21 Mar 2015 16:19:36 -0400
In-Reply-To: <1426969145-4478-1-git-send-email-sre@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Eric Piel <eric.piel@tremplin-utc.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.or>

From: Sebastian Reichel <sre@kernel.or>

This adds support for the the wakeup threshold and
support for the second wakeup unit to the DT based
setup.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/misc/lis3lv02d/lis3lv02d.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index d2b0968..4739689 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -1032,6 +1032,23 @@ int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 		pdata->wakeup_flags |= LIS3_WAKEUP_Z_LO;
 	if (of_get_property(np, "st,wakeup-z-hi", NULL))
 		pdata->wakeup_flags |= LIS3_WAKEUP_Z_HI;
+	if (of_get_property(np, "st,wakeup-threshold", &val))
+		pdata->wakeup_thresh = val;
+
+	if (of_get_property(np, "st,wakeup2-x-lo", NULL))
+		pdata->wakeup_flags2 |= LIS3_WAKEUP_X_LO;
+	if (of_get_property(np, "st,wakeup2-x-hi", NULL))
+		pdata->wakeup_flags2 |= LIS3_WAKEUP_X_HI;
+	if (of_get_property(np, "st,wakeup2-y-lo", NULL))
+		pdata->wakeup_flags2 |= LIS3_WAKEUP_Y_LO;
+	if (of_get_property(np, "st,wakeup2-y-hi", NULL))
+		pdata->wakeup_flags2 |= LIS3_WAKEUP_Y_HI;
+	if (of_get_property(np, "st,wakeup2-z-lo", NULL))
+		pdata->wakeup_flags2 |= LIS3_WAKEUP_Z_LO;
+	if (of_get_property(np, "st,wakeup2-z-hi", NULL))
+		pdata->wakeup_flags2 |= LIS3_WAKEUP_Z_HI;
+	if (of_get_property(np, "st,wakeup2-threshold", &val))
+		pdata->wakeup_thresh2 = val;
 
 	if (!of_property_read_u32(np, "st,highpass-cutoff-hz", &val)) {
 		switch (val) {
-- 
2.1.4

