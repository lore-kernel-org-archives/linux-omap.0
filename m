From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 02/18] dma: edma: Add support for DMA_PAUSE/RESUME operation
Date: Thu, 13 Mar 2014 11:18:24 +0200
Message-ID: <1394702320-21743-3-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1394702320-21743-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Pause/Resume can be used by the audio stack when the stream is paused/resumed
The edma platform code has support for this and the legacy audio stack used
this.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 drivers/dma/edma.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index cd04eb7b182e..b54cd2dedde0 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -240,6 +240,26 @@ static int edma_slave_config(struct edma_chan *echan,
 	return 0;
 }
 
+static int edma_dma_pause(struct edma_chan *echan)
+{
+	/* Pause/Resume only allowed with cyclic mode */
+	if (!echan->edesc->cyclic)
+		return -EINVAL;
+
+	edma_pause(echan->ch_num);
+	return 0;
+}
+
+static int edma_dma_resume(struct edma_chan *echan)
+{
+	/* Pause/Resume only allowed with cyclic mode */
+	if (!echan->edesc->cyclic)
+		return -EINVAL;
+
+	edma_resume(echan->ch_num);
+	return 0;
+}
+
 static int edma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 			unsigned long arg)
 {
@@ -255,6 +275,14 @@ static int edma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		config = (struct dma_slave_config *)arg;
 		ret = edma_slave_config(echan, config);
 		break;
+	case DMA_PAUSE:
+		ret = edma_dma_pause(echan);
+		break;
+
+	case DMA_RESUME:
+		ret = edma_dma_resume(echan);
+		break;
+
 	default:
 		ret = -ENOSYS;
 	}
-- 
1.9.0
