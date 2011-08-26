From: Chase Maupin <Chase.Maupin@ti.com>
Subject: [PATCH] omap_vout: fix section mismatch in probe function
Date: Fri, 26 Aug 2011 11:10:15 -0500
Message-ID: <1314375015-15732-1-git-send-email-Chase.Maupin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58262 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724Ab1HZQTS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 12:19:18 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7QGJFcW008039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 11:19:18 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7QGJF5K005100
	for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 21:49:15 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Chase Maupin <Chase.Maupin@ti.com>

Building the OMAP vout driver resulted in the following message:

    WARNING: vmlinux.o(.data+0x38084): Section mismatch in reference
             from the variable omap_vout_driver to the function
             .init.text:omap_vout_probe()
    The variable omap_vout_driver references
    the function __init omap_vout_probe()
    If the reference is valid then annotate the
    variable with __init* or __refdata (see linux/init.h) or name
    the variable:
    *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one,
    *_console

Signed-off-by: Chase Maupin <Chase.Maupin@ti.com>
---
 drivers/media/video/omap/omap_vout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/omap/omap_vout.c b/drivers/media/video/omap/omap_vout.c
index b3a5ecd..9b5dad5 100644
--- a/drivers/media/video/omap/omap_vout.c
+++ b/drivers/media/video/omap/omap_vout.c
@@ -2133,7 +2133,7 @@ static int omap_vout_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __init omap_vout_probe(struct platform_device *pdev)
+static int omap_vout_probe(struct platform_device *pdev)
 {
 	int ret = 0, i;
 	struct omap_overlay *ovl;
-- 
1.7.0.4

