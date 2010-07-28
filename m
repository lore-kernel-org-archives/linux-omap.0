From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 2/5] staging:ti dspbridge: remove unnecessary check for NULL pointer in cmm.c
Date: Wed, 28 Jul 2010 09:40:49 -0500
Message-ID: <1280328052-31292-3-git-send-email-ernesto@ti.com>
References: <1280328052-31292-1-git-send-email-ernesto@ti.com>
 <1280328052-31292-2-git-send-email-ernesto@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1280328052-31292-2-git-send-email-ernesto@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: omar.ramirez@ti.com, ohad@wizery.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, fernando.lugo@ti.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, nm@ti.com, linux-omap@vger.kernel.org, Ernesto Ramos <ernesto@ti.com>
List-Id: linux-omap@vger.kernel.org

Remove unnecessary check for NULL pointer in cmm.c.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/staging/tidspbridge/pmgr/cmm.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/tidspbridge/pmgr/cmm.c b/drivers/staging/tidspbridge/pmgr/cmm.c
index 8e808d9..874ed64 100644
--- a/drivers/staging/tidspbridge/pmgr/cmm.c
+++ b/drivers/staging/tidspbridge/pmgr/cmm.c
@@ -992,16 +992,12 @@ int cmm_xlator_create(struct cmm_xlatorobject **xlator,
 int cmm_xlator_delete(struct cmm_xlatorobject *xlator, bool force)
 {
 	struct cmm_xlator *xlator_obj = (struct cmm_xlator *)xlator;
-	int status = 0;
 
 	DBC_REQUIRE(refs > 0);
 
-	if (xlator_obj)
-		kfree(xlator_obj);
-	else
-		status = -EFAULT;
+	kfree(xlator_obj);
 
-	return status;
+	return 0;
 }
 
 /*
-- 
1.5.4.5
