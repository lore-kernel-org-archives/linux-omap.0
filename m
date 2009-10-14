From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 01/17] OMAP7XX: Serial: Remove duplicate omap850 code
Date: Wed, 14 Oct 2009 20:50:13 +0100
Message-ID: <3d374d00910141250y6db4c880x9c0a4a84775547f@mail.gmail.com>
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
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch is part of a series which unifies all duplicated code between
omap730 and omap850. All cpu checks are converted to cpu_is_omap7xx() and
CONFIG_ARCH_OMAP850 is added to all CONFIG_ARCH_OMAP730 checks.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
Reviewed-by: Zebediah C. McClure <zmc@lurian.net>
---
 arch/arm/mach-omap1/serial.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index d496e50..49381e2 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -110,20 +110,13 @@ void __init omap_serial_init(void)
 {
 	int i;

-	if (cpu_is_omap730()) {
+	if (cpu_is_omap7xx()) {
 		serial_platform_data[0].regshift = 0;
 		serial_platform_data[1].regshift = 0;
 		serial_platform_data[0].irq = INT_730_UART_MODEM_1;
 		serial_platform_data[1].irq = INT_730_UART_MODEM_IRDA_2;
 	}

-	if (cpu_is_omap850()) {
-		serial_platform_data[0].regshift = 0;
-		serial_platform_data[1].regshift = 0;
-		serial_platform_data[0].irq = INT_850_UART_MODEM_1;
-		serial_platform_data[1].irq = INT_850_UART_MODEM_IRDA_2;
-	}
-
 	if (cpu_is_omap15xx()) {
 		serial_platform_data[0].uartclk = OMAP1510_BASE_BAUD * 16;
 		serial_platform_data[1].uartclk = OMAP1510_BASE_BAUD * 16;
-- 
1.6.5
