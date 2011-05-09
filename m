From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] MFD: twl4030-codec: Update e-mail address
Date: Mon, 9 May 2011 11:52:11 +0300
Message-ID: <1304931131-2825-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl4030-codec.c       |    3 ++-
 include/linux/mfd/twl4030-codec.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl4030-codec.c b/drivers/mfd/twl4030-codec.c
index c02fded..3641a6f 100644
--- a/drivers/mfd/twl4030-codec.c
+++ b/drivers/mfd/twl4030-codec.c
@@ -2,6 +2,7 @@
  * MFD driver for twl4030 codec submodule
  *
  * Author:	Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Contact:	Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * Copyright:   (C) 2009 Nokia Corporation
  *
@@ -270,6 +271,6 @@ static void __devexit twl4030_codec_exit(void)
 }
 module_exit(twl4030_codec_exit);
 
-MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@nokia.com>");
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
 MODULE_LICENSE("GPL");
 
diff --git a/include/linux/mfd/twl4030-codec.h b/include/linux/mfd/twl4030-codec.h
index 2ec317c..89a6820 100644
--- a/include/linux/mfd/twl4030-codec.h
+++ b/include/linux/mfd/twl4030-codec.h
@@ -2,6 +2,7 @@
  * MFD driver for twl4030 codec submodule
  *
  * Author:	Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Contact:	Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * Copyright:   (C) 2009 Nokia Corporation
  *
-- 
1.7.5.rc3
