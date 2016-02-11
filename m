From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] dmaengine: edma: Implement device_synchronize callback
Date: Thu, 11 Feb 2016 13:12:20 +0200
Message-ID: <56BC6C94.1060409@ti.com>
References: <1455181722-32099-1-git-send-email-peter.ujfalusi@ti.com>
 <56BC5759.80000@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------010201030304020808000908"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56BC5759.80000@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--------------010201030304020808000908
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit

On 02/11/2016 11:41 AM, Lars-Peter Clausen wrote:
> On 02/11/2016 10:08 AM, Peter Ujfalusi wrote:
>> We need the callback to support the dmaengine_terminate_sync().
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Looks good, but I noticed a slight race condition in
> edma_completion_handler(). You need to fetch echan->desc while holding the
> vchan.lock. Otherwise this can race against terminate_all() and the callback
> might get scheduled even though terminate_all() completed and then there is
> a race where the synchronize() operation could be called before the callback
> gets scheduled, which means it doesn't do its intended job. Highly unlikely
> to happen, but theoretically possible.

Right, actually I had (have) another series fixing the very same race in a
different way - patching the terminate_all (series attached).
We have seen race with RT kernel on uniprocessor setup.

The tasklet_kill after the terminate_all will execute the scheduled task
unconditionally, so the vchan_complete() will run after we have terminated the
channel, which might be not what we want.
I have also seen a race condition as explained in the first patch. The only
way I was able to fix that by using the attached patches. Unfortunately I can
not test RT with mainline yet, so I'm not 100% sure if by using the
dmaengine_terminate_sync() in drivers will fix the issue.

-- 
Péter

--------------010201030304020808000908
Content-Type: text/x-patch;
	name="0001-dmaengine-virt-dma-Support-for-ignoring-callback-aft.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-dmaengine-virt-dma-Support-for-ignoring-callback-aft.pa";
	filename*1="tch"

>From 84a010c5732e7cb3339bcb303a6e3f3e6e3ba012 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 10 Feb 2016 08:51:52 +0200
Subject: [RFC 1/3] dmaengine: virt-dma: Support for ignoring callback after vc
 termination

This patch provides means to prevent the race condition between vchan
completion tasklet and the terminate_all function.
The race condition is not easily reproducible, but it has been observed
with RT kernel on uniprocessor systems with high rate DMA activity (UART)
and it follows this pattern:
When terminate_all is called, the tasklet has been already scheduled or
it is running to handle the completion of a vdesc. The client driver might
be freeing up resources after terminating the transfers but the tasklet
when it has a chance to continue to execute will call the provided callback
even after the client driver does not expect this to happen.
The terminated flag for the vchan itself does not provide enough protection
since can still face with a race condition:
in this case when the vchan_complete() tests for the terminated flag it will
see that the vchan is not terminated, but right after the test it is
possible that the terminate thread is set to execute (uniprocessor + RT) and
it will free up the resources. After that the vchan_complete() will resume
and calls the callback. This will lead to crash.

To provide protection, the dma driver need to make sure that the tasklet
will not run while we terminate the channel by:

static int dmadriver_terminate_all(struct dma_chan *chan)
{
	unsigned long flags;
	LIST_HEAD(head);
...
	tasklet_disable(&vc.task);
	spin_lock_irqsave(&vc.lock, flags);
	vchan_terminate(&vc);
...
	vchan_get_all_descriptors(&vc, &head);
	spin_unlock_irqrestore(&vc.lock, flags);
	vchan_dma_desc_free_list(&vc, &head);
	tasklet_enable(&vc.task);

	return 0;
}

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/virt-dma.c |  6 ++++--
 drivers/dma/virt-dma.h | 13 +++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index a35c211857dd..4317d5d3ef1f 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -88,11 +88,13 @@ static void vchan_complete(unsigned long arg)
 	struct virt_dma_chan *vc = (struct virt_dma_chan *)arg;
 	struct virt_dma_desc *vd;
 	dma_async_tx_callback cb = NULL;
+	bool terminated;
 	void *cb_data = NULL;
 	LIST_HEAD(head);
 
 	spin_lock_irq(&vc->lock);
 	list_splice_tail_init(&vc->desc_completed, &head);
+	terminated = vc->terminated;
 	vd = vc->cyclic;
 	if (vd) {
 		vc->cyclic = NULL;
@@ -101,7 +103,7 @@ static void vchan_complete(unsigned long arg)
 	}
 	spin_unlock_irq(&vc->lock);
 
