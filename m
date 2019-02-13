From: Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  arm/mach-omap2/display: fix possible object reference leak
Date: Wed, 13 Feb 2019 23:32:49 +0800
Message-ID: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
List-Id: linux-omap@vger.kernel.org

of_find_device_by_node() takes a reference to the struct device
when it finds a match via get_device.When returning error we should
call put_device.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/arm/mach-omap2/display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index f86b72d..c6aa9ed 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -258,6 +258,7 @@ static int __init omapdss_init_of(void)
 	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
 	if (r) {
 		pr_err("Unable to populate DSS submodule devices\n");
+		put_device(&pdev->dev);
 		return r;
 	}
 
-- 
1.8.3.1
