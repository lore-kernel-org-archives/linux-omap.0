From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/3] dma: edma: Increase maximum SG limit to 20
Date: Mon, 23 Sep 2013 18:05:15 -0500
Message-ID: <1379977515-3794-4-git-send-email-joelf@ti.com>
References: <1379977515-3794-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1379977515-3794-1-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Lars Peter-Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

davinci-pcm uses 16 as the no.of periods. With this, in EDMA we have to
allocate atleast 17 slots: 1 slot for channel, and 16 slots the periods.

Due to this, the MAX_NR_SG limitation causes problems, set it to 20 to make
cyclic DMA work when davinci-pcm is converted to use DMA Engine. Also add
a comment clarifying this.

Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
---
 drivers/dma/edma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 9b63e1e..407b496 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -46,8 +46,14 @@
 #define EDMA_CHANS	64
 #endif /* CONFIG_ARCH_DAVINCI_DA8XX */
 
-/* Max of 16 segments per channel to conserve PaRAM slots */
-#define MAX_NR_SG		16
+/*
+ * Max of 20 segments per channel to conserve PaRAM slots
+ * Also note that MAX_NR_SG should be atleast the no.of periods
+ * that are required for ASoC, otherwise DMA prep calls will
+ * fail. Today davinci-pcm is the only user of this driver and
+ * requires atleast 17 slots, so we setup the default to 20.
+ */
+#define MAX_NR_SG		20
 #define EDMA_MAX_SLOTS		MAX_NR_SG
 #define EDMA_DESCRIPTORS	16
 
-- 
1.8.1.2
