From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Convert SLAB_KERNEL to GFP_KERNEL in ads7846.c
Date: Fri, 22 Dec 2006 11:09:46 +0100
Message-ID: <458BAEEA.1010402@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090103050604030405040408"
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

This is a multi-part message in MIME format.
--------------090103050604030405040408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Convert SLAB_KERNEL to GFP_KERNEL in ads7846.c

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

--------------090103050604030405040408
Content-Type: text/plain;
 name="ads_fixes.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ads_fixes.txt"

Index: linux-osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- linux-osk.orig/drivers/input/touchscreen/ads7846.c
+++ linux-osk/drivers/input/touchscreen/ads7846.c
@@ -201,7 +201,7 @@ static int ads7846_read12_ser(struct dev
 {
 	struct spi_device	*spi = to_spi_device(dev);
 	struct ads7846		*ts = dev_get_drvdata(dev);
-	struct ser_req		*req = kzalloc(sizeof *req, SLAB_KERNEL);
+	struct ser_req		*req = kzalloc(sizeof *req, GFP_KERNEL);
 	int			status;
 	int			sample;
 	int			use_internal;



--------------090103050604030405040408
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090103050604030405040408--
