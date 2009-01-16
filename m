From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 10/10] omap mailbox: remove unnecessary header file inclusion
Date: Fri, 16 Jan 2009 10:27:52 +0200
Message-ID: <20090116082752.17571.46074.stgit@oreo.research.nokia.com>
References: <20090116081919.17571.34378.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29395 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762122AbZAPI2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 03:28:12 -0500
In-Reply-To: <20090116081919.17571.34378.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---

 arch/arm/plat-omap/mailbox.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 79f5fb7..feb286c 100644
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

