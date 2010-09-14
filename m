From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 1/8] cbus: Fix compile by converting ioctl calls to unlocked_ioctl calls
Date: Tue, 14 Sep 2010 11:30:09 +0300
Message-ID: <1284453016-8295-2-git-send-email-balbi@ti.com>
References: <1284453016-8295-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46578 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab0INIaY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 04:30:24 -0400
In-Reply-To: <1284453016-8295-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

From: Jarkko Nikula <jhnikula@gmail.com>

Locked .ioctl is gone from struct file_operations by commit b19dd42
so these cbus drivers don't compile. Also it seems there is no need for BKL
anyway in these drivers.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu-user.c  |    5 ++---
 drivers/cbus/retu-wdt.c   |    6 +++---
 drivers/cbus/tahvo-user.c |    5 ++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/cbus/retu-user.c b/drivers/cbus/retu-user.c
index 953d92a..c36f356 100644
--- a/drivers/cbus/retu-user.c
+++ b/drivers/cbus/retu-user.c
@@ -270,8 +270,7 @@ static int retu_close(struct inode *inode, struct file *filp)
 /*
  * Device control (ioctl)
  */
-static int retu_ioctl(struct inode *inode, struct file *filp,
-		      unsigned int cmd, unsigned long arg)
+static long retu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct retu_tahvo_write_parms par;
 	int ret;
@@ -360,7 +359,7 @@ static unsigned retu_poll(struct file *filp, struct poll_table_struct *pt)
 
 static struct file_operations retu_user_fileops = {
 	.owner = THIS_MODULE,
-	.ioctl = retu_ioctl,
+	.unlocked_ioctl = retu_ioctl,
 	.read = retu_read,
 	.release = retu_close,
 	.poll = retu_poll
diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 6070a05..3d83cdc 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -184,8 +184,8 @@ static ssize_t retu_wdt_write(struct file *file, const char __user *data,
 	return len;
 }
 
-static int retu_wdt_ioctl(struct inode *inode, struct file *file,
-					unsigned int cmd, unsigned long arg)
+static long retu_wdt_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
 {
 	int new_margin;
 
@@ -246,7 +246,7 @@ static int __devinit retu_wdt_ping(void)
 static const struct file_operations retu_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.write		= retu_wdt_write,
-	.ioctl		= retu_wdt_ioctl,
+	.unlocked_ioctl	= retu_wdt_ioctl,
 	.open		= retu_wdt_open,
 	.release	= retu_wdt_release,
 };
diff --git a/drivers/cbus/tahvo-user.c b/drivers/cbus/tahvo-user.c
index bd30f06..9cfc71c 100644
--- a/drivers/cbus/tahvo-user.c
+++ b/drivers/cbus/tahvo-user.c
@@ -254,8 +254,7 @@ static int tahvo_close(struct inode *inode, struct file *filp)
 /*
  * Device control (ioctl)
  */
-static int tahvo_ioctl(struct inode *inode, struct file *filp,
-		       unsigned int cmd, unsigned long arg)
+static long tahvo_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct retu_tahvo_write_parms par;
 	int ret;
@@ -342,7 +341,7 @@ static unsigned tahvo_poll(struct file *filp, struct poll_table_struct *pt)
 
 static struct file_operations tahvo_user_fileops = {
 	.owner = THIS_MODULE,
-	.ioctl = tahvo_ioctl,
+	.unlocked_ioctl = tahvo_ioctl,
 	.read = tahvo_read,
 	.release = tahvo_close,
 	.poll = tahvo_poll
-- 
1.7.3.rc0.35.g8ac8c

