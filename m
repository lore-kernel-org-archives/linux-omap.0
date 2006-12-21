From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix ethernet IRQF_TRIGGER flag for apollon
Date: Thu, 21 Dec 2006 10:43:04 +0100
Message-ID: <458A5728.2060905@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020509050903060201050907"
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
--------------020509050903060201050907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix ethernet IRQF_TRIGGER flag for apollon

As reported by Kyungmin Park, ethernet IRQF_TRIGGER flag for
apollon has to be IRQF_TRIGGER_RISING instead of
IRQF_TRIGGER_HIGH.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------020509050903060201050907
Content-Type: text/plain;
 name="appollon_ethernet_irqf_trigger_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="appollon_ethernet_irqf_trigger_fix.txt"

Index: linux-osk/drivers/net/smc91x.h
===================================================================
--- linux-osk.orig/drivers/net/smc91x.h
+++ linux-osk/drivers/net/smc91x.h
@@ -198,7 +198,7 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 				? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING)
 #else
 #define SMC_IRQ_FLAGS		(machine_is_omap_apollon()		\
-				? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW)
+				? IRQF_TRIGGER_RISING : IRQF_TRIGGER_LOW)
 #endif
 
 #elif	defined(CONFIG_SH_SH4202_MICRODEV)


--------------020509050903060201050907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020509050903060201050907--
