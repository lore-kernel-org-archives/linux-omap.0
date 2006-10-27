From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Remove struct pt_regs from omap_irda_irq()
Date: Fri, 27 Oct 2006 18:51:05 +0200
Message-ID: <454238F9.1060202@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070604000507030805050406"
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
--------------070604000507030805050406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Remove struct pt_regs from omap_irda_irq()

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>



--------------070604000507030805050406
Content-Type: text/plain;
 name="irda_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irda_warning_patch.txt"

Index: linux-osk/drivers/net/irda/omap-ir.c
===================================================================
--- linux-osk.orig/drivers/net/irda/omap-ir.c
+++ linux-osk/drivers/net/irda/omap-ir.c
@@ -325,7 +325,7 @@ static int omap_irda_shutdown(struct oma
 }
 
 static irqreturn_t
-omap_irda_irq(int irq, void *dev_id, struct pt_regs *hw_regs)
+omap_irda_irq(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct omap_irda *omap_ir = netdev_priv(dev);


--------------070604000507030805050406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070604000507030805050406--
