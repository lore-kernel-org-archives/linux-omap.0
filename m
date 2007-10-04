From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [PATCH] MMC: OMAP: Add OMAP_GPIO_SWITCH dependency for TUSB6010
Date: Thu, 04 Oct 2007 17:10:03 -0400
Message-ID: <470556AB.6030201@indt.org.br>
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
To: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

GPIO switch is needed for TUSB6010 code. It must be
selected when TUSB6010 is marked.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0d9f496..dcb4824 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -41,6 +41,7 @@ config MACH_NOKIA_N800
 config MACH_OMAP2_TUSB6010
 	bool
 	depends on ARCH_OMAP2 && ARCH_OMAP2420
+	select OMAP_GPIO_SWITCH
 	default y if MACH_NOKIA_N800

 config MACH_OMAP_H4
-- 
1.5.2
