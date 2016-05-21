From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0102/1529] Fix typo
Date: Sat, 21 May 2016 13:49:48 +0200
Message-ID: <20160521114948.4664-1-andrea.gelmini@gelma.net>
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
To: andrea.gelmini@gelma.net
Cc: tony@atomide.com, linux-omap@vger.kernel.org, trivial@kernel.org, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-omap1/ams-delta-fiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index d1f1209..acd6bf0 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -136,7 +136,7 @@ void __init ams_delta_init_fiq(void)
 		fiq_buffer[i] = 0;
 
 	/*
-	 * FIQ mode r9 always points to the fiq_buffer, becauses the FIQ isr
+	 * FIQ mode r9 always points to the fiq_buffer, because the FIQ isr
 	 * will run in an unpredictable context. The fiq_buffer is the FIQ isr's
 	 * only means of communication with the IRQ level and other kernel
 	 * context code.
-- 
2.8.2.534.g1f66975
