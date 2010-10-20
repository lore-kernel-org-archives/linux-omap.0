From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCH] omap: mailbox - fix missing mbox owner assignment when creating queue
Date: Tue, 19 Oct 2010 21:53:40 -0500
Message-ID: <1287543220-15483-1-git-send-email-x0095840@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: felipe.contreras@nokia.com, david.cohen@nokia.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Fernando Guzman Lugo <x0095840@ti.com>
List-Id: linux-omap@vger.kernel.org

mbox field of omap_mbox_queue structure is never assigned to
the mailbox owner. Causing kernel panic when dereference it.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index c59c9c3..b1e0e8f 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -217,6 +217,7 @@ static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
 		return NULL;
 
 	spin_lock_init(&mq->lock);
+	mq->mbox = mbox;
 
 	if (kfifo_alloc(&mq->fifo, mbox_kfifo_size, GFP_KERNEL))
 		goto error;
-- 
1.6.3.3
