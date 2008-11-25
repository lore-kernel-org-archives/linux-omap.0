From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 10/10] omap mailbox: remove unnecessary header file inclusion
Date: Tue, 25 Nov 2008 11:39:58 +0200
Message-ID: <1227605998-13531-11-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1227605998-13531-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-3-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-4-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-5-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-6-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-7-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-8-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-9-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-10-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34879 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbYKYJkY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 04:40:24 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAP9e17B029701
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:40:22 +0200
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAP9dx9H001536
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:39:59 +0200
In-Reply-To: <1227605998-13531-10-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 5b00fc5..b03c8d9 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -21,15 +21,11 @@
  *
  */
 
-#include <linux/init.h>
 #include <linux/module.h>
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
-#include <linux/blkdev.h>
-#include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/io.h>
+
 #include <mach/mailbox.h>
 
 static int enable_seq_bit;
-- 
1.6.0.3.613.g9f8f13