-	if (cb)
+	if (cb && !terminated)
 		cb(cb_data);
 
 	while (!list_empty(&head)) {
@@ -115,7 +117,7 @@ static void vchan_complete(unsigned long arg)
 		else
 			vc->desc_free(vd);
 
-		if (cb)
+		if (cb && !terminated)
 			cb(cb_data);
 	}
 }
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index d9731ca5e262..4df44b1dafbf 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -27,6 +27,7 @@ struct virt_dma_chan {
 	void (*desc_free)(struct virt_dma_desc *);
 
 	spinlock_t lock;
+	bool terminated;
 
 	/* protected by vc.lock */
 	struct list_head desc_allocated;
@@ -80,6 +81,7 @@ static inline struct dma_async_tx_descriptor *vchan_tx_prep(struct virt_dma_chan
 static inline bool vchan_issue_pending(struct virt_dma_chan *vc)
 {
 	list_splice_tail_init(&vc->desc_submitted, &vc->desc_issued);
+	vc->terminated = false;
 	return !list_empty(&vc->desc_issued);
 }
 
@@ -116,6 +118,17 @@ static inline void vchan_cyclic_callback(struct virt_dma_desc *vd)
 }
 
 /**
+ * vchan_terminate - set the virtual channel as terminated
+ * vc: virtual channel to update
+ *
+ * vc.lock must be held by caller
+ */
+static inline void vchan_terminate(struct virt_dma_chan *vc)
+{
+	vc->terminated = true;
+}
+
+/**
  * vchan_next_desc - peek at the next descriptor to be processed
  * @vc: virtual channel to obtain descriptor from
  *
-- 
2.7.1


--------------010201030304020808000908
Content-Type: text/x-patch;
	name="0002-dmaengine-omap-dma-Prevent-race-between-vchan_comple.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0002-dmaengine-omap-dma-Prevent-race-between-vchan_comple.pa";
	filename*1="tch"

>From 9618f1f4f068b4272d1034e63a5d6cd501084d2a Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 10 Feb 2016 08:55:44 +0200
Subject: [RFC 2/3] dmaengine: omap-dma: Prevent race between vchan_complete()
 and terminate_all

Implement protection against vchan_complete() calling the client callback
after the channel has been terminated.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index bfdf29aa3428..1912be81e56d 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -980,7 +980,9 @@ static int omap_dma_terminate_all(struct dma_chan *chan)
 	unsigned long flags;
 	LIST_HEAD(head);
 
+	tasklet_disable(&c->vc.task);
 	spin_lock_irqsave(&c->vc.lock, flags);
+	vchan_terminate(&c->vc);
 
 	/*
 	 * Stop DMA activity: we assume the callback will not be called
@@ -1003,6 +1005,7 @@ static int omap_dma_terminate_all(struct dma_chan *chan)
 	vchan_get_all_descriptors(&c->vc, &head);
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 	vchan_dma_desc_free_list(&c->vc, &head);
+	tasklet_enable(&c->vc.task);
 
 	return 0;
 }
-- 
2.7.1


--------------010201030304020808000908
Content-Type: text/x-patch;
	name="0003-dmaengine-edma-Prevent-race-between-vchan_complete-a.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0003-dmaengine-edma-Prevent-race-between-vchan_complete-a.pa";
	filename*1="tch"

>From 061b50dd88f65f352afaee7d4418bbef1a9a5e35 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 10 Feb 2016 08:56:01 +0200
Subject: [RFC 3/3] dmaengine: edma: Prevent race between vchan_complete() and
 terminate_all

Implement protection against vchan_complete() calling the client callback
after the channel has been terminated.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 290e1a721c5b..edbf3a5d04b7 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -842,7 +842,9 @@ static int edma_terminate_all(struct dma_chan *chan)
 	unsigned long flags;
 	LIST_HEAD(head);
 
+	tasklet_disable(&echan->vchan.task);
 	spin_lock_irqsave(&echan->vchan.lock, flags);
+	vchan_terminate(&echan->vchan);
 
 	/*
 	 * Stop DMA activity: we assume the callback will not be called
@@ -865,6 +867,7 @@ static int edma_terminate_all(struct dma_chan *chan)
 	vchan_get_all_descriptors(&echan->vchan, &head);
 	spin_unlock_irqrestore(&echan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&echan->vchan, &head);
+	tasklet_enable(&echan->vchan.task);
 
 	return 0;
 }
-- 
2.7.1


--------------010201030304020808000908--
