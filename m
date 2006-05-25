From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 2/3] aic23: omap-alsa-aic23.c clockrate config fix.
Date: Thu, 25 May 2006 23:53:20 +0300
Message-ID: <44761940.8020907@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070903060207080109030404"
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070903060207080109030404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Do not try to change the clockrate if it is already ok. This fixes the
driver for omap-innovator which uses fixed clockrate.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>

--------------070903060207080109030404
Content-Type: text/plain;
	name="0002-omap-alsa-aic23.c-clockrate-config-fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0002-omap-alsa-aic23.c-clockrate-config-fix.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Mika Laitio <lamikr@cc.jyu.fi>
Date: Thu May 25 23:24:16 2006 +0300
Subject: [PATCH 2/3] aic23: omap-alsa-aic23.c clockrate config fix.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>


---

 sound/arm/omap/omap-alsa-aic23.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

48b9327b4d5932cf2f18c8e529e3401b2e926b84
diff --git a/sound/arm/omap/omap-alsa-aic23.c b/sound/arm/omap/omap-alsa-aic23.c
index 18b7395..293c2d4 100644
--- a/sound/arm/omap/omap-alsa-aic23.c
+++ b/sound/arm/omap/omap-alsa-aic23.c
@@ -212,6 +212,8 @@ void aic23_clock_setup(void)
  */
 int aic23_clock_on(void)
 {
+	uint	curRate;
+
 	if (clk_get_usecount(aic23_mclk) > 0) {
 		/* MCLK is already in use */
 		printk(KERN_WARNING
@@ -219,13 +221,14 @@ int aic23_clock_on(void)
 		       (uint) clk_get_rate(aic23_mclk),
 		       CODEC_CLOCK);
 	}
-	
-	if (clk_set_rate(aic23_mclk, CODEC_CLOCK)) {
-		printk(KERN_ERR
-		       "Cannot set MCLK for AIC23 CODEC\n");
-		return -ECANCELED;
+	curRate	= (uint)clk_get_rate(aic23_mclk);
+	if (curRate != CODEC_CLOCK) {
+		if (clk_set_rate(aic23_mclk, CODEC_CLOCK)) {
+			printk(KERN_ERR
+			       "Cannot set MCLK for AIC23 CODEC\n");
+			return -ECANCELED;
+		}
 	}
-
 	clk_enable(aic23_mclk);
 
 	printk(KERN_DEBUG
@@ -239,6 +242,7 @@ int aic23_clock_on(void)
 			  ~ADC_OFF & ~MIC_OFF & ~LINE_OFF);	
 	return 0;
 }
+
 /*
  * Do some sanity check, turn clock off and then turn
  *  codec audio off
-- 
1.2.2


--------------070903060207080109030404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070903060207080109030404--
