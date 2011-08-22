From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 2/3] OMAP: omap_device: Add a DT parser for multiple strings
Date: Mon, 22 Aug 2011 20:22:22 +0200
Message-ID: <1314037343-19783-3-git-send-email-b-cousson@ti.com>
References: <1314037343-19783-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47487 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174Ab1HVSWk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 14:22:40 -0400
In-Reply-To: <1314037343-19783-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, grant.likely@secretlab.ca, Benoit Cousson <b-cousson@ti.com>

Add two helpers function to parse a property that contains multiple
strings.

These functions might be exported and moved to a common place if they
can to be useful elsewhere.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/omap_device.c |   39 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 752d72a..70361f8 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -315,6 +315,45 @@ static void _add_hwmod_clocks_clkdev(struct omap_device *od,
 		_add_clkdev(od, oh->opt_clks[i].role, oh->opt_clks[i].clk);
 }
 
+/*
+ * XXX: DT helper functions that should probably move elsewhere if
+ * they become usefull for other needs.
+ */
+static int _dt_count_property_string(const char *prop, int len)
+{
+	int i = 0;
+	size_t l = 0, total = 0;
+
+	if (!prop || !len)
+		return -EINVAL;
+
+	for (i = 0; len >= total; total += l, prop += l) {
+		l = strlen(prop) + 1;
+		if (*prop != 0)
+			i++;
+	}
+	return i;
+}
+
+static int _dt_get_property(const char *prop, int len, int index, char *output,
+			    int size)
+{
+	int i = 0;
+	size_t l = 0, total = 0;
+
+	if (!prop || !len)
+		return -EINVAL;
+
+	for (i = 0; len >= total; total += l, prop += l) {
+		l = strlcpy(output, prop, size) + 1;
+		if (*prop != 0) {
+			if (i++ == index)
+				return 0;
+		}
+	}
+	return -ENODEV;
+}
+
 
 /* Public functions for use by core code */
 
-- 
1.7.0.4

