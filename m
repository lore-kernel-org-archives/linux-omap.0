From: imre.deak@solidboot.com
Subject: [PATCH 4/4] Input: ads7846: leave Vref on during differential
	measurements optionally
Date: Mon, 3 Jul 2006 21:40:10 +0300
Message-ID: <20060703184010.GD29921@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: david-b@pacbell.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On some LCDs leaving the Vref on provides much better readings.

Signed-off-by: Jarkko Oikarinen <jarkko.oikarinen@nokia.com>
Signed-off-by: Imre Deak <imre.deak@solidboot.com>

---

 drivers/input/touchscreen/ads7846.c |   32 ++++++++++++++++++--------------
 include/linux/spi/ads7846.h         |    2 ++
 2 files changed, 20 insertions(+), 14 deletions(-)

014d2a8279a8841d58139ed58224ab1fe4cf6f75
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 2e5c5a6..cf4ae0a 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -147,15 +147,16 @@ struct ads7846 {
 #define	MAX_12BIT	((1<<12)-1)
 
 /* leave ADC powered up (disables penirq) between differential samples */
-#define	READ_12BIT_DFR(x) (ADS_START | ADS_A2A1A0_d_ ## x \
-	| ADS_12_BIT | ADS_DFR)
+#define	READ_12BIT_DFR(x, adc, vref) (ADS_START | ADS_A2A1A0_d_ ## x \
+	| ADS_12_BIT | ADS_DFR | \
+	(adc ? ADS_PD10_ADC_ON : 0) | (vref ? ADS_PD10_REF_ON : 0))
+
+#define	READ_Y(vref)	(READ_12BIT_DFR(y,  1, vref))
+#define	READ_Z1(vref)	(READ_12BIT_DFR(z1, 1, vref))
+#define	READ_Z2(vref)	(READ_12BIT_DFR(z2, 1, vref))
 
-#define	READ_Y	(READ_12BIT_DFR(y)  | ADS_PD10_ADC_ON)
-#define	READ_Z1	(READ_12BIT_DFR(z1) | ADS_PD10_ADC_ON)
-#define	READ_Z2	(READ_12BIT_DFR(z2) | ADS_PD10_ADC_ON)
-
-#define	READ_X	(READ_12BIT_DFR(x)  | ADS_PD10_ADC_ON)
-#define	PWRDOWN	(READ_12BIT_DFR(y)  | ADS_PD10_PDOWN)	/* LAST */
+#define	READ_X(vref)	(READ_12BIT_DFR(x,  1, vref))
+#define	PWRDOWN		(READ_12BIT_DFR(y,  0, 0))	/* LAST */
 
 /* single-ended samples need to first power up reference voltage;
  * we leave both ADC and VREF powered
@@ -163,8 +164,8 @@ struct ads7846 {
 #define	READ_12BIT_SER(x) (ADS_START | ADS_A2A1A0_ ## x \
 	| ADS_12_BIT | ADS_SER)
 
-#define	REF_ON	(READ_12BIT_DFR(x) | ADS_PD10_ALL_ON)
-#define	REF_OFF	(READ_12BIT_DFR(y) | ADS_PD10_PDOWN)
+#define	REF_ON	(READ_12BIT_DFR(x, 1, 1))
+#define	REF_OFF	(READ_12BIT_DFR(y, 0, 0))
 
 /*--------------------------------------------------------------------------*/
 
@@ -695,6 +696,7 @@ static int __devinit ads7846_probe(struc
 	struct ads7846_platform_data	*pdata = spi->dev.platform_data;
 	struct spi_message		*m;
 	struct spi_transfer		*x;
+	int				vref;
 	int				err;
 
 	if (!spi->irq) {
@@ -794,6 +796,8 @@ static int __devinit ads7846_probe(struc
 	input_set_abs_params(input_dev, ABS_PRESSURE,
 			pdata->pressure_min, pdata->pressure_max, 0, 0);
 
+	vref = pdata->keep_vref_on;
+
 	/* set up the transfers to read touchscreen state; this assumes we
 	 * use formula #2 for pressure, not #3.
 	 */
@@ -803,7 +807,7 @@ static int __devinit ads7846_probe(struc
 	spi_message_init(m);
 
 	/* y- still on; turn on only y+ (and ADC) */
-	ts->read_y = READ_Y;
+	ts->read_y = READ_Y(vref);
 	x->tx_buf = &ts->read_y;
 	x->len = 1;
 	spi_message_add_tail(x, m);
@@ -821,7 +825,7 @@ static int __devinit ads7846_probe(struc
 
 	/* turn y- off, x+ on, then leave in lowpower */
 	x++;
-	ts->read_x = READ_X;
+	ts->read_x = READ_X(vref);
 	x->tx_buf = &ts->read_x;
 	x->len = 1;
 	spi_message_add_tail(x, m);
@@ -840,7 +844,7 @@ static int __devinit ads7846_probe(struc
 		spi_message_init(m);
 
 		x++;
-		ts->read_z1 = READ_Z1;
+		ts->read_z1 = READ_Z1(vref);
 		x->tx_buf = &ts->read_z1;
 		x->len = 1;
 		spi_message_add_tail(x, m);
@@ -857,7 +861,7 @@ static int __devinit ads7846_probe(struc
 		spi_message_init(m);
 
 		x++;
-		ts->read_z2 = READ_Z2;
+		ts->read_z2 = READ_Z2(vref);
 		x->tx_buf = &ts->read_z2;
 		x->len = 1;
 		spi_message_add_tail(x, m);
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index 1663f94..c371475 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -14,6 +14,8 @@ enum ads7846_filter {
 struct ads7846_platform_data {
 	u16	model;			/* 7843, 7845, 7846. */
 	u16	vref_delay_usecs;	/* 0 for external vref; etc */
+	int	keep_vref_on : 1;	/* set to keep vref on for differential
+					 * measurements as well */
 	u16	x_plate_ohms;
 	u16	y_plate_ohms;
 
-- 
1.2.3.g90cc1-dirty
