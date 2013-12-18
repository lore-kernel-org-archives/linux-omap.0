From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 2/3] driver: pwm: ti-ecap: Remove duplicate put_sync call.
Date: Wed, 18 Dec 2013 17:06:54 +0530
Message-ID: <1387366615-23182-3-git-send-email-sourav.poddar@ti.com>
References: <1387366615-23182-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38644 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab3LRLhG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 06:37:06 -0500
In-Reply-To: <1387366615-23182-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Remove duplicate 'pm_runtime_put_sync' in the remove path.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/pwm/pwm-tiecap.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 4e5c3d1..032092c 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -279,7 +279,6 @@ static int ecap_pwm_remove(struct platform_device *pdev)
 	pwmss_submodule_state_change(pdev->dev.parent, PWMSS_ECAPCLK_STOP_REQ);
 	pm_runtime_put_sync(&pdev->dev);
 
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return pwmchip_remove(&pc->chip);
 }
-- 
1.7.1

