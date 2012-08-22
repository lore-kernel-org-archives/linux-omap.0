From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V6 5/6] OMAPDSS: VENC: Remove cpu_is_xxxx checks
Date: Wed, 22 Aug 2012 12:08:56 +0530
Message-ID: <193f95b3016061d17fba9475f3e97e4753568661.1345616887.git.cmahapatra@ti.com>
References: <cover.1345468541.git.cmahapatra@ti.com> <cover.1345616887.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57122 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754782Ab2HVGn3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Aug 2012 02:43:29 -0400
In-Reply-To: <cover.1345616887.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

OMAP4 checks are removed from VENC to provide it a cleaner interface. These
checks were introduced by patches "HACK: OMAP: DSS2: VENC: disable VENC on OMAP4
to prevent crash" (ba02fa37de) by Tomi Valkeinen <tomi.valkeinen@ti.com> and
"OMAPDSS: VENC: fix NULL pointer dereference in DSS2 VENC sysfs debug attr on
OMAP4" (cc1d3e032d)  by Danny Kukawka <danny.kukawka@bisect.de> to prevent VENC
from crashing OMAP4 kernel.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/venc.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 7d3eef8..4a6caf9 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -674,11 +674,6 @@ static void venc_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, venc_read_reg(r))
 
-	if (cpu_is_omap44xx()) {
-		seq_printf(s, "VENC currently disabled on OMAP44xx\n");
-		return;
-	}
-
 	if (venc_runtime_get())
 		return;
 
@@ -893,16 +888,10 @@ static struct platform_driver omap_venchw_driver = {
 
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

