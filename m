From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP: ISP1301 workqueue fixes
Date: Fri, 29 Dec 2006 09:36:22 +0100
Message-ID: <4594D386.2050904@gmail.com>
References: <45937A00.1070803@gmail.com>
	<200612281205.37642.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030106010506090600050204"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200612281205.37642.david-b@pacbell.net>
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
--------------030106010506090600050204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Brownell wrote:
> On Thursday 28 December 2006 12:02 am, Dirk Behme wrote:
> 
>> static void
>>-isp1301_work(void *data)
>>+isp1301_work(struct work_struct *data)
>> {
>>-       struct isp1301  *isp = data;
>>+       struct isp1301  *isp = (struct isp1301 *)data;
>>        int             stop;
> 
> 
> Clearly incorrect.  It should use container_of().  The work_struct
> is NOT the first member of that struct... this will be oopsing.

Yes, I see. Thanks!

So, next attempt ;) Below both, ISP1301 and board-h3. Again,
only checked for compilation.

Dirk

--------------030106010506090600050204
Content-Type: text/plain;
 name="isp1301_workqueue_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isp1301_workqueue_fix.txt"

Index: linux-osk/drivers/i2c/chips/isp1301_omap.c
===================================================================
--- linux-osk.orig/drivers/i2c/chips/isp1301_omap.c
+++ linux-osk/drivers/i2c/chips/isp1301_omap.c
@@ -1119,9 +1119,9 @@ static u8 isp1301_clear_latch(struct isp
 }
 
 static void
-isp1301_work(void *data)
+isp1301_work(struct work_struct *work)
 {
-	struct isp1301	*isp = data;
+	struct isp1301	*isp = container_of(work, struct isp1301, work);
 	int		stop;
 
 	/* implicit lock:  we're the only task using this device */
@@ -1525,7 +1525,7 @@ static int isp1301_probe(struct i2c_adap
 	if (!isp)
 		return 0;
 
-	INIT_WORK(&isp->work, isp1301_work, isp);
+	INIT_WORK(&isp->work, isp1301_work);
 	init_timer(&isp->timer);
 	isp->timer.function = isp1301_timer;
 	isp->timer.data = (unsigned long) isp;




--------------030106010506090600050204
Content-Type: text/plain;
 name="board_h3_workqueue_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="board_h3_workqueue_fix.txt"

Index: linux-osk/arch/arm/mach-omap1/board-h3.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-h3.c
+++ linux-osk/arch/arm/mach-omap1/board-h3.c
@@ -296,9 +296,11 @@ static int h3_select_irda(struct device 
 	return err;
 }
 
-static void set_trans_mode(void *data)
+static void set_trans_mode(struct work_struct *work)
 {
-	int *mode = data;
+	struct omap_irda_config *irda_config =
+		container_of(work, struct omap_irda_config, gpio_expa.work);
+	int mode = irda_config->mode;
 	unsigned char expa;
 	int err = 0;
 
@@ -308,7 +310,7 @@ static void set_trans_mode(void *data)
 
 	expa &= ~0x03;
 
-	if (*mode & IR_SIRMODE) {
+	if (mode & IR_SIRMODE) {
 		expa |= 0x01;
 	} else { /* MIR/FIR */
 		expa |= 0x03;
@@ -323,9 +325,9 @@ static int h3_transceiver_mode(struct de
 {
 	struct omap_irda_config *irda_config = dev->platform_data;
 
+	irda_config->mode = mode;
 	cancel_delayed_work(&irda_config->gpio_expa);
-	PREPARE_WORK(&irda_config->gpio_expa, set_trans_mode, &mode);
-#error this is not permitted - mode is an argument variable
+	PREPARE_DELAYED_WORK(&irda_config->gpio_expa, set_trans_mode);
 	schedule_delayed_work(&irda_config->gpio_expa, 0);
 
 	return 0;
Index: linux-osk/include/asm-arm/arch-omap/irda.h
===================================================================
--- linux-osk.orig/include/asm-arm/arch-omap/irda.h
+++ linux-osk/include/asm-arm/arch-omap/irda.h
@@ -31,6 +31,7 @@ struct omap_irda_config {
 	unsigned long src_start;
 	int tx_trigger;
 	int rx_trigger;
+	int mode;
 };
 
 #endif


--------------030106010506090600050204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030106010506090600050204--
