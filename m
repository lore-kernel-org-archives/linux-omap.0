From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH 1/2] OMAP2: PM: Kill compile warnings at
	arch/arm/mach-omap2/pm.c
Date: Mon, 27 Aug 2007 15:11:44 -0400
Message-ID: <11882419051271-git-send-email-felipe.lima@indt.org.br>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Get rid of the following warnings:
arch/arm/mach-omap2/pm.c: In function 'omap2_enter_full_retention':
arch/arm/mach-omap2/pm.c:509: warning: implicit declaration of function 'omap2_gpio_prepare_for_retention'
arch/arm/mach-omap2/pm.c:536: warning: implicit declaration of function 'omap2_gpio_resume_after_retention'

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 arch/arm/mach-omap2/pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 8e4b1f6..daf0b2d 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -39,6 +39,7 @@
 #include <asm/arch/irqs.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
+#include <asm/arch/gpio.h>
 #include <asm/arch/pm.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/dma.h>
-- 
1.5.3.rc6.17.g1911
