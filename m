From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH v1 3/3] PM / AVS: SmartReflex: fix driver name
Date: Mon, 27 May 2013 14:07:26 +0300
Message-ID: <1369652846-14412-4-git-send-email-andrii.tseglytskyi@ti.com>
References: <1369652846-14412-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57921 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757703Ab3E0LHf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 May 2013 07:07:35 -0400
In-Reply-To: <1369652846-14412-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, J Keerthy <j-keerthy@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

DRIVER_NAME was undefined for SmartReflex. Now it is
defined with valid value "smartreflex". It is needed
to define proper value for:
MODULE_ALIAS("platform:" DRIVER_NAME);

Signed-off-by: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
---
 drivers/power/avs/smartreflex.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 9b56648..002005e 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -27,6 +27,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/power/smartreflex.h>
 
+#define DRIVER_NAME	"smartreflex"
 #define SMARTREFLEX_NAME_LEN	16
 #define NVALUE_NAME_LEN		40
 #define SR_DISABLE_TIMEOUT	200
@@ -1070,7 +1071,7 @@ static struct platform_driver smartreflex_driver = {
 	.remove         = omap_sr_remove,
 	.shutdown	= omap_sr_shutdown,
 	.driver		= {
-		.name	= "smartreflex",
+		.name	= DRIVER_NAME,
 	},
 };
 
-- 
1.7.9.5

