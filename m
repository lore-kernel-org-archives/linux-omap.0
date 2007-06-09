From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: [PATCH 5/12] Add OMAP850 identification.
Date: Sat, 09 Jun 2007 19:25:13 +0200
Message-ID: <466AE279.7060900@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Add signature for the OMAP850 CPU of the HTC Tornado.

Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>

---
 arch/arm/mach-omap1/id.c        |    1 +
 include/asm-arm/arch-omap/cpu.h |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index da13c3e..63f604a 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -36,6 +36,7 @@ static struct omap_id omap_ids[] __initdata = {
     { .jtag_id = 0xb574, .die_rev = 0x2, .omap_id = 0x03310315, .type = 
0x03100000},
     { .jtag_id = 0x355f, .die_rev = 0x0, .omap_id = 0x03320000, .type = 
0x07300100},
     { .jtag_id = 0xb55f, .die_rev = 0x0, .omap_id = 0x03320000, .type = 
0x07300300},
+    { .jtag_id = 0xb62c, .die_rev = 0x0, .omap_id = 0x03320500, .type = 
0x07500100},
     { .jtag_id = 0xb470, .die_rev = 0x0, .omap_id = 0x03310100, .type = 
0x15100000},
     { .jtag_id = 0xb576, .die_rev = 0x0, .omap_id = 0x03320000, .type = 
0x16100000},
     { .jtag_id = 0xb576, .die_rev = 0x2, .omap_id = 0x03320100, .type = 
0x16110000},
diff --git a/include/asm-arm/arch-omap/cpu.h 
b/include/asm-arm/arch-omap/cpu.h
index ec7eb67..057a865 100644
--- a/include/asm-arm/arch-omap/cpu.h
+++ b/include/asm-arm/arch-omap/cpu.h
@@ -245,7 +245,7 @@ IS_OMAP_TYPE(2430, 0x2430)
 #endif
 
 /* Macros to detect if we have OMAP1 or OMAP2 */
-#define cpu_class_is_omap1()    (cpu_is_omap730() || cpu_is_omap15xx() || \
+#define cpu_class_is_omap1()    (cpu_is_omap7xx() || cpu_is_omap15xx() || \
                 cpu_is_omap16xx())
 #define cpu_class_is_omap2()    cpu_is_omap24xx()
 
-- 
1.5.1.3
