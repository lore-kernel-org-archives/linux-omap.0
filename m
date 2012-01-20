From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: [PATCH] i2c: OMAP: Fix OMAP1 build error
Date: Fri, 20 Jan 2012 16:55:04 +0100
Message-ID: <4F198E58.4070509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46065 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753577Ab2ATPzZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 10:55:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-omap <linux-omap@vger.kernel.org>

CONFIG_OF is not defined for OMAP1 yet and thus the omap1_defconfig build
generate an error for 3.3-rc1.

drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_probe':
drivers/i2c/busses/i2c-omap.c:1021:26: error: 'omap_i2c_of_match' undeclared (first use in this function)
drivers/i2c/busses/i2c-omap.c:1021:26: note: each undeclared identifier is reported only once for each function it appears in

Wrap omap_i2c_of_match with of_match_ptr() to prevent compilation error in case of OMAP1 build.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f713eac..801df60 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1018,7 +1018,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
-	match = of_match_device(omap_i2c_of_match, &pdev->dev);
+	match = of_match_device(of_match_ptr(omap_i2c_of_match), &pdev->dev);
 	if (match) {
 		u32 freq = 100000; /* default to 100000 Hz */
 
-- 
1.7.0.4

