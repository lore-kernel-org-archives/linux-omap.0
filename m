From: David Brownell <david-b@pacbell.net>
Subject: [patch] bugfix:  SOUND: SOC: OMAP: Add support for Gumstix Overo
Date: Fri, 3 Oct 2008 08:11:33 -0700
Message-ID: <200810030811.33484.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:21803 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752262AbYJCPLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 11:11:43 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Get rid of bogus ASOC boot messages on non-Overo boards,
such as with a kernel built for both Overo and Beagle.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-By: Steve Sakoman <steve@sakoman.com>
---
I'm not sure where the four patches for Overo support are
in the ALSA queue (that's how they'll merge, yes?) but I'll
suggest this one merge into the initial "overo.c" submit...

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
