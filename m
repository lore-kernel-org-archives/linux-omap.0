From: "Andrzej Zaborowski" <balrog@zabor.org>
Subject: [PATCH] More pt_regs (TSC2102).
Date: Tue, 14 Nov 2006 22:09:42 +0100
Message-ID: <1163538582428-git-send-email-balrog@zabor.org>
Reply-To: balrogg@gmail.com
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Andrzej Zaborowski <balrog@zabor.org>

Remove pt_regs use in drivers/spi/tsc2102.c.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
---
 drivers/spi/tsc2102.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/tsc2102.c b/drivers/spi/tsc2102.c
index 3d49d99..91d4d21 100644
--- a/drivers/spi/tsc2102.c
+++ b/drivers/spi/tsc2102.c
@@ -418,8 +418,7 @@ static void tsc2102_new_mode(struct tsc2
 static void tsc2102_check_status(struct tsc2102_dev *dev);
 
 /* TSC has new data for us availiable.  */
-static irqreturn_t
-tsc2102_handler(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t tsc2102_handler(int irq, void *dev_id)
 {
 	struct tsc2102_dev *dev = (struct tsc2102_dev *) dev_id;
 	spin_lock_irq(&dev->lock);
-- 
1.4.3.2
