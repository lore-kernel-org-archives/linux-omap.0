From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 9/11] Board 3430 SDP header file
Date: Tue, 29 May 2007 01:22:39 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47FF0E35@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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


New header file for Board 3430 SDP related definitions.

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files Changed:
 board-3430sdp.h |   72 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/include/asm-arm/arch-omap/board-3430sdp.h =
val_3430_GIT/include/asm-arm/arch-omap/board-3430sdp.h
--- linux-omap/include/asm-arm/arch-omap/board-3430sdp.h	1969-12-31 =
18:00:00.000000000 -0600
+++ val_3430_GIT/include/asm-arm/arch-omap/board-3430sdp.h	2007-05-28 =
21:52:49.000000000 -0500
@@ -0,0 +1,72 @@
+/*
+ * linux/include/asm-arm/arch-omap/board-3430sdp.h
+ *
+ * Hardware definitions for TI OMAP3430 SDP board.
+ *
+ * Initial creation by Syed Mohammed Khasim
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms of the GNU General Public License as published by =
the
+ * Free Software Foundation; either version 2 of the License, or (at =
your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. =
IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, =
BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND =
ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR =
TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License =
along
+ * with this program; if not, write to the Free Software Foundation, =
Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_ARCH_OMAP_3430SDP_H
+#define __ASM_ARCH_OMAP_3430SDP_H
+
+#define DEBUG_BASE			0x08000000  /* debug board */
+/* Placeholder for 3430SDP specific defines */
+
+#define OMAP34XX_ETHR_START		DEBUG_BASE
+#define OMAP34XX_ETHR_GPIO_IRQ		29
+
+/* NAND */
+/* IMPORTANT NOTE ON MAPPING
+ * 3430SDP - 343X
+ * ----------
+ * NOR always on  0x04000000
+ * MPDB always on 0x08000000
+ * NAND always on 0x0C000000
+ * OneNand Mapped to 0x20000000
+ * Boot Mode(NAND/NOR). The other on CS1
+ */
+#define FLASH_BASE	0x04000000  /* NOR flash (64 Meg aligned) */
+#define DEBUG_BASE	0x08000000  /* debug board */
+#define NAND_BASE	0x0C000000  /* NAND flash */
+#define ONENAND_MAP	0x20000000  /* OneNand flash */
+
+#ifdef CONFIG_I2C_TWL4030_CORE
+
+#define TWL4030_IRQNUM INT_34XX_SYS_NIRQ
+
+/* TWL4030 Primary Interrupt Handler (PIH) interrupts */
+#define	IH_TWL4030_BASE		IH_BOARD_BASE
+#define	IH_TWL4030_END		(IH_TWL4030_BASE+8)
+
+#ifdef CONFIG_I2C_TWL4030_GPIO
+
+/* TWL4030 GPIO Interrupts */
+#define IH_TWL4030_GPIO_BASE	(IH_TWL4030_END)
+#define IH_TWL4030_GPIO_END	(IH_TWL4030_BASE+18)
+#define NR_IRQS			(IH_TWL4030_GPIO_END)
+#else
+#define NR_IRQS			(IH_TWL4030_END)
+#endif /* CONFIG_I2C_TWL4030_GPIO */
+#endif /* End of support for TWL4030 */
+#endif /*  __ASM_ARCH_OMAP_3430SDP_H */
+
