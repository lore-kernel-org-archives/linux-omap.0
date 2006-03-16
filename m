From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] Fix omap-rtc
Date: Thu, 16 Mar 2006 16:41:13 +0100
Message-ID: <44198719.3090308@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030206030601030900010003"
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

This is a multi-part message in MIME format.
--------------030206030601030900010003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix omap-rtc:

drivers/char/omap-rtc.c:125: error: static declaration of
'rtc_interrupt' follows non-static declaration
include/linux/rtc.h:107: error: previous declaration of
'rtc_interrupt' was here

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------030206030601030900010003
Content-Type: text/plain;
 name="rtc_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtc_patch.txt"

--- ./drivers/char/omap-rtc.c_orig	2006-03-16 16:33:23.000000000 +0100
+++ ./drivers/char/omap-rtc.c	2006-03-16 16:39:37.000000000 +0100
@@ -121,7 +121,7 @@ static const unsigned char days_in_mo[] 
  *	A very tiny interrupt handler. It runs with SA_INTERRUPT set.
  */
 
-static irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	/*
 	 *	Either an alarm interrupt or update complete interrupt.


--------------030206030601030900010003
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030206030601030900010003--
