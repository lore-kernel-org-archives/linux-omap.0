From: Mike Auty <mike.auty@gmail.com>
Subject: [PATCH] ARM: OMAP: Fix path for omap-sha1-md5 import of irqs.h
Date: Sat, 04 Apr 2009 22:40:11 +0100
Message-ID: <49D7D3BB.30500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34190 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752622AbZDDVkO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Apr 2009 17:40:14 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id A74863113E0
	for <linux-omap@vger.kernel.org>; Sat,  4 Apr 2009 17:40:12 -0400 (EDT)
Received: from [192.168.188.1] (82-71-33-97.dsl.in-addr.zen.co.uk [82.71.33.97])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 358E1553B9
	for <linux-omap@vger.kernel.org>; Sat,  4 Apr 2009 17:40:12 -0400 (EDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi there,

This is my first kernel-type patch, so please go easy on me if I've made
any mistakes.  I recently tried building the master kernel from master
(commit e75343a207ef24490176abe3503743d7a006e299) and it failed at
omap-sha1-md5.c with a file not found issue (asm/arch-omap/irqs.h).    I
looked for a similar file, and figured that it meant
asm/plat-omap/include/mach/irqs.h, so I produced the patch below.
Hopefully that's the correct solution, but I'd appreciate it if someone
else could look it over too.  Thanks very much,

Mike  5:)

---
 drivers/crypto/omap-sha1-md5.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/omap-sha1-md5.c b/drivers/crypto/omap-sha1-md5.c
index 6d77703..90ad56f 100644
--- a/drivers/crypto/omap-sha1-md5.c
+++ b/drivers/crypto/omap-sha1-md5.c
@@ -13,7 +13,7 @@
  * This driver is based on padlock-sha.c driver.
  */

-#include <asm/arch-omap/irqs.h>
+#include <mach/irqs.h>
 #include <crypto/algapi.h>
 #include <crypto/sha.h>
 #include <linux/err.h>
-- 
1.6.2.2

