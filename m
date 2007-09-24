From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 01/01] ARM: OMAP: Makes DSP compiles again for 1510 boards
Date: Mon, 24 Sep 2007 11:50:23 -0400
Message-ID: <46F7DCBF.8040706@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
Cc: ext Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

This simple patch makes DSP compiles again for 1510 boards.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 include/asm-arm/arch-omap/omap1510.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-arm/arch-omap/omap1510.h b/include/asm-arm/arch-omap/omap1510.h
index c575d35..7b5114b 100644
--- a/include/asm-arm/arch-omap/omap1510.h
+++ b/include/asm-arm/arch-omap/omap1510.h
@@ -44,5 +44,7 @@
 #define OMAP1510_DSPREG_SIZE	SZ_128K
 #define OMAP1510_DSPREG_START	0xE1000000
 
+#define OMAP1510_DSP_MMU_BASE	(0xfffed200)
+
 #endif /*  __ASM_ARCH_OMAP15XX_H */
 
-- 1.5.3.GIT
