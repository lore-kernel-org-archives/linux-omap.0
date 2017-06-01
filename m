From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/5] ARM: OMAP1: DMA: Delete an error message for a failed
 memory allocation in omap1_system_dma_init()
Date: Thu, 1 Jun 2017 22:49:06 +0200
Message-ID: <cda37778-b59c-ae5e-529d-b435750dcd8f@users.sourceforge.net>
References: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 21:54:36 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap1/dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 823dba3dc033..c545b4e01d53 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -343,6 +343,4 @@ static int __init omap1_system_dma_init(void)
 	if (!d) {
-		dev_err(&pdev->dev, "%s: Unable to allocate 'd' for %s\n",
-			__func__, pdev->name);
 		ret = -ENOMEM;
 		goto exit_iounmap;
 	}
-- 
2.13.0
