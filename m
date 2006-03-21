From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH] ads7846: report 0 pressure value along with pen up event
Date: Tue, 21 Mar 2006 14:57:45 +0200
Message-ID: <1142945865.8050.7.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TBIqeEJemE0l3h/3x51R"
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
Cc: "Mundt Paul (Nokia-M/Helsinki)" <Paul.Mundt@nokia.com>, Dmitry Torokhov <dtor_core@ameritech.net>, "Yrjola Juha (Nokia-M/Helsinki)" <Juha.Yrjola@nokia.com>
List-Id: linux-omap@vger.kernel.org


--=-TBIqeEJemE0l3h/3x51R
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

X touchscreen drivers that don't interpret the designated pen up message
assume a pen up event from a pressure value 0. For these we generate a
pressure 0 message along with the pen up message.

Signed-off-by: Imre Deak <imre.deak@nokia.com>

--=-TBIqeEJemE0l3h/3x51R
Content-Disposition: attachment; filename=ads7846_pen_up-patch.diff
Content-Type: text/x-patch; name=ads7846_pen_up-patch.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/Makefile b/Makefile
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 00003d1..2b9a521 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -366,11 +366,13 @@ static void ads7846_rx(void *ads)
 	if (Rt) {
 		input_report_abs(input_dev, ABS_X, x);
 		input_report_abs(input_dev, ABS_Y, y);
-		input_report_abs(input_dev, ABS_PRESSURE, Rt);
 		sync = 1;
 	}
-	if (sync)
+
+	if (sync) {
+		input_report_abs(input_dev, ABS_PRESSURE, Rt);
 		input_sync(input_dev);
+	}
 
 #ifdef	VERBOSE
 	if (Rt || ts->pendown)

--=-TBIqeEJemE0l3h/3x51R
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-TBIqeEJemE0l3h/3x51R--
