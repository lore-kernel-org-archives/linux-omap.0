From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH v1 2/3] PM / AVS: SmartReflex: disable runtime PM on driver remove
Date: Mon, 27 May 2013 14:07:25 +0300
Message-ID: <1369652846-14412-3-git-send-email-andrii.tseglytskyi@ti.com>
References: <1369652846-14412-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369652846-14412-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, J Keerthy <j-keerthy@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Runtime PM should be disabled for device on driver remove,
otherwise runtime PM will be not balanced, and this will cause
an error message, on next driver probe.

Signed-off-by: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
---
 drivers/power/avs/smartreflex.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index f34d34d..9b56648 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -1032,6 +1032,7 @@ static int omap_sr_remove(struct platform_device *pdev)
 	if (sr_info->dbg_dir)
 		debugfs_remove_recursive(sr_info->dbg_dir);
 
+	pm_runtime_disable(&pdev->dev);
 	list_del(&sr_info->node);
 	iounmap(sr_info->base);
 	kfree(sr_info->name);
-- 
1.7.9.5
