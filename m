From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 2/4] staging:ti dspbridge: proc_load/start should set IVA2 to OFF in case of failure
Date: Wed, 28 Jul 2010 09:54:53 -0500
Message-ID: <1280328895-31375-3-git-send-email-ernesto@ti.com>
References: <1280328895-31375-1-git-send-email-ernesto@ti.com>
 <1280328895-31375-2-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58265 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755329Ab0G1Oua (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Jul 2010 10:50:30 -0400
In-Reply-To: <1280328895-31375-2-git-send-email-ernesto@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@suse.de
Cc: omar.ramirez@ti.com, ohad@wizery.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, fernando.lugo@ti.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, nm@ti.com, linux-omap@vger.kernel.org, Ernesto Ramos <ernesto@ti.com>

When a base image is being loaded or started and by some reason
the process fails, the IVA2 should be switched OFF.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/staging/tidspbridge/rmgr/proc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/proc.c b/drivers/staging/tidspbridge/rmgr/proc.c
index 6258d8b..44c26e1 100644
--- a/drivers/staging/tidspbridge/rmgr/proc.c
+++ b/drivers/staging/tidspbridge/rmgr/proc.c
@@ -1302,9 +1302,10 @@ int proc_load(void *hprocessor, const s32 argc_index,
 	}
 
 func_end:
-	if (status)
+	if (status) {
 		pr_err("%s: Processor failed to load\n", __func__);
-
+		proc_stop(p_proc_object);
+	}
 	DBC_ENSURE((!status
 		    && p_proc_object->proc_state == PROC_LOADED)
 		   || status);
@@ -1594,6 +1595,7 @@ func_cont:
 		}
 	} else {
 		pr_err("%s: Failed to start the dsp\n", __func__);
+		proc_stop(p_proc_object);
 	}
 
 func_end:
-- 
1.5.4.5

