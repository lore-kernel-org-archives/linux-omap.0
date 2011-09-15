From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC PATCH 02/11] regulator: Fix error check in set_consumer_device_supply
Date: Thu, 15 Sep 2011 16:51:58 +0530
Message-ID: <1316085727-15023-3-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56963 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933281Ab1IOLWg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 07:22:36 -0400
In-Reply-To: <1316085727-15023-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

The parameters to set_consumer_device_supply() can be considered
invalid (and hence it could return -EINVAL) if nether consumer_dev nor
consumer_dev_name are passed, not when *both* are passed.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/regulator/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8e6a42..9365359 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -981,7 +981,7 @@ static int set_consumer_device_supply(struct regulator_dev *rdev,
 	struct regulator_map *node;
 	int has_dev;
 
-	if (consumer_dev && consumer_dev_name)
+	if (!consumer_dev && !consumer_dev_name)
 		return -EINVAL;
 
 	if (!consumer_dev_name && consumer_dev)
-- 
1.7.1

