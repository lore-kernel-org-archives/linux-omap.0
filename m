From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Remove struct pt_regs from lcdc_irq_handler()
Date: Fri, 27 Oct 2006 18:53:39 +0200
Message-ID: <45423993.5080300@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050606040203040802070607"
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
--------------050606040203040802070607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Remove struct pt_regs from lcdc_irq_handler()

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>



--------------050606040203040802070607
Content-Type: text/plain;
 name="lcdc_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lcdc_warning_patch.txt"

Index: linux-osk/drivers/video/omap/lcdc.c
===================================================================
--- linux-osk.orig/drivers/video/omap/lcdc.c
+++ linux-osk/drivers/video/omap/lcdc.c
@@ -265,7 +265,7 @@ static void setup_lcd_dma(void)
 	omap_setup_lcd_dma();
 }
 
-static irqreturn_t lcdc_irq_handler(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t lcdc_irq_handler(int irq, void *dev_id)
 {
 	u32 status;
 


--------------050606040203040802070607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050606040203040802070607--
