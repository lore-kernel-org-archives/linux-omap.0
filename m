From: Felipe Balbi <felipebalbi@users.sourceforge.net>
Subject: [PATCH] Leave GPIO[7:6] pullups enabled.
Date: Tue, 29 May 2007 15:02:40 +0300
Message-ID: <11804401782736-git-send-email-felipebalbi@users.sourceforge.net>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401651954-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401662563-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401722783-git-send-email-felipebalbi@users.sourceforge.net>
	<1180440173922-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401741522-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401752426-git-send-email-felipebalbi@users.sourceforge.net>
	<1180440176127-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401773555-git-send-email-felipebalbi@users.sourceforge.net>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11804401773555-git-send-email-felipebalbi@users.sourceforge.net>
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

From: Felipe Balbi <felipe.lima@indt.org.br>

GPIO7 and GPIO6 are configured as default wake-up sources for
tusb6010.

without this patch MUSB is not able to enumerate
any device that draw power from it.

After applying this patch, we're passing in almost
all OTG Electrical Tests.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---

Index: linux-omap-2.6/drivers/usb/musb/tusb6010.c
===================================================================
--- linux-omap-2.6.orig/drivers/usb/musb/tusb6010.c	2007-05-28 13:18:46.000000000 +0300
+++ linux-omap-2.6/drivers/usb/musb/tusb6010.c	2007-05-28 13:26:28.000000000 +0300
@@ -879,8 +879,11 @@
 {
 	void __iomem	*base = musb->ctrl_base;
 
-	/* Disable GPIO[7:0] pullups (used as output DMA requests) */
-	musb_writel(base, TUSB_PULLUP_1_CTRL, 0x000000FF);
+	/* GPIO[7:6] are the default wake-up sources for tusb6010.
+	 * We cannot disable their pullups.
+	 *
+	 * Disable GPIO[5:0] pullups (used as output DMA requests) */
+	musb_writel(base, TUSB_PULLUP_1_CTRL, 0x0000003F);
 	/* Disable all pullups on NOR IF, DMAREQ0 and DMAREQ1 */
 	musb_writel(base, TUSB_PULLUP_2_CTRL, 0x01FFFFFF);
 
