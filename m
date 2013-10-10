From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/8] ARM: OMAP2+: Add minimal 8250 support for GPMC
Date: Thu, 10 Oct 2013 15:20:44 -0700
Message-ID: <20131010222044.9063.71060.stgit@localhost>
References: <20131010221833.9063.49904.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49133 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753259Ab3JJWUs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 18:20:48 -0400
In-Reply-To: <20131010221833.9063.49904.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org

Just initialize things using the bootloader timings like
we've been doing for the legacy booting too. It should be
possible to patch in the GPMC timings for the based on the
TL16CP743C/TL16C754C manual at:

http://www.ti.com/lit/ds/slls644g/slls644g.pdf

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpmc.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 579697a..51525fa 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1521,6 +1521,42 @@ err:
 	return ret;
 }
 
+/*
+ * REVISIT: Add timing support from slls644g.pdf
+ */
+static int gpmc_probe_8250(struct platform_device *pdev,
+				struct device_node *child)
+{
+	struct resource res;
+	unsigned long base;
+	int ret, cs;
+
+	if (of_property_read_u32(child, "reg", &cs) < 0) {
+		dev_err(&pdev->dev, "%s has no 'reg' property\n",
+			child->full_name);
+		return -ENODEV;
+	}
+
+	if (of_address_to_resource(child, 0, &res) < 0) {
+		dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
+			child->full_name);
+		return -ENODEV;
+	}
+
+	ret = gpmc_cs_request(cs, resource_size(&res), &base);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot request GPMC CS %d\n", cs);
+		return ret;
+	}
+
+	if (of_platform_device_create(child, NULL, &pdev->dev))
+		return 0;
+
+	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
+
+	return -ENODEV;
+}
+
 static int gpmc_probe_dt(struct platform_device *pdev)
 {
 	int ret;
@@ -1564,6 +1600,8 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 		else if (of_node_cmp(child->name, "ethernet") == 0 ||
 			 of_node_cmp(child->name, "nor") == 0)
 			ret = gpmc_probe_generic_child(pdev, child);
+		else if (of_node_cmp(child->name, "8250") == 0)
+			ret = gpmc_probe_8250(pdev, child);
 
 		if (WARN(ret < 0, "%s: probing gpmc child %s failed\n",
 			 __func__, child->full_name))

