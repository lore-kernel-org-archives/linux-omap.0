From: mturquette@gmail.com
Subject: [PATCH] MFD: TWL4030: program remap_sleep correctly
Date: Fri, 22 Jan 2010 14:12:58 -0600
Message-ID: <1264191178-12877-1-git-send-email-mturquette@ti.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754125Ab0AVUUH@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sameo@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Mike Turquette <mturquette@ti.com>

Variable remap was incorrectly referencing remap_off for the remap_sleep
case when configuring TWL4030 power scripts.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 drivers/mfd/twl4030-power.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Applies to MFD master branch, for .33 fixes

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 0815292..5b045ff 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -405,7 +405,7 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 
 	if (rconfig->remap_sleep != TWL4030_RESCONFIG_UNDEF) {
 		remap &= ~SLEEP_STATE_MASK;
-		remap |= rconfig->remap_off << SLEEP_STATE_SHIFT;
+		remap |= rconfig->remap_sleep << SLEEP_STATE_SHIFT;
 	}
 
 	err = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-- 
1.6.3.2
