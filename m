From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 2/5] DSPBRIDGE: Remove unnecessary check for NULL pointer in cmm.c
Date: Mon, 21 Jun 2010 17:07:11 -0500
Message-ID: <1277158034-21843-2-git-send-email-ernesto@ti.com>
References: <1277158034-21843-1-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52348 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778Ab0FUWE3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 18:04:29 -0400
In-Reply-To: <1277158034-21843-1-git-send-email-ernesto@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, hiroshi.doyu@nokia.com, Ernesto Ramos <ernesto@ti.com>

Remove unnecessary check for NULL pointer in cmm.c.
Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/cmm.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 7aa4ca4..1134193 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -996,10 +996,7 @@ int cmm_xlator_delete(struct cmm_xlatorobject *xlator, bool bForce)
 
 	DBC_REQUIRE(refs > 0);
 
-	if (xlator_obj)
-		kfree(xlator_obj);
-	else
-		status = -EFAULT;
+	kfree(xlator_obj);
 
 	return status;
 }
-- 
1.5.4.5

