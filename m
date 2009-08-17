From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH 2/3] MFD: TWL4030: print warning for out-of-order script loading
Date: Mon, 17 Aug 2009 17:01:56 +0300
Message-ID: <1250517716-16079-1-git-send-email-amit.kucheria@verdurent.com>
References: <1250517469-15899-1-git-send-email-amit.kucheria@verdurent.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753777AbZHQOCG@vger.kernel.org>
In-Reply-To: <1250517469-15899-1-git-send-email-amit.kucheria@verdurent.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: sameo@linux.intel.com, dbrownell@users.sourceforge.net, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When the sleep script is loaded before the wakeup script, there is a
chance that the system might go to sleep before the wakeup script
loading is completed. This will lead to a system that does not wakeup
and has been observed to cause non-booting boards.

Various options were considered to solve this problem, including
modification of the core twl4030 power code to be smart enough to
reorder the loading of the scripts. But it felt too over-engineered.

Hence this patch just warns the DPS script developer so that they may be
reordered in the board-code itself.

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: sameo@linux.intel.com
Cc: dbrownell@users.sourceforge.net
Cc: linux-omap@vger.kernel.org
---
 drivers/mfd/twl4030-power.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index e7688b0..5284c7c 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -379,6 +379,7 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
 	       u8 address)
 {
 	int err;
+	static int order;
 
 	/* Make sure the script isn't going beyond last valid address (0x3f) */
 	if ((address + tscript->size) > END_OF_SCRIPT) {
@@ -399,6 +400,7 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
 		err = twl4030_config_wakeup12_sequence(address);
 		if (err)
 			goto out;
+		order = 1;
 	}
 	if (tscript->flags & TWL4030_WAKEUP3_SCRIPT) {
 		err = twl4030_config_wakeup3_sequence(address);
@@ -406,6 +408,10 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
 			goto out;
 	}
 	if (tscript->flags & TWL4030_SLEEP_SCRIPT)
+		if (order)
+			pr_warning("TWL4030: Bad order of scripts (sleep "\
+					"script before wakeup) Leads to boot"\
+					"failure on some boards\n");
 		err = twl4030_config_sleep_sequence(address);
 out:
 	return err;
-- 
1.6.3.3
