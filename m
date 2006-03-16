From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH 4/6] cbus/retu-user.c : kmalloc + memset(0) to kzalloc
Date: Thu, 16 Mar 2006 01:06:20 -0800 (PST)
Message-ID: <20060316090620.22626.qmail@web32912.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-221867910-1142499980=:20662"
Content-Transfer-Encoding: 8bit
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

--0-221867910-1142499980=:20662
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

kmalloc + memset(0) to kzalloc conversion

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-221867910-1142499980=:20662
Content-Type: text/x-patch; name="cbus04.patch"
Content-Description: 3774021817-cbus04.patch
Content-Disposition: inline; filename="cbus04.patch"

diff --git a/drivers/cbus/retu-user.c b/drivers/cbus/retu-user.c
index 69d1be9..9454760 100644
--- a/drivers/cbus/retu-user.c
+++ b/drivers/cbus/retu-user.c
@@ -372,12 +372,11 @@ int retu_user_init(void)
 	struct retu_irq *irq;
 	int res, i;
 
-	irq = kmalloc(sizeof(*irq) * RETU_MAX_IRQ_BUF_LEN, GFP_KERNEL);
+	irq = kzalloc(sizeof(*irq) * RETU_MAX_IRQ_BUF_LEN, GFP_KERNEL);
 	if (irq == NULL) {
-		printk(KERN_ERR PFX "kmalloc failed\n");
+		printk(KERN_ERR PFX "kzalloc failed\n");
 		return -ENOMEM;
 	}
-	memset(irq, 0, sizeof(*irq) * RETU_MAX_IRQ_BUF_LEN);
 	for (i = 0; i < RETU_MAX_IRQ_BUF_LEN; i++)
 		list_add(&irq[i].node, &retu_irqs_reserve);
 

--0-221867910-1142499980=:20662
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-221867910-1142499980=:20662--
