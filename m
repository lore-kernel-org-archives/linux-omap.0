From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V5 4/6] OMAPDSS: VENC: Remove cpu_is_xxxx checks
Date: Mon, 20 Aug 2012 18:54:35 +0530
Message-ID: <20da18d29ba948e3cab7cc87184a33d7407c5ada.1345468541.git.cmahapatra@ti.com>
References: <cover.1343912532.git.cmahapatra@ti.com> <cover.1345468541.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37513 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756014Ab2HTN3D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 09:29:03 -0400
In-Reply-To: <cover.1345468541.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

OMAP4 checks are removed from VENC to provide it a cleaner interface. These
checks were introduced by patches "HACK: OMAP: DSS2: VENC: disable VENC on OMAP4
to prevent crash" (ba02fa37de) by Tomi Valkeinen <tomi.valkeinen@ti.com> and
"OMAPDSS: VENC: fix NULL pointer dereference in DSS2 VENC sysfs debug attr on
OMAP4" (cc1d3e032d)  by Danny Kukawka <danny.kukawka@bisect.de> to prevent VENC
from crashing OMAP4 kernel. An alternative approach is used to do the same in
later patches.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/venc.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 3a22087..8fc165a 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -752,11 +752,6 @@ static void venc_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, venc_read_reg(r))
 
-	if (cpu_is_omap44xx()) {
-		seq_printf(s, "VENC currently disabled on OMAP44xx\n");
-		return;
-	}
-
 	if (venc_runtime_get())
 		return;
 
@@ -971,16 +966,10 @@ static struct platform_driver omap_venchw_driver = {
 
 int __init venc_init_platform_driver(void)
 {
-	if (cpu_is_omap44xx())
-		return 0;
-
 	return platform_driver_probe(&omap_venchw_driver, omap_venchw_probe);
 }
 
 void __exit venc_uninit_platform_driver(void)
 {
-	if (cpu_is_omap44xx())
-		return;
-
 	platform_driver_unregister(&omap_venchw_driver);
 }
-- 
1.7.10

