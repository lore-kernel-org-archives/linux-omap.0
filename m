From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] drivers/video/fbdev/omap2/dss/dss.c: add __exit to
 dss_uninit_ports
Date: Wed, 23 Apr 2014 18:09:58 +0200
Message-ID: <20140423180958.8b3cc405c00fbbf7c6c5a947@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@linux-foundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

dss_uninit_ports is only called by __exit omap_dsshw_remove

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/video/fbdev/omap2/dss/dss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index d55266c..a1c1cc2 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -813,7 +813,7 @@ static int __init dss_init_ports(struct platform_device *pdev)
 	return 0;
 }
 
-static void dss_uninit_ports(void)
+static void __exit dss_uninit_ports(void)
 {
 #ifdef CONFIG_OMAP2_DSS_DPI
 	dpi_uninit_port();
-- 
1.9.1
