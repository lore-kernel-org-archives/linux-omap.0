From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 07/14] arm: common: edma: API to request non default queue
	for a channel
Date: Tue, 1 Apr 2014 16:06:08 +0300
Message-ID: <1396357575-30585-8-git-send-email-peter.ujfalusi@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1396357575-30585-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

When using eDMA3 via dmaengine all dma channels will use the default queue.
Since during request time we do not have means to change this it need to be done
later, before the DMA has been started.
With the added function it is possible to move the channel to a non default
queue if it is possible, otherwise (when only one EQ/TC is available for the CC)
the default queue is going to be used.
For example: For optimal system performance the audio (cyclic) DMA should
be placed to a separate queue which is different than what the rest of the
system is using.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/common/edma.c             | 27 +++++++++++++++++++++++++++
 include/linux/platform_data/edma.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index be267b2080be..eaf6dd19f082 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -712,6 +712,33 @@ int edma_alloc_channel(int channel,
 }
 EXPORT_SYMBOL(edma_alloc_channel);
 
+/**
+ * edma_request_non_default_queue - try to map the channel to non default queue
+ * @channel: dma channel returned from edma_alloc_channel()
+ *
+ * For certain type of applications like audio it is preferred to not use the
+ * default event queue/tc to avoid eDMA caused latency.
+ *
+ * This function will iterate through the event queues available for the CC and
+ * picks the first EQ/TC which is not set as the default for the CC
+ */
+void edma_request_non_default_queue(int channel)
+{
+	unsigned ctlr = EDMA_CTLR(channel);
+	enum dma_event_q eventq_no = EVENTQ_DEFAULT;
+	int i;
+
+	for (i = 0; i < edma_cc[ctlr]->num_tc; i++) {
+		if (i != edma_cc[ctlr]->default_queue) {
+			eventq_no = i;
+			break;
+		}
+	}
+
+	channel = EDMA_CHAN_SLOT(channel);
+	map_dmach_queue(ctlr, channel, eventq_no);
+}
+EXPORT_SYMBOL(edma_request_non_default_queue);
 
 /**
  * edma_free_channel - deallocate DMA channel
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index 923f8a3e4ce0..5d0a1b98f205 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -117,6 +117,8 @@ int edma_alloc_channel(int channel,
 	void *data, enum dma_event_q);
 void edma_free_channel(unsigned channel);
 
+void edma_request_non_default_queue(int channel);
+
 /* alloc/free parameter RAM slots */
 int edma_alloc_slot(unsigned ctlr, int slot);
 void edma_free_slot(unsigned slot);
-- 
1.9.1
