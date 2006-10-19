From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning no IRQF_TRIGGER set_type function
 for IRQ 353
Date: Thu, 19 Oct 2006 18:10:18 +0200
Message-ID: <4537A36A.9020004@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090600040505090403060503"
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
--------------090600040505090403060503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix bootmessage warning

No IRQF_TRIGGER set_type function for IRQ 353 (MPUIO)

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>




--------------090600040505090403060503
Content-Type: text/plain;
 name="mpuio_irq_set_type_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpuio_irq_set_type_patch.txt"

Index: linux-osk/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/gpio.c
+++ linux-osk/arch/arm/plat-omap/gpio.c
@@ -1019,10 +1019,11 @@ static struct irq_chip gpio_irq_chip = {
 };
 
 static struct irq_chip mpuio_irq_chip = {
-	.name	= "MPUIO",
-	.ack	= mpuio_ack_irq,
-	.mask	= mpuio_mask_irq,
-	.unmask	= mpuio_unmask_irq
+	.name	  = "MPUIO",
+	.ack	  = mpuio_ack_irq,
+	.mask	  = mpuio_mask_irq,
+	.unmask	  = mpuio_unmask_irq,
+	.set_type = gpio_irq_type,
 };
 
 static int initialized;


--------------090600040505090403060503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090600040505090403060503--
