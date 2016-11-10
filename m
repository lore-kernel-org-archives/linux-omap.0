From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 2/5] mfd: palmas: Remove redundant check in palmas_power_off
Date: Thu, 10 Nov 2016 10:39:17 +0530
Message-ID: <1478754560-27923-3-git-send-email-j-keerthy@ti.com>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lee.jones@linaro.org, robh+dt@kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, j-keerthy@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

palmas_dev and palmas_power_off are always assigned together.
So the check for palmas_dev inside palmas_power_off function
is redundant. Removing the same.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/mfd/palmas.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 8f8bacb..ee9e9ea 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -431,9 +431,6 @@ static void palmas_power_off(void)
 	unsigned int addr;
 	int ret, slave;
 
-	if (!palmas_dev)
-		return;
-
 	slave = PALMAS_BASE_TO_SLAVE(PALMAS_PMU_CONTROL_BASE);
 	addr = PALMAS_BASE_TO_REG(PALMAS_PMU_CONTROL_BASE, PALMAS_DEV_CTRL);
 
-- 
1.9.1
