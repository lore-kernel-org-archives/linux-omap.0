From: Mark Howell <mhowell@northlink.com>
Subject: [PATCH] ARM: OMAP: mux: add config for 16xx SPI pins
Date: Wed, 26 Jul 2006 14:03:40 -0700
Message-ID: <44C7D8AC.7070505@northlink.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch adds pin mux info for the SPI master/slave interface on 
OMAP16xx. Data from OMAP 1611/1612 TRM and errata. Works for me on my 
1611/H2 with current git kernel.

Signed-off-by: Mark Howell <mhowell@northlink.com>

-----

diff -ruNp -X linux-omap/Documentation/dontdiff linux-omap/arch/arm/mach-omap1/mux.c dev-linux-omap/arch/arm/mach-omap1/mux.c
--- linux-omap/arch/arm/mach-omap1/mux.c	2006-07-26 13:16:11.000000000 -0700
+++ dev-linux-omap/arch/arm/mach-omap1/mux.c	2006-07-26 13:26:58.000000000 -0700
@@ -200,6 +200,17 @@ MUX_CFG("N14_1610_UWIRE_CS0",	 8,    9, 
 MUX_CFG("P15_1610_UWIRE_CS3",	 8,   12,    1,	  1,  22,   0,	  1,	 1,  1)
 MUX_CFG("N15_1610_UWIRE_CS1",	 7,   18,    2,	  1,  14,   0,	 NA,	 0,  1)
 
+/* OMAP-1610 SPI */
+MUX_CFG("U19_1610_SPIF_SCK",	 7,    21,   6,	  1,  15,   0,	  1,	 1,  1)
+MUX_CFG("U18_1610_SPIF_DIN",	 8,    0,    6,	  1,  18,   1,	  1,	 0,  1)
+MUX_CFG("P20_1610_SPIF_DIN",	 6,    27,   4,   1,   7,   1,    1,     0,  1)
+MUX_CFG("W21_1610_SPIF_DOUT",	 8,    3,    6,	  1,  19,   0,	  1,	 0,  1)
+MUX_CFG("R18_1610_SPIF_DOUT",	 7,    9,    3,	  1,  11,   0,	  1,	 0,  1)
+MUX_CFG("N14_1610_SPIF_CS0",	 8,    9,    6,	  1,  21,   0,	  1,	 1,  1)
+MUX_CFG("N15_1610_SPIF_CS1",	 7,    18,   6,	  1,  14,   0,	  1,	 1,  1)
+MUX_CFG("T19_1610_SPIF_CS2",	 7,    15,   4,	  1,  13,   0,	  1,	 1,  1)
+MUX_CFG("P15_1610_SPIF_CS3",	 8,    12,   3,	  1,  22,   0,	  1,	 1,  1)
+
 /* OMAP-1610 Flash */
 MUX_CFG("L3_1610_FLASH_CS2B_OE",10,    6,    1,	 NA,   0,   0,	 NA,	 0,  1)
 MUX_CFG("M8_1610_FLASH_CS2B_WE",10,    3,    1,	 NA,   0,   0,	 NA,	 0,  1)
diff -ruNp -X linux-omap/Documentation/dontdiff linux-omap/include/asm-arm/arch-omap/mux.h dev-linux-omap/include/asm-arm/arch-omap/mux.h
--- linux-omap/include/asm-arm/arch-omap/mux.h	2006-07-26 13:16:15.000000000 -0700
+++ dev-linux-omap/include/asm-arm/arch-omap/mux.h	2006-07-26 13:20:22.000000000 -0700
@@ -320,6 +320,17 @@ enum omap1xxx_index {
 	P15_1610_UWIRE_CS3,
 	N15_1610_UWIRE_CS1,
 
+	/* OMAP-1610 SPI */
+	U19_1610_SPIF_SCK,
+	U18_1610_SPIF_DIN,
+	P20_1610_SPIF_DIN,
+	W21_1610_SPIF_DOUT,
+	R18_1610_SPIF_DOUT,
+	N14_1610_SPIF_CS0,
+	N15_1610_SPIF_CS1,
+	T19_1610_SPIF_CS2,
+	P15_1610_SPIF_CS3,
+
 	/* OMAP-1610 Flash */
 	L3_1610_FLASH_CS2B_OE,
 	M8_1610_FLASH_CS2B_WE,
