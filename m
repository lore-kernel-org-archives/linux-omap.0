From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH] Input: ads7846: fix byteorder in the filtering logic
Date: Fri, 12 May 2006 18:38:54 +0300
Message-ID: <1147448334.9837.61.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: Dmitry Torokhov <dtor_core@ameritech.net>, Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

The BE->CPU conversion must be done also in the filtering logic.

Signed-off-by: Imre Deak <imre.deak@nokia.com>

Index: linux-2.6/drivers/input/touchscreen/ads7846.c
===================================================================
--- linux-2.6.orig/drivers/input/touchscreen/ads7846.c	2006-05-12 18:30:38.000000000 +0300
+++ linux-2.6/drivers/input/touchscreen/ads7846.c	2006-05-12 18:35:02.000000000 +0300
@@ -471,7 +471,7 @@ static void ads7846_debounce(void *ads)
 
 	m = &ts->msg[ts->msg_idx];
 	t = list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
-	val = (*(u16 *)t->rx_buf) >> 3;
+	val = (be16_to_cpu(*(__be16 *)t->rx_buf) >> 3) & 0x0fff;
 	if (!ts->read_cnt || (abs(ts->last_read - val) > ts->debounce_tol)) {
 		/* Repeat it, if this was the first read or the read
 		 * wasn't consistent enough. */
