From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] Fix tahvo-usb omap_otg_remove
Date: Tue, 14 Mar 2006 04:48:24 -0800 (PST)
Message-ID: <20060314124824.77040.qmail@web32912.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-592131982-1142340504=:76406"
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
Cc: timo.teras@nokia.com
List-Id: linux-omap@vger.kernel.org

--0-592131982-1142340504=:76406
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch makes tahvo_otg_dev NULL after free_irq.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-592131982-1142340504=:76406
Content-Type: text/x-patch; name="tahvousb.patch"
Content-Description: 4233239670-tahvousb.patch
Content-Disposition: inline; filename="tahvousb.patch"

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index a002fb7..e7f4b88 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -193,8 +193,9 @@ static int omap_otg_probe(struct device 
 
 static int omap_otg_remove(struct device *dev)
 {
-	tahvo_otg_dev = NULL;
 	free_irq(tahvo_otg_dev->resource[1].start, &tahvo_usb_device);
+	tahvo_otg_dev = NULL;
+
 	return 0;
 }
 

--0-592131982-1142340504=:76406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-592131982-1142340504=:76406--
