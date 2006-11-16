From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix Apollon and OSK ethernet IRQ flags
Date: Thu, 16 Nov 2006 17:36:53 +0100
Message-ID: <455C93A5.8010203@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040408000108070305050209"
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
--------------040408000108070305050209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix IRQ flags for Apollon and OSK (OMAP5912) board. Apollon 
fix from
Kyungmin Park (kyungmin.park_at_samsung.com):

Apollon (omap2420) use IRQF_TRIGGER_RISING which means
IRQF_TRIGGER_HIGH.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------040408000108070305050209
Content-Type: text/plain;
 name="smc_irq_flags_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smc_irq_flags_patch.txt"

Index: linux-osk/drivers/net/smc91x.h
===================================================================
--- linux-osk.orig/drivers/net/smc91x.h
+++ linux-osk/drivers/net/smc91x.h
@@ -193,10 +193,12 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 #include <asm/arch/cpu.h>
 
 #ifdef CONFIG_ARCH_OMAP1
-#define	SMC_IRQ_FLAGS	(machine_is_omap_innovator() ? IRQF_TRIGGER_RISING : \
-				IRQF_TRIGGER_FALLING)
+#define	SMC_IRQ_FLAGS	((machine_is_omap_innovator() ||  \
+                          machine_is_omap_osk())          \
+                          ? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING)
 #else
-#define SMC_IRQ_FLAGS		IRQF_TRIGGER_LOW
+#define SMC_IRQ_FLAGS	 (machine_is_omap_apollon()       \
+                          ? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW)
 #endif
 
 #elif	defined(CONFIG_SH_SH4202_MICRODEV)


--------------040408000108070305050209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040408000108070305050209--
