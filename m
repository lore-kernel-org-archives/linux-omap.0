From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP2: Fix H4 keypad
Date: Fri, 24 Mar 2006 05:49:45 -0800 (PST)
Message-ID: <20060324134945.59695.qmail@web32910.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-943956032-1143208185=:54891"
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

--0-943956032-1143208185=:54891
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Should be applied after keypad mutex patch. 

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-943956032-1143208185=:54891
Content-Type: text/plain;
	name="0010-OMAP-Keypad-Fix-keypad-on-H4-where-we-don-t-have.txt"
Content-Description: 1279931948-0010-OMAP-Keypad-Fix-keypad-on-H4-where-we-don-t-have.txt
Content-Disposition: inline;
	filename="0010-OMAP-Keypad-Fix-keypad-on-H4-where-we-don-t-have.txt"

Subject: [PATCH] OMAP: Keypad: Fix keypad on H4, where we don't have

	      interrupt resource.
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/input/keyboard/omap-keypad.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

3b89aaaa3afa8bc32b02a891b7268a7d08451495
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index ff1acb5..f860dba 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -56,7 +56,7 @@ static int kp_cur_group = -1;
 struct omap_kp {
 	struct input_dev *input;
 	struct timer_list timer;
-	unsigned int irq;
+	int irq;
 	unsigned int rows;
 	unsigned int cols;
 };
@@ -358,7 +358,7 @@ static int __init omap_kp_probe(struct p
 	kp_tasklet.data = (unsigned long) omap_kp;
 
 	omap_kp->irq = platform_get_irq(pdev, 0);
-	if (omap_kp->irq) {
+	if (omap_kp->irq >= 0) {
 		if (request_irq(omap_kp->irq, omap_kp_interrupt, 0,
 				"omap-keypad", omap_kp) < 0)
 			return -EINVAL;
@@ -386,7 +386,7 @@ static int __init omap_kp_probe(struct p
 	} else {
 		for (i = 0; i < omap_kp->rows; i++) {
 			if (request_irq(OMAP_GPIO_IRQ(row_gpios[i]), omap_kp_interrupt,
-					SA_TRIGGER_FALLING, "omap-keypad", omap_kp) < 0)
+					SA_TRIGGER_FALLING, "omap-keypad", omap_kp) < 0) 
 				return -EINVAL;
 		}
 	}
-- 
1.1.6

--0-943956032-1143208185=:54891
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-943956032-1143208185=:54891--
