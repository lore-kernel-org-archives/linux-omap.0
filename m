From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH 2/6] cbus/retu-pwrbutton : Use __initdata
Date: Thu, 16 Mar 2006 00:59:21 -0800 (PST)
Message-ID: <20060316085921.65704.qmail@web32909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-685098903-1142499561=:64534"
Content-Transfer-Encoding: 8bit
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

--0-685098903-1142499561=:64534
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Move printk string to __initdata from retubutton_init()

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-685098903-1142499561=:64534
Content-Type: text/x-patch; name="cbus02.patch"
Content-Description: 1792083282-cbus02.patch
Content-Disposition: inline; filename="cbus02.patch"

diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutton.c
index da8c14c..55ac190 100644
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -69,6 +69,8 @@ static void retubutton_irq(unsigned long
 	mod_timer(&pwrbtn_timer, jiffies + msecs_to_jiffies(PWRBTN_DELAY));
 }
 
+static char banner[] __initdata = KERN_INFO "Retu power button driver initialized\n";
+
 /**
  * Init function.
  * Allocates interrupt for power button and registers itself to input layer.
@@ -77,7 +79,7 @@ static int __init retubutton_init(void)
 {
 	int irq;
 
-	printk(KERN_INFO "Retu power button driver initialized\n");
+	printk(banner);
 	irq = RETU_INT_PWR;
 
 	init_timer(&pwrbtn_timer);

--0-685098903-1142499561=:64534
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-685098903-1142499561=:64534--
