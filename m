From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH] ARM: OMAP2+: craneboard: register emac device
Date: Thu, 19 Apr 2012 18:56:21 +0100
Message-ID: <1334858181-7232-1-git-send-email-mans@mansr.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This adds the required am35xx_emac_init() call to the craneboard init
function.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index c3851e8..3b8a53c 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -30,6 +30,7 @@
 #include "common.h"
 #include <plat/usb.h>
 
+#include "am35xx-emac.h"
 #include "mux.h"
 #include "control.h"
 
@@ -90,6 +91,7 @@ static void __init am3517_crane_init(void)
 	}
 
 	usbhs_init(&usbhs_bdata);
+	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1);
 }
 
 MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
-- 
1.7.8.5
