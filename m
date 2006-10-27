From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Remove struct pt_regs from menelaus_irq()
Date: Fri, 27 Oct 2006 18:56:20 +0200
Message-ID: <45423A34.1010009@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000901050207090503080809"
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
--------------000901050207090503080809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Remove struct pt_regs from menelaus_irq()

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------000901050207090503080809
Content-Type: text/plain;
 name="menelaus_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="menelaus_warning_patch.txt"

Index: linux-osk/drivers/i2c/chips/menelaus.c
===================================================================
--- linux-osk.orig/drivers/i2c/chips/menelaus.c
+++ linux-osk/drivers/i2c/chips/menelaus.c
@@ -678,7 +678,7 @@ static void menelaus_work(void * _menela
 /*
  * We cannot use I2C in interrupt context, so we just schedule work.
  */
-static irqreturn_t menelaus_irq(int irq, void *_menelaus, struct pt_regs *regs)
+static irqreturn_t menelaus_irq(int irq, void *_menelaus)
 {
 	struct menelaus_chip *menelaus = _menelaus;
 



--------------000901050207090503080809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000901050207090503080809--
