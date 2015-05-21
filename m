From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH] mach-omap2:Remove unnessary return statement from the void
 function, omap2_show_dma_caps
Date: Thu, 21 May 2015 17:27:31 -0400
Message-ID: <1432243651-23061-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This removes the no longer required return statement at the end
of the void function, omap2_show_dma_cap due to no need for a
return statement due to this function always running successfully.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/arm/mach-omap2/dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index e1a56d8..1ed4be1 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -117,7 +117,6 @@ static void omap2_show_dma_caps(void)
 	u8 revision = dma_read(REVISION, 0) & 0xff;
 	printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
 				revision >> 4, revision & 0xf);
-	return;
 }
 
 static unsigned configure_dma_errata(void)
-- 
2.1.4
