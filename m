From: mathieu.poirier@linaro.org
Subject: [PATCH 1/9] arm/omap: enable building omap2 without omap2420/2430
Date: Fri, 23 Mar 2012 11:13:48 -0600
Message-ID: <1332522836-29517-2-git-send-email-mathieu.poirier@linaro.org>
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

Kconfig allows selecting CONFIG_OMAP2 but no specific SOC, the options
being omap2420 and omap2430, but that leads to a build error when
omap3 or omap4 are also enabled and the MULTI_OMAP2 symbol is
undefined.

This adds another clause to plat/multi.h, mainly to allow all
possible randconfig combinations to build cleanly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/multi.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/multi.h b/arch/arm/plat-omap/include/plat/multi.h
index 999ffba..fb7f196 100644
--- a/arch/arm/plat-omap/include/plat/multi.h
+++ b/arch/arm/plat-omap/include/plat/multi.h
@@ -82,6 +82,11 @@
 #  define OMAP_NAME omap2430
 # endif
 #endif
+#ifdef CONFIG_ARCH_OMAP2
+# ifndef OMAP_NAME
+#  define OMAP_NAME omap2
+# endif
+#endif
 #ifdef CONFIG_ARCH_OMAP3
 # ifdef OMAP_NAME
 #  undef  MULTI_OMAP2
-- 
1.7.5.4
