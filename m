From: Sundaram Raju <sundaram-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride
	configuration
Date: Sun, 10 Jul 2011 20:33:23 +0530
Message-ID: <1310310203-12288-1-git-send-email-sundaram@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <y>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Added new dma_ctrl_cmd TI_DMA_STRIDE_CONFIG to pass the TI DMA
controller specific configurations on how a buffer must be walked
through and how data is picked for transfer based on a specified
pattern over the channel.

The configuration passed is specific to the TI DMA controller used.

Signed-off-by: Sundaram Raju <sundaram-l0cyMroinI0@public.gmane.org>
---
 include/linux/dmaengine.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index eee7add..51dadc4 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -123,6 +123,10 @@ enum dma_ctrl_flags {
  * command.
  * @FSLDMA_EXTERNAL_START: this command will put the Freescale DMA controller
  * into external start mode.
+ * @TI_DMA_STRIDE_CONFIG: this command is only implemented by TI DMA
+ * controllers that need to pass special configuration on how to walk through
+ * the buffer to pick up data in a specified pattern to be transferred in
+ * the channel.
  */
 enum dma_ctrl_cmd {
 	DMA_TERMINATE_ALL,
@@ -130,6 +134,7 @@ enum dma_ctrl_cmd {
 	DMA_RESUME,
 	DMA_SLAVE_CONFIG,
 	FSLDMA_EXTERNAL_START,
+	TI_DMA_STRIDE_CONFIG,
 };
 
 /**
-- 
1.6.2.4
