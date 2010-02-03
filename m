From: Mike Turquette <mturquette@gmail.com>
Subject: [PATCH 1/2] MFD: TWL4030: introduce remove_script function
Date: Wed,  3 Feb 2010 13:43:26 -0600
Message-ID: <1265226207-22971-2-git-send-email-mturquette@ti.com>
References: <1265226207-22971-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f224.google.com ([209.85.217.224]:54384 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473Ab0BCTny (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 14:43:54 -0500
Received: by gxk24 with SMTP id 24so2170974gxk.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 11:43:54 -0800 (PST)
In-Reply-To: <1265226207-22971-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Turquette <mturquette@ti.com>

New function twl4030_remove_script(u8 flags) takes a script type as
defined in twl.h and prevents any script already loaded in that position
from running.  This is accomplished by programming SEQ_ADD_* to 0x3f,
the END_OF_SCRIPT value, where SEQ_ADD_* is determined by flags.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 drivers/mfd/twl4030-power.c |   50 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl.h     |    1 +
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index af6f60c..cf1042e 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -477,6 +477,56 @@ out:
 	return err;
 }
 
+int twl4030_remove_script(u8 flags)
+{
+	int err = 0;
+
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, R_KEY_1,
+			R_PROTECT_KEY);
+	if (err) {
+		pr_err("twl4030: unable to unlock PROTECT_KEY\n");
+		return err;
+	}
+
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, R_KEY_2,
+			R_PROTECT_KEY);
+	if (err) {
+		pr_err("twl4030: unable to unlock PROTECT_KEY\n");
+		return err;
+	}
+
+	if (flags & TWL4030_WRST_SCRIPT) {
+		err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, END_OF_SCRIPT,
+				R_SEQ_ADD_WARM);
+		if (err)
+			return err;
+	}
+	if (flags & TWL4030_WAKEUP12_SCRIPT) {
+		if (err)
+		err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, END_OF_SCRIPT,
+				R_SEQ_ADD_S2A12);
+			return err;
+	}
+	if (flags & TWL4030_WAKEUP3_SCRIPT) {
+		err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, END_OF_SCRIPT,
+				R_SEQ_ADD_S2A3);
+		if (err)
+			return err;
+	}
+	if (flags & TWL4030_SLEEP_SCRIPT) {
+		err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, END_OF_SCRIPT,
+				R_SEQ_ADD_A2S);
+		if (err)
+			return err;
+	}
+
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, R_PROTECT_KEY);
+	if (err)
+		pr_err("TWL4030 Unable to relock registers\n");
+
+	return err;
+}
+
 void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 {
 	int err = 0;
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index f9202ad..fbe8554 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -534,6 +534,7 @@ struct twl4030_power_data {
 };
 
 extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts);
+extern int twl4030_remove_script(u8 flags);
 
 struct twl4030_codec_audio_data {
 	unsigned int	audio_mclk;
-- 
1.6.3.2

