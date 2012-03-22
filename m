From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 04/13] Remove non-existent parameter from fixed-helper.c kernel doc.
Date: Wed, 21 Mar 2012 22:19:45 -0700
Message-ID: <1332393594-23993-5-git-send-email-Russ.Dill@ti.com>
References: <20120321194133.GP9859@atomide.com>
 <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65308 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567Ab2CVFUX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 01:20:23 -0400
Received: by mail-ob0-f174.google.com with SMTP id eh20so1236214obb.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 22:20:23 -0700 (PDT)
In-Reply-To: <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>, Russ Dill <russ.dill@ti.com>

Signed-off-by: Russ Dill <russ.dill@ti.com>
---
 drivers/regulator/fixed-helper.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/fixed-helper.c b/drivers/regulator/fixed-helper.c
index 30d0a15..961e2c9 100644
--- a/drivers/regulator/fixed-helper.c
+++ b/drivers/regulator/fixed-helper.c
@@ -18,7 +18,6 @@ static void regulator_fixed_release(struct device *dev)
 
 /**
  * regulator_register_fixed - register a no-op fixed regulator
- * @name: supply name
  * @id: platform device id
  * @supplies: consumers for this regulator
  * @num_supplies: number of consumers
-- 
1.7.9.1

