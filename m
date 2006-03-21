From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH] ads7846: pressure value limitation
Date: Tue, 21 Mar 2006 20:56:12 +0200
Message-ID: <1142967372.8050.45.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Hu4FwBGdEhbE9/MTRUVQ"
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
Cc: Paul.Mundt@nokia.com, Dmitry Torokhov <dtor_core@ameritech.net>, "Yrjola Juha (Nokia-M/Helsinki)" <Juha.Yrjola@nokia.com>
List-Id: linux-omap@vger.kernel.org


--=-Hu4FwBGdEhbE9/MTRUVQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Limit the pressure value to the maximum specified in the board-*
specific file. Samples with pressure values beyond the maximum are
considered non-reliable. For these report the x,y values measured last.

Signed-off-by: Imre Deak <imre.deak@nokia.com>

--=-Hu4FwBGdEhbE9/MTRUVQ
Content-Disposition: attachment; filename=ads7846-pressure_max-patch.diff
Content-Type: text/x-patch; name=ads7846-pressure_max-patch.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 2b9a521..02f4cdc 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -81,10 +83,14 @@ struct ads7846 {
 	u16			model;
 	u16			vref_delay_usecs;
 	u16			x_plate_ohms;
+	u16			pressure_max;
 
 	u8			read_x, read_y, read_z1, read_z2, pwrdown;
 	u16			dummy;		/* for the pwrdown read */
 	struct ts_event		tc;
+	u16			last_x;
+	u16			last_y;
+	u16			last_pressure;
 
 	struct spi_transfer	xfer[10];
 	struct spi_message	msg[5];
@@ -345,6 +351,18 @@ static void ads7846_rx(void *ads)
 	} else
 		Rt = 0;
 
+	if (Rt > ts->pressure_max) {
+		if (ts->last_pressure) {
+			x = ts->last_x;
+			y = ts->last_y;
+		}
+		Rt = ts->pressure_max;
+	}
+
+	ts->last_x = x;
+	ts->last_y = y;
+	ts->last_pressure = Rt;
+
 	/* NOTE:  "pendown" is inferred from pressure; we don't rely on
 	 * being able to check nPENIRQ status, or "friendly" trigger modes
 	 * (both-edges is much better than just-falling or low-level).
@@ -596,6 +615,7 @@ static int __devinit ads7846_probe(struc
 	ts->model = pdata->model ? : 7846;
 	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
 	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
+	ts->pressure_max = pdata->pressure_max ? : 255;
 	ts->debounce_max = pdata->debounce_max ? : 1;
 	ts->debounce_tol = pdata->debounce_tol ? : 10;
 


--=-Hu4FwBGdEhbE9/MTRUVQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-Hu4FwBGdEhbE9/MTRUVQ--
