From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/14] ARM: OMAP2+: Configure sdma capabilities directly
Date: Mon, 16 Dec 2019 16:19:17 -0800
Message-ID: <20191217001925.44558-7-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Vinod Koul <vinod.koul@intel.com>, Vinod Koul <vkoul@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Only earlier SoCs need to be checked for this, all SoCs starting with
omap3630 have CCDN register. This way we get closer to removing the need
to ioremap sdma registers in the platform code.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -273,10 +273,10 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 		d->dev_caps |= HS_CHANNELS_RESERVED;
 
 	/* Check the capabilities register for descriptor loading feature */
-	if (dma_read(CAPS_0, 0) & DMA_HAS_DESCRIPTOR_CAPS)
-		dma_common_ch_end = CCDN;
-	else
+	if (soc_is_omap24xx() || soc_is_omap34xx() || soc_is_am35xx())
 		dma_common_ch_end = CCFN;
+	else
+		dma_common_ch_end = CCDN;
 
 	return 0;
 }
-- 
2.24.1
