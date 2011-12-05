From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/3] of/base: Take NULL string into account for property with multiple strings
Date: Mon, 5 Dec 2011 15:23:54 +0100
Message-ID: <1323095036-3739-2-git-send-email-b-cousson@ti.com>
References: <1323095036-3739-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60975 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176Ab1LEOYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Dec 2011 09:24:48 -0500
In-Reply-To: <1323095036-3739-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

The current implementation just ignore any NULL string inserted in a
multiple strings property.
In some cases we can have a property with a fix number of strings but
not necessarily used, like for example in a list of valid pinmux modes.

 prop = "uart_rx", "uart_tx", "", "", "safe_mode";

Do no skip NULL string and take them into account in
of_property_read_string_index and of_property_count_strings.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 drivers/of/base.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9b6588e..b707243 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -752,7 +752,7 @@ int of_property_read_string_index(struct device_node *np, const char *propname,
 
 	for (i = 0; total < prop->length; total += l, p += l) {
 		l = strlen(p) + 1;
-		if ((*p != 0) && (i++ == index)) {
+		if (i++ == index) {
 			*output = p;
 			return 0;
 		}
@@ -790,11 +790,9 @@ int of_property_count_strings(struct device_node *np, const char *propname)
 
 	p = prop->value;
 
-	for (i = 0; total < prop->length; total += l, p += l) {
+	for (i = 0; total < prop->length; total += l, p += l, i++)
 		l = strlen(p) + 1;
-		if (*p != 0)
-			i++;
-	}
+
 	return i;
 }
 EXPORT_SYMBOL_GPL(of_property_count_strings);
-- 
1.7.0.4

