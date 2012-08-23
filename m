From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v3 05/23] serial: add OMAP-specific defines
Date: Thu, 23 Aug 2012 13:32:45 +0300
Message-ID: <1345717983-18179-6-git-send-email-balbi@ti.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1345717983-18179-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alan@linux.intel.com
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

OMAP has some extra Interrupt types which can
be really useful for SW. Let's define them
so we can later use those in OMAP's serial driver.

Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 include/linux/serial_reg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 8ce70d7..5ed325e 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -40,6 +40,10 @@
 
 #define UART_IIR_BUSY		0x07 /* DesignWare APB Busy Detect */
 
+#define UART_IIR_RX_TIMEOUT	0x0c /* OMAP RX Timeout interrupt */
+#define UART_IIR_XOFF		0x10 /* OMAP XOFF/Special Character */
+#define UART_IIR_CTS_RTS_DSR	0x20 /* OMAP CTS/RTS/DSR Change */
+
 #define UART_FCR	2	/* Out: FIFO Control Register */
 #define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
 #define UART_FCR_CLEAR_RCVR	0x02 /* Clear the RCVR FIFO */
-- 
1.7.12.rc3
