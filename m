From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 17/17] OMAP850: Fix zImage booting
Date: Wed, 14 Oct 2009 20:51:58 +0100
Message-ID: <3d374d00910141251p5fd98da6yfc43fb2ccf76d6fb@mail.gmail.com>
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

This adds the OMAP850 JTAG ID to the IDs checked by OMAP uncompress.h putc.
Without this putc hangs up trying to check the uarts and zImage crashes.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
---
 arch/arm/plat-omap/include/mach/uncompress.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/uncompress.h
b/arch/arm/plat-omap/include/mach/uncompress.h
index 0814c5f..ddf7b88 100644
--- a/arch/arm/plat-omap/include/mach/uncompress.h
+++ b/arch/arm/plat-omap/include/mach/uncompress.h
@@ -25,6 +25,7 @@ unsigned int system_rev;

 #define UART_OMAP_MDR1		0x08	/* mode definition register */
 #define OMAP_ID_730		0x355F
+#define OMAP_ID_850		0x362C
 #define ID_MASK			0x7fff
 #define check_port(base, shift) ((base[UART_OMAP_MDR1 << shift] & 7) == 0)
 #define omap_get_id() ((*(volatile unsigned int *)(0xfffed404)) >>
12) & ID_MASK
@@ -53,7 +54,7 @@ static void putc(int c)
 		/* MMU is not on, so cpu_is_omapXXXX() won't work here */
 		unsigned int omap_id = omap_get_id();

-		if (omap_id == OMAP_ID_730)
+		if (omap_id == OMAP_ID_730 || omap_id == OMAP_ID_850)
 			shift = 0;

 		if (check_port(uart, shift))
-- 
1.6.5
