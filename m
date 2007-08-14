From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.23-rc2-omap1] remove useless/wrong P20_24XX_TSC_IRQ mux
Date: Mon, 13 Aug 2007 22:47:13 -0700
Message-ID: <200708132247.13166.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Remove bogus TSC_IRQ pinmux; it's not used, there's no pin
dedicated for touchscreen (or other TSC chip) purposes, and
this doesn't even look right for P20 (0x10b not 0x108, plus
an IRQ would need to be a GPIO i.e. mux 3 not mux 0).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- h4.orig/arch/arm/mach-omap2/mux.c	2007-08-13 12:31:32.000000000 -0700
+++ h4/arch/arm/mach-omap2/mux.c	2007-08-13 12:32:12.000000000 -0700
@@ -106,9 +106,6 @@ MUX_CFG_24XX("G4_242X_DMAREQ3",		0x073,	
 MUX_CFG_24XX("D3_242X_DMAREQ4",		0x072,	2,	0,	0,	1)
 MUX_CFG_24XX("E3_242X_DMAREQ5",		0x071,	2,	0,	0,	1)
 
-/* TSC IRQ */
-MUX_CFG_24XX("P20_24XX_TSC_IRQ",	0x108,	0,	0,	0,	1)
-
 /* UART3 */
 MUX_CFG_24XX("K15_24XX_UART3_TX",	0x118,	0,	0,	0,	1)
 MUX_CFG_24XX("K14_24XX_UART3_RX",	0x119,	0,	0,	0,	1)
--- h4.orig/include/asm-arm/arch-omap/mux.h	2007-08-13 12:31:32.000000000 -0700
+++ h4/include/asm-arm/arch-omap/mux.h	2007-08-13 12:32:12.000000000 -0700
@@ -498,8 +498,6 @@ enum omap24xx_index {
 	D3_242X_DMAREQ4,
 	E3_242X_DMAREQ5,
 
-	P20_24XX_TSC_IRQ,
-
 	/* UART3 */
 	K15_24XX_UART3_TX,
 	K14_24XX_UART3_RX,
