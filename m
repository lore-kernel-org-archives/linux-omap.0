From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/02] ARM: OMAP: DMA: Don't mark channel active in
	omap_enable_channel_irq
Date: Fri,  6 Jun 2008 18:21:47 -0700
Message-ID: <1212801708-17599-2-git-send-email-tony@atomide.com>
References: <1212801708-17599-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1212801708-17599-1-git-send-email-tony@atomide.com>
Message-Id: v2.6.26-rc5-omap-fixes-1-2
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Channel should be marked active only when DMA is really started. Otherwise
just omap_request_dma, omap_dma_link_lch and omap_dma_unlink_lch will cause
incorrect dump_stack().

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c00eda5..39c637b 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -501,8 +501,6 @@ static inline void omap_enable_channel_irq(int lch)
 
 	/* Enable some nice interrupts. */
 	OMAP_DMA_CICR_REG(lch) = dma_chan[lch].enabled_irqs;
-
-	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 }
 
 static void omap_disable_channel_irq(int lch)

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
