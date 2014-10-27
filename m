From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH v2] mtd: omap: fix mtd devices not showing up
Date: Mon, 27 Oct 2014 15:34:05 +0100
Message-ID: <1414420445-9020-1-git-send-email-frans.klaver@xsens.com>
References: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:52873 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbaJ0OeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Oct 2014 10:34:17 -0400
In-Reply-To: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Frans Klaver <frans.klaver@xsens.com>, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, Roger Quadros <rogerq@ti.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

Since commit 6d178ef2fd5e ("mtd: nand: Move ELM driver and rename as
omap_elm"), I don't have any mtd devices present on my am335x. This
changes the link order of the omap_elm and omap2 objects, causing them
to probe in the wrong order.

To fix this, make elm_config defer probing until the omap_elm driver is
actually loaded.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/mtd/nand/omap_elm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/omap_elm.c b/drivers/mtd/nand/omap_elm.c
index b4f61c7..0585310 100644
--- a/drivers/mtd/nand/omap_elm.c
+++ b/drivers/mtd/nand/omap_elm.c
@@ -115,7 +115,7 @@ int elm_config(struct device *dev, enum bch_ecc bch_type,
 
 	if (!info) {
 		dev_err(dev, "Unable to configure elm - device not probed?\n");
-		return -ENODEV;
+		return -EPROBE_DEFER;
 	}
 	/* ELM cannot detect ECC errors for chunks > 1KB */
 	if (ecc_step_size > ((ELM_ECC_SIZE + 1) / 2)) {
-- 
2.1.0

