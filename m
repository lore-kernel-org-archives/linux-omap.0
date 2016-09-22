From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: edma: Rename set_bits and remove unused clear_bits helper
Date: Thu, 22 Sep 2016 09:31:04 +0300
Message-ID: <20160922063104.30106-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: arnd@arndb.de, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

The clear_bits() helper is not used by the driver so it can be removed.

powerpc architecture defines the set_bits() in
arch/powerpc/include/asm/bitops.h which results failed compile testing on
powerpc architecture:


>> drivers/dma/edma.c:415:20: error: conflicting types for 'set_bits'
    static inline void set_bits(int offset, int len, unsigned long *p)
                       ^~~~~~~~
   In file included from include/linux/bitops.h:36:0,
                    from include/linux/kernel.h:10,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:17,
                    from include/linux/dmaengine.h:20,
                    from drivers/dma/edma.c:16:
   arch/powerpc/include/asm/bitops.h:75:14: note: previous definition of 'set_bits' was here
    DEFINE_BITOP(set_bits, or, "")
                 ^
   arch/powerpc/include/asm/bitops.h:58:24: note: in definition of macro 'DEFINE_BITOP'
    static __inline__ void fn(unsigned long mask, \
                           ^~


>> drivers/dma/edma.c:421:20: error: conflicting types for 'clear_bits'
    static inline void clear_bits(int offset, int len, unsigned long *p)
                       ^~~~~~~~~~
   In file included from include/linux/bitops.h:36:0,
                    from include/linux/kernel.h:10,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:17,
                    from include/linux/dmaengine.h:20,
                    from drivers/dma/edma.c:16:
   arch/powerpc/include/asm/bitops.h:76:14: note: previous definition of 'clear_bits' was here
    DEFINE_BITOP(clear_bits, andc, "")
                 ^
   arch/powerpc/include/asm/bitops.h:58:24: note: in definition of macro 'DEFINE_BITOP'
    static __inline__ void fn(unsigned long mask, \
                           ^~

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

the eDMA/sDMA/ti-crossbar COMPILE_TEST series brought up this issue reported by
Intel kbuild test robot.

Vinod: Should I send a v4 of the COMPILE_TEST series, or is it OK if this patch
goes separately? The compile test failure should not break bisect for PPC...

Regards,
Peter

 drivers/dma/edma.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 0241f39ba64c..1f967545fb33 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -412,18 +412,12 @@ static inline void edma_param_or(struct edma_cc *ecc, int offset, int param_no,
 	edma_or(ecc, EDMA_PARM + offset + (param_no << 5), or);
 }

-static inline void set_bits(int offset, int len, unsigned long *p)
+static inline void edma_set_bits(int offset, int len, unsigned long *p)
 {
 	for (; len > 0; len--)
 		set_bit(offset + (len - 1), p);
 }

-static inline void clear_bits(int offset, int len, unsigned long *p)
-{
-	for (; len > 0; len--)
-		clear_bit(offset + (len - 1), p);
-}
-
 static void edma_assign_priority_to_queue(struct edma_cc *ecc, int queue_no,
 					  int priority)
 {
@@ -2266,7 +2260,7 @@ static int edma_probe(struct platform_device *pdev)
 			for (i = 0; rsv_slots[i][0] != -1; i++) {
 				off = rsv_slots[i][0];
 				ln = rsv_slots[i][1];
-				set_bits(off, ln, ecc->slot_inuse);
+				edma_set_bits(off, ln, ecc->slot_inuse);
 			}
 		}
 	}
--
2.10.0
