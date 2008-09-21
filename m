From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc6-omap] ASOC: quieter boot for non-Overo boards
Date: Sun, 21 Sep 2008 14:14:41 -0700
Message-ID: <200809211414.42194.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:41239 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752681AbYIUVUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Sep 2008 17:20:20 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>

Get rid of bogus ASOC boot messages on non-Overo boards.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 sound/soc/omap/overo.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/sound/soc/omap/overo.c
+++ b/sound/soc/omap/overo.c
@@ -107,11 +107,11 @@ static int __init overo_soc_init(void)
 {
 	int ret;
 
-	printk(KERN_INFO "overo SoC init\n");
 	if (!machine_is_overo()) {
-		printk(KERN_ERR "Not Overo!\n");
+		pr_debug("Not Overo!\n");
 		return -ENODEV;
 	}
+	printk(KERN_INFO "overo SoC init\n");
 
 	overo_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!overo_snd_device) {
@@ -135,13 +135,12 @@ err1:
 
 	return ret;
 }
+module_init(overo_soc_init);
 
 static void __exit overo_soc_exit(void)
 {
 	platform_device_unregister(overo_snd_device);
 }
-
-module_init(overo_soc_init);
 module_exit(overo_soc_exit);
 
 MODULE_AUTHOR("Steve Sakoman <steve@sakoman.com>");
