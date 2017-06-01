From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/5] ARM: OMAP1: DMA: Delete an unnecessary return statement
 in omap1_show_dma_caps()
Date: Thu, 1 Jun 2017 22:50:06 +0200
Message-ID: <3790e998-2d64-aef8-28ab-1bdad153738a@users.sourceforge.net>
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
Date: Thu, 1 Jun 2017 22:00:21 +0200

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap1/dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index c545b4e01d53..52d7eda1adec 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -240,7 +240,6 @@ static void omap1_show_dma_caps(void)
 		w |= 1 << 3;
 		dma_write(w, GSCR, 0);
 	}
-	return;
 }
 
 static unsigned configure_dma_errata(void)
-- 
2.13.0
