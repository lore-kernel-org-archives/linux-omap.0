From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [RFC patch] ARM: OMAP: Define OMAP34XX_HS_BASE
Date: Mon, 19 Nov 2007 03:42:01 +0200
Message-ID: <1195436521-10519-4-git-send-email-felipe.lima@indt.org.br>
References: <1195436521-10519-1-git-send-email-felipe.lima@indt.org.br>
	<1195436521-10519-2-git-send-email-felipe.lima@indt.org.br>
	<1195436521-10519-3-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195436521-10519-3-git-send-email-felipe.lima@indt.org.br>
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
Cc: david-b@pacbel.net
List-Id: linux-omap@vger.kernel.org

Following other omap archs, define OMAP34XX_HS_BASE macro
to be used later, for example in musb driver.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 include/asm-arm/arch-omap/omap34xx.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-arm/arch-omap/omap34xx.h b/include/asm-arm/arch-omap/omap34xx.h
index 0265e3b..1650937 100644
--- a/include/asm-arm/arch-omap/omap34xx.h
+++ b/include/asm-arm/arch-omap/omap34xx.h
@@ -71,6 +71,7 @@
 #define OMAP2_CTRL_BASE			OMAP3430_CTRL_BASE
 #define OMAP34XX_CONTROL_DEVCONF0	(L4_34XX_BASE + 0x2274)
 #define OMAP34XX_CONTROL_DEVCONF1	(L4_34XX_BASE + 0x22D8)
+#define OMAP34XX_HS_BASE		(L4_34XX_BASE + 0x65000)
 #define OMAP2_CONTROL_STATUS		(OMAP2_CTRL_BASE + 0x2f0)
 
 #endif
-- 
1.5.3.5.666.gfb5f
