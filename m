From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] OMAP: McBSP: Do not use extensive spin locks
	for dma_op_mode
Date: Tue, 27 Oct 2009 13:00:15 +0200
Message-ID: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, broonie@opensource.wolfsonmicro.com, eduardo.valentin@nokia.com
List-Id: linux-omap@vger.kernel.org

The use of the spin lock, which supposed to protect the the
dma_op_mode causing "INFO: inconsistent lock state" on
playback start.
Remove the spin locks around the dma_op_mode, when it's
purpuse is to protect the dma_op_mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 88ac976..9b33671 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -298,9 +298,7 @@ int omap_mcbsp_get_dma_op_mode(unsigned int id)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	spin_lock_irq(&mcbsp->lock);
 	dma_op_mode = mcbsp->dma_op_mode;
-	spin_unlock_irq(&mcbsp->lock);
 
 	return dma_op_mode;
 }
@@ -318,7 +316,6 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 
-		spin_lock_irq(&mcbsp->lock);
 		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
 			syscon |= (ENAWAKEUP | SIDLEMODE(0x02) |
 					CLOCKACTIVITY(0x02));
@@ -327,7 +324,6 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 		} else {
 			syscon |= SIDLEMODE(0x01);
 		}
-		spin_unlock_irq(&mcbsp->lock);
 
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 	}
@@ -1145,9 +1141,7 @@ static ssize_t dma_op_mode_show(struct device *dev,
 	ssize_t len = 0;
 	const char * const *s;
 
-	spin_lock_irq(&mcbsp->lock);
 	dma_op_mode = mcbsp->dma_op_mode;
-	spin_unlock_irq(&mcbsp->lock);
 
 	for (s = &dma_op_modes[i]; i < ARRAY_SIZE(dma_op_modes); s++, i++) {
 		if (dma_op_mode == i)
-- 
1.6.5.1
