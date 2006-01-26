From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] Remove deprecated field and wrong commited file on apollon
Date: Thu, 26 Jan 2006 10:59:54 +0900
Message-ID: <0ITO009TKG7TVJ@mmp1.samsung.com>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

As Komal shah's mentioned, phys_ram is deprecated. so remove it.
And in previous patch, there's wrong commited file '
include/asm/arch/board-apollon.h'. It must be deleted.

Regards,
Kyungmin Park


diff --git a/arch/arm/mach-omap2/board-apollon.c
b/arch/arm/mach-omap2/board-apollon.c
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -270,7 +270,6 @@ static void __init omap_apollon_map_io(v
 
 MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
-	.phys_ram	= 0x80000000,
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
diff --git a/include/asm/arch/board-apollon.h
b/include/asm/arch/board-apollon.h
deleted file mode 100644
--- a/include/asm/arch/board-apollon.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * linux/include/asm-arm/arch-omap/board-apollon.h
- *
- * Hardware definitions for Samsung OMAP24XX Apollon board.
- *
- * Initial creation by Kyungmin Park <kyungmin.park@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef __ASM_ARCH_OMAP_APOLLON_H
-#define __ASM_ARCH_OMAP_APOLLON_H
-
-/* Placeholder for APOLLON specific defines */
-/* GPMC CS0 */
-#define APOLLON_CS0_BASE		0x00000000
-/* GPMC CS1 */
-#define APOLLON_CS1_BASE		0x08000000
-#define APOLLON_ETHR_START		(APOLLON_CS1_BASE + 0x300)
-#define APOLLON_ETHR_GPIO_IRQ		74
-/* GPMC CS2 - reserved for OneNAND */
-#define APOLLON_CS2_BASE		0x10000000
-/* GPMC CS3 - reserved for NOR or NAND */
-#define APOLLON_CS3_BASE		0x18000000
-
-#endif /*  __ASM_ARCH_OMAP_APOLLON_H */
-
