From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] Update sample random irq flag
Date: Sat, 18 Feb 2006 09:19:24 +0100
Message-ID: <43F6D88C.6000804@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030100060101090409010700"
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
--------------030100060101090409010700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by reloaded.ext.ti.com id k1I8JiCZ002058


ARM: OMAP: Update usage of SA_SAMPLE_RANDOM flag as proposed
by Juha Yrj=F6l=E4.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>



--------------030100060101090409010700
Content-Type: text/plain;
 name="sample_random_patch.txt"
Content-Disposition: inline;
 filename="sample_random_patch.txt"
Content-Transfer-Encoding: 7bit

--- ./drivers/i2c/chips/isp1301_omap.c_orig	2006-02-18 07:44:36.000000000 +0100
+++ ./drivers/i2c/chips/isp1301_omap.c	2006-02-18 09:00:41.000000000 +0100
@@ -1527,7 +1527,7 @@ static int isp1301_probe(struct i2c_adap
 	isp->timer.data = (unsigned long) isp;
 
 	isp->irq = -1;
-	isp->irq_type = SA_SAMPLE_RANDOM;
+	isp->irq_type = 0;
 	isp->client.addr = address;
 	i2c_set_clientdata(&isp->client, isp);
 	isp->client.adapter = bus;
--- ./drivers/i2c/chips/tps65010.c_orig	2006-02-18 07:44:36.000000000 +0100
+++ ./drivers/i2c/chips/tps65010.c	2006-02-18 09:00:41.000000000 +0100
@@ -527,7 +527,7 @@ fail1:
 		return 0;
 	}
 
-	tps->irq_type = SA_SAMPLE_RANDOM;
+	tps->irq_type = 0;
 
 #ifdef	CONFIG_ARM
 	if (machine_is_omap_h2()) {
--- ./drivers/input/touchscreen/omap/omap_ts.c_orig	2006-02-18 07:44:40.000000000 +0100
+++ ./drivers/input/touchscreen/omap/omap_ts.c	2006-02-18 09:00:41.000000000 +0100
@@ -162,7 +162,8 @@ static int __init omap_ts_probe(struct p
 
 	/* request irq */
 	if (ts_omap.irq != -1) {
-		if (request_irq(ts_omap.irq, omap_ts_handler, ts_omap.irq_type,
+		if (request_irq(ts_omap.irq, omap_ts_handler,
+                                SA_SAMPLE_RANDOM | ts_omap.irq_type,
 				OMAP_TS_NAME, &ts_omap)) {
 			printk(KERN_ERR
 	  "omap_ts.c: Could not allocate touchscreen IRQ!\n");
--- ./drivers/input/touchscreen/omap/ts_inn1510.c_orig	2006-02-18 07:44:40.000000000 +0100
+++ ./drivers/input/touchscreen/omap/ts_inn1510.c	2006-02-18 09:09:31.000000000 +0100
@@ -176,7 +176,7 @@ static int __init inn1510_ts_probe(struc
 		return -ENODEV;
 
 	ts->irq = OMAP1510_INT_FPGA_TS;
-	ts->irq_type = SA_SAMPLE_RANDOM;
+	ts->irq_type = 0;
 	
 	return 0;
 }


--------------030100060101090409010700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--------------030100060101090409010700--
