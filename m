From: Brian Swetland <swetland@google.com>
Subject: [PATCH] mux: simplify MUX_CFG_730 and add some usb client pins
Date: Fri, 25 Nov 2005 21:18:58 -0800
Message-ID: <20051126051858.GA22303@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


As I continue to try to sort out USB gadget support on the 730, I find
that I need to add some pin definitions.  

Since the 730 lacks PU_PD registers, and the pullup bit is always in
the config register on the 730, I simplified the MUX_CFG_730() macro
a little bit (to avoid typing a bunch of 0s and NAs on *every* line).

Does this make sense?

Brian

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mux.patch"

--- linux-omap-2.6/include/asm-arm/arch-omap/mux.h	2005-11-21 10:40:39.000000000 -0800
+++ linux-omap-p2/include/asm-arm/arch-omap/mux.h	2005-11-25 21:14:05.000000000 -0800
@@ -112,14 +112,13 @@
  *   as mux config
  */
 #define MUX_CFG_730(desc, mux_reg, mode_offset, mode,	\
-		   pull_reg, pull_bit, pull_status,	\
-		   pu_pd_reg, pu_pd_status, debug_status)\
+		   pull_bit, pull_status, debug_status)\
 {							\
 	.name =	 desc,					\
 	.debug = debug_status,				\
 	MUX_REG_730(mux_reg, mode_offset, mode)		\
 	PULL_REG_730(mux_reg, pull_bit, pull_status)	\
-	PU_PD_REG(pu_pd_reg, pu_pd_status)		\
+	PU_PD_REG(NA, 0)		\
 },
 
 #define MUX_CFG_24XX(desc, reg_offset, mode,			\
@@ -172,6 +171,11 @@
 	E4_730_KBC2,
 	F4_730_KBC3,
 	E3_730_KBC4,
+    
+	/* USB */
+	AA17_730_USB_DM,
+	W16_730_USB_PU_EN,
+	W17_730_USB_VBUSI,  
 };
 
 enum omap1xxx_index {
--- linux-omap-2.6/arch/arm/mach-omap1/mux.c	2005-11-09 13:44:51.000000000 -0800
+++ linux-omap-p2/arch/arm/mach-omap1/mux.c	2005-11-25 21:03:02.000000000 -0800
@@ -35,16 +35,20 @@
 
 #ifdef CONFIG_ARCH_OMAP730
 struct pin_config __initdata_or_module omap730_pins[] = {
-MUX_CFG_730("E2_730_KBR0",	12,   21,    0,	  0,   20,   1,	  NA,	 0,  0)
-MUX_CFG_730("J7_730_KBR1",	12,   25,    0,	  0,   24,   1,	  NA,	 0,  0)
-MUX_CFG_730("E1_730_KBR2",	12,   29,    0,	  0,   28,   1,	  NA,	 0,  0)
-MUX_CFG_730("F3_730_KBR3",	13,    1,    0,	  0,   0,    1,	  NA,	 0,  0)
-MUX_CFG_730("D2_730_KBR4",	13,    5,    0,	  0,   4,    1,	  NA,	 0,  0)
-MUX_CFG_730("C2_730_KBC0",	13,    9,    0,	  0,	8,   1,	  NA,	 0,  0)
-MUX_CFG_730("D3_730_KBC1",	13,   13,    0,	  0,   12,   1,	  NA,	 0,  0)
-MUX_CFG_730("E4_730_KBC2",	13,   17,    0,	  0,   16,   1,	  NA,	 0,  0)
-MUX_CFG_730("F4_730_KBC3",	13,   21,    0,	  0,   20,   1,	  NA,	 0,  0)
-MUX_CFG_730("E3_730_KBC4",	13,   25,    0,	  0,   24,   1,	  NA,	 0,  0)
+MUX_CFG_730("E2_730_KBR0",        12,   21,    0,   20,   1, 0)
+MUX_CFG_730("J7_730_KBR1",        12,   25,    0,   24,   1, 0)
+MUX_CFG_730("E1_730_KBR2",        12,   29,    0,   28,   1, 0)
+MUX_CFG_730("F3_730_KBR3",        13,    1,    0,    0,   1, 0)
+MUX_CFG_730("D2_730_KBR4",        13,    5,    0,    4,   1, 0)
+MUX_CFG_730("C2_730_KBC0",        13,    9,    0,    8,   1, 0)
+MUX_CFG_730("D3_730_KBC1",        13,   13,    0,   12,   1, 0)
+MUX_CFG_730("E4_730_KBC2",        13,   17,    0,   16,   1, 0)
+MUX_CFG_730("F4_730_KBC3",        13,   21,    0,   20,   1, 0)
+MUX_CFG_730("E3_730_KBC4",        13,   25,    0,   24,   1, 0)
+
+MUX_CFG_730("AA17_730_USB_DM",     2,   21,    0,   20,   0, 0)
+MUX_CFG_730("W16_730_USB_PU_EN",   2,   25,    0,   24,   0, 0)
+MUX_CFG_730("W17_730_USB_VBUSI",   2,   29,    0,   28,   0, 0)
 };
 #endif
 

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--C7zPtVaVf+AK4Oqc--
