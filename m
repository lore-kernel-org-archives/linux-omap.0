From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: U-boot 1.1.4 compilation problem
Date: Thu, 02 Mar 2006 10:06:04 +0900 (JST)
Message-ID: <20060302.100604.112629594.kaminaga@sm.sony.co.jp>
References: <20060301.175750.92583404.kaminaga@sm.sony.co.jp>
	<9212.212.62.63.198.1141227966.squirrel@webmail.verat.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="--Next_Part(Thu_Mar__2_10_06_04_2006_990)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9212.212.62.63.198.1141227966.squirrel@webmail.verat.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: chief@verat.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

----Next_Part(Thu_Mar__2_10_06_04_2006_990)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

> I have problem compiling U-boot 1.1.4.

I'm also using OMAP5912OSK and U-boot 1.1.4.

>From U-boot 1.1.3 to 1.1.4, flash implementation for OSK is moved from
board/omap5912osk/flash.c to drivers/cfi_flash.c but the header file
include/configs/omap5912osk.h is not taking this into account.

Attached is the patch I used to build u-boot-1.1.4 for osk.

Hope this helps.


Best Regards,

HK.
--
----Next_Part(Thu_Mar__2_10_06_04_2006_990)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="omap5912osk-fix-cfi-flash.patch"

Index: u-boot-1.1.4/include/configs/omap5912osk.h
===================================================================
--- u-boot-1.1.4.orig/include/configs/omap5912osk.h	2006-02-01 15:49:40.000000000 +0900
+++ u-boot-1.1.4/include/configs/omap5912osk.h	2006-02-01 16:04:59.000000000 +0900
@@ -158,6 +158,15 @@
 #define CFG_MAX_FLASH_SECT	(259)	/* max number of sectors on one chip */
 /* addr of environment */
 #define CFG_ENV_ADDR	(CFG_FLASH_BASE + 0x020000)
+#define CFG_MONITOR_BASE	CFG_FLASH_BASE	/* Monitor at beginning of flash */
+
+/*-----------------------------------------------------------------------
+ * FLASH driver setup
+ */
+#define CFG_FLASH_CFI		1	/* Flash memory is CFI compliant */
+#define CFG_FLASH_CFI_DRIVER	1	/* Use drivers/cfi_flash.c */
+#define CFG_FLASH_USE_BUFFER_WRITE	1	/* Use buffered writes (~10x faster) */
+#define CFG_FLASH_PROTECTION	1	/* Use hardware sector protection */
 
 /* timeout values are in ticks */
 #define CFG_FLASH_ERASE_TOUT	(20*CFG_HZ)	/* Timeout for Flash Erase */

----Next_Part(Thu_Mar__2_10_06_04_2006_990)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="omap5912osk-fix-undef.patch"

Index: u-boot-1.1.4/include/configs/omap5912osk.h
===================================================================
--- u-boot-1.1.4.orig/include/configs/omap5912osk.h	2005-12-17 01:39:27.000000000 +0900
+++ u-boot-1.1.4/include/configs/omap5912osk.h	2006-02-01 14:05:13.000000000 +0900
@@ -49,6 +49,7 @@
 /*
  * Size of malloc() pool
  */
+#define CFG_GBL_DATA_SIZE 128
 #define CFG_MALLOC_LEN	(CFG_ENV_SIZE + 128*1024)
 
 /*

----Next_Part(Thu_Mar__2_10_06_04_2006_990)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


----Next_Part(Thu_Mar__2_10_06_04_2006_990)----
