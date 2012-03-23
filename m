From: mathieu.poirier@linaro.org
Subject: [PATCH 3/9] ARM: omap2/n8x0: work around modular omap mmc
Date: Fri, 23 Mar 2012 11:13:50 -0600
Message-ID: <1332522836-29517-4-git-send-email-mathieu.poirier@linaro.org>
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

From: Russell King <linux@arm.linux.org.uk>

When the omap driver is built as a module for n8x0,
n8x0_mmc_set_power_menelaus cannot call into the driver:

arch/arm/mach-omap2/board-n8x0.c:374: undefined reference
to `omap_mmc_notify_cover_event'

As a workaround, do not provide that device in this case. This needs
to be fixed properly, e.g. by converting n8x0 to be probed through the
device tree and moving that code into the driver.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Suggested-by: Russell King <linux@arm.linux.org.uk>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 6722627..8529ca0 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -193,8 +193,10 @@ static struct omap_onenand_platform_data board_onenand_data[] = {
 };
 #endif
 
-#if defined(CONFIG_MENELAUS) &&						\
-	(defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE))
+#ifdef CONFIG_MMC_OMAP_MODULE
+#warning FIXME: cannot call omap_mmc_notify_cover_event for CONFIG_MMC_OMAP_MODULE
+#endif
+#if defined(CONFIG_MENELAUS) && (defined(CONFIG_MMC_OMAP)
 
 /*
  * On both N800 and N810, only the first of the two MMC controllers is in use.
-- 
1.7.5.4
