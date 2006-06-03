From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH] input: ads7846: can't disable filtering [was OMAP5912
 touchscreen irq not working]
Date: Sat, 03 Jun 2006 21:41:34 +0300
Message-ID: <4481D7DE.2090904@nokia.com>
References: <4477F2BA.3080907@gmail.com> <44793CF9.2050101@nokia.com>	
	<447DB9CC.2070808@gmail.com>
	<200605310905.31864.david-b@pacbell.net>
	<1149093991.31999.66.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000709080403090809050608"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1149093991.31999.66.camel@mammoth.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000709080403090809050608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

[ Didn't try on OSK, but seems to be the problem you had there. ]

When filtering is disabled the driver will ignore all samples and
never detect the pen up event.

Signed-off-by: Imre Deak <imre.deak@nokia.com>

--------------000709080403090809050608
Content-Type: text/plain;
 name="ads7846-no_filter-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ads7846-no_filter-patch.diff"

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4369845..2d8ea07 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -472,7 +474,8 @@ static void ads7846_debounce(void *ads)
 	m = &ts->msg[ts->msg_idx];
 	t = list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
 	val = (be16_to_cpu(*(__be16 *)t->rx_buf) >> 3) & 0x0fff;
-	if (!ts->read_cnt || (abs(ts->last_read - val) > ts->debounce_tol)) {
+	if (ts->debounce_max && (
+	    !ts->read_cnt || (abs(ts->last_read - val) > ts->debounce_tol))) {
 		/* Repeat it, if this was the first read or the read
 		 * wasn't consistent enough. */
 		if (ts->read_cnt < ts->debounce_max) {
@@ -702,14 +705,9 @@ static int __devinit ads7846_probe(struc
 	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
 	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
 	ts->pressure_max = pdata->pressure_max ? : ~0;
-	if (pdata->debounce_max) {
-		ts->debounce_max = pdata->debounce_max;
-		ts->debounce_tol = pdata->debounce_tol;
-		ts->debounce_rep = pdata->debounce_rep;
-		if (ts->debounce_rep > ts->debounce_max + 1)
-			ts->debounce_rep = ts->debounce_max - 1;
-	} else
-		ts->debounce_tol = ~0;
+	ts->debounce_max = pdata->debounce_max;
+	ts->debounce_tol = pdata->debounce_tol;
+	ts->debounce_rep = pdata->debounce_rep;
 	ts->get_pendown_state = pdata->get_pendown_state;
 
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", spi->dev.bus_id);


--------------000709080403090809050608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000709080403090809050608--
