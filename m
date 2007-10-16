From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [PATCH] OMAP: Add OMAP_GPIO_SWITCH dependency for TUSB6010 on N800
Date: Tue, 16 Oct 2007 17:58:49 -0400
Message-ID: <47153419.2030609@indt.org.br>
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
selected when TUSB6010 is marked on N800 device.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 51fc13a..9323bd0 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -37,6 +37,7 @@ config MACH_NOKIA_N800
 	select CBUS if VIDEO_TCM825X
 	select CBUS_RETU if VIDEO_TCM825X
 	select MENELAUS if VIDEO_TCM825X
+	select OMAP_GPIO_SWITCH

 config MACH_OMAP2_TUSB6010
 	bool
-- 
1.5.2
