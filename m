From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 2/3] spi: omap2-mcspi: Remove the macro MOD_REG_BIT
Date: Wed, 22 Aug 2012 11:35:13 +0530
Message-ID: <1345615515-26745-3-git-send-email-shubhrajyoti@ti.com>
References: <1345615515-26745-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1345615515-26745-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Remove the macro MOD_REG_BIT instead make the bit field modifications
directly. This deletes a branch operation in cases where the the set
is predecided. While at it optimise two sequential bit clear in one step.

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index f542f3d..8a5e2c0 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -140,13 +140,6 @@ struct omap2_mcspi_cs {
 	u32			chconf0;
 };
 
-#define MOD_REG_BIT(val, mask, set) do { \
-	if (set) \
-		val |= mask; \
-	else \
-		val &= ~mask; \
-} while (0)
-
 static inline void mcspi_write_reg(struct spi_master *master,
 		int idx, u32 val)
 {
@@ -205,7 +198,11 @@ static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
 	else
 		rw = OMAP2_MCSPI_CHCONF_DMAW;
 
-	MOD_REG_BIT(l, rw, enable);
+	if (enable)
+		l |= rw;
+	else
+		l &= ~rw;
+
 	mcspi_write_chconf0(spi, l);
 }
 
@@ -224,7 +221,11 @@ static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
 	u32 l;
 
 	l = mcspi_cached_chconf0(spi);
-	MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE, cs_active);
+	if (cs_active)
+		l |= OMAP2_MCSPI_CHCONF_FORCE;
+	else
+		l &= ~OMAP2_MCSPI_CHCONF_FORCE;
+
 	mcspi_write_chconf0(spi, l);
 }
 
@@ -239,9 +240,8 @@ static void omap2_mcspi_set_master_mode(struct spi_master *master)
 	 * to single-channel master mode
 	 */
 	l = mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
-	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_STEST, 0);
-	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_MS, 0);
-	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SINGLE, 1);
+	l &= ~(OMAP2_MCSPI_MODULCTRL_STEST | OMAP2_MCSPI_MODULCTRL_MS);
+	l |= OMAP2_MCSPI_MODULCTRL_SINGLE;
 	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
 
 	ctx->modulctrl = l;
@@ -1278,9 +1278,9 @@ static int omap2_mcspi_resume(struct device *dev)
 			 * We need to toggle CS state for OMAP take this
 			 * change in account.
 			 */
-			MOD_REG_BIT(cs->chconf0, OMAP2_MCSPI_CHCONF_FORCE, 1);
+			cs->chconf0 |= OMAP2_MCSPI_CHCONF_FORCE;
 			__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
-			MOD_REG_BIT(cs->chconf0, OMAP2_MCSPI_CHCONF_FORCE, 0);
+			cs->chconf0 &= ~OMAP2_MCSPI_CHCONF_FORCE;
 			__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
 		}
 	}
-- 
1.7.5.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
