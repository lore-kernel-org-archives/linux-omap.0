From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] remoteproc/wkup_m3: Use MODULE_DEVICE_TABLE to export alias
Date: Wed, 16 Sep 2015 07:32:54 -0500
Message-ID: <1442406774-13260-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Use MODULE_DEVICE_TABLE with wkup_m3_rproc_of_match so the module alias
is exported and the wkup_m3_rproc driver can automatically probe.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/remoteproc/wkup_m3_rproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
index edf8181..02d271d 100644
--- a/drivers/remoteproc/wkup_m3_rproc.c
+++ b/drivers/remoteproc/wkup_m3_rproc.c
@@ -122,6 +122,7 @@ static const struct of_device_id wkup_m3_rproc_of_match[] = {
 	{ .compatible = "ti,am4372-wkup-m3", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, wkup_m3_rproc_of_match);
 
 static int wkup_m3_rproc_probe(struct platform_device *pdev)
 {
-- 
2.4.6
