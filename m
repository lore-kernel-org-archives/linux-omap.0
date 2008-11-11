From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] BRIDGE: Fix uninitialized spinlock
Date: Tue, 11 Nov 2008 12:24:19 +0200
Message-ID: <1226399059-25707-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18217 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbYKKKYb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 05:24:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x00omar@ti.com, h-kanigeri2@ti.com, grgupta77@gmail.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>


Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/services/mem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 565b0b8..084fb0e 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -580,6 +580,7 @@ bool MEM_Init(void)
 		mMan.lst.head.next = &mMan.lst.head;
 		mMan.lst.head.prev = &mMan.lst.head;
 		mMan.lst.head.self = NULL;
+		spin_lock_init(&mMan.lock);
 #endif
 
 	}
-- 
1.6.0.3.613.g9f8f13

