From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: [PATCH][RFC] update flash timing on OMAP5912OSK
Date: Mon, 20 Feb 2006 13:21:45 +0900 (JST)
Message-ID: <20060220.132145.74756047.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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

Hi,

In linux-2.6.15-omap1 patch, in arch/arm/mach-omap1/board-osk.c,
EMIFS_CS3_VAL is set to 0x30003361.

This was introduced to fix flash timing error.
http://linux.omap.com/pipermail/linux-omap-open-source/2005-July/004717.html

On the other hand, in SectionE:Errata in EMIFS timing at:
http://omap.spectrumdigital.com/osk5912/osk5912_faq.html
EMIFS_CS3_VAL was set to 0x88013141, fixing write/read rate.

Reading from
http://focus.ti.com/lit/ug/spru742/spru742.pdf
3.6 EMIFS Registers,

0x30003361 will set read mode from "page mode, 4 word/page" to 
"asynchronous read", and read from flash slowed down.

I tested with new value 0x88013141, and works good so far.

Here is a patch against 2.6.15-omap1 patch.

Best Regards,


HK.
--

Index: linux-2.6.15/arch/arm/mach-omap1/board-osk.c
===================================================================
--- linux-2.6.15.orig/arch/arm/mach-omap1/board-osk.c	2006-01-27 17:56:55.000000000 +0900
+++ linux-2.6.15/arch/arm/mach-omap1/board-osk.c	2006-02-20 14:06:52.000000000 +0900
@@ -262,7 +262,7 @@
 	while (1) ;
 }
 
-#define EMIFS_CS3_VAL	(0x30003361)
+#define EMIFS_CS3_VAL	(0x88013141)
 
 static void __init osk_init(void)
 {
