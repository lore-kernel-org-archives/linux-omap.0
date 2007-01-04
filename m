From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Make board-palmz71 compile again
Date: Thu, 04 Jan 2007 19:06:53 +0100
Message-ID: <459D423D.2040109@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030200070600080208060805"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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

This is a multi-part message in MIME format.
--------------030200070600080208060805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix compilation issues in board-palmz71.c

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------030200070600080208060805
Content-Type: text/plain;
 name="board_palmz71_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="board_palmz71_fix.txt"

Index: linux-osk/arch/arm/mach-omap1/board-palmz71.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-palmz71.c
+++ linux-osk/arch/arm/mach-omap1/board-palmz71.c
@@ -260,7 +260,6 @@ static struct spi_board_info __initdata 
 				* 26	/* command + data + overhead */,
 	.bus_num	= 2,
 	.chip_select	= 0,
-	}
 } };
 
 static struct omap_usb_config palmz71_usb_config __initdata = {
@@ -295,7 +294,7 @@ static struct omap_board_config_kernel p
 };
 
 static irqreturn_t
-palmz71_powercable(int irq, void *dev_id, struct pt_regs *regs)
+palmz71_powercable(int irq, void *dev_id)
 {
 	if (omap_get_gpio_datain(PALMZ71_USBDETECT_GPIO)) {
 		printk(KERN_INFO "PM: Power cable connected\n");
@@ -347,7 +346,7 @@ palmz71_gpio_setup(int early)
 				"palmz71-cable", 0))
 			printk(KERN_ERR
 			       "IRQ request for power cable failed!\n");
-		palmz71_powercable(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO), 0, 0);
+		palmz71_powercable(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO), 0);
 	}
 }
 



--------------030200070600080208060805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030200070600080208060805--
