From: mathieu.poirier@linaro.org
Subject: [PATCH 2/9] omap: fix visibility of omap2_mbox_iva_priv
Date: Fri, 23 Mar 2012 11:13:49 -0600
Message-ID: <1332522836-29517-3-git-send-email-mathieu.poirier@linaro.org>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

map2_mbox_iva_priv is used on multiple omap2 socs but is hidden
in an outdated #ifdef that is specific to a single soc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 415a6f1..ef01f6c 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -258,7 +258,7 @@ struct omap_mbox mbox_dsp_info = {
 struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info, NULL };
 #endif
 
-#if defined(CONFIG_SOC_OMAP2420)
+#if defined(CONFIG_ARCH_OMAP2)
 /* IVA */
 static struct omap_mbox2_priv omap2_mbox_iva_priv = {
 	.tx_fifo = {
-- 
1.7.5.4
