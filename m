From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] Fix error in omap_ts.c
Date: Fri, 17 Feb 2006 16:58:16 +0100
Message-ID: <43F5F298.3050505@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030908050709000008020306"
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------030908050709000008020306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Add missing '=' in omap_ts.c as proposed by
Andrzej Zaborowski.

Fix error

CC      drivers/input/touchscreen/omap/omap_ts.o
drivers/input/touchscreen/omap/omap_ts.c:230: error: syntax
error
before '{' token
drivers/input/touchscreen/omap/omap_ts.c:233: error: syntax
error
before '}' token

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>




--------------030908050709000008020306
Content-Type: text/plain;
 name="omap_ts_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_ts_patch.txt"

--- ./drivers/input/touchscreen/omap/omap_ts.c_orig	2006-02-13 21:02:18.000000000 +0100
+++ ./drivers/input/touchscreen/omap/omap_ts.c	2006-02-17 16:54:06.000000000 +0100
@@ -227,7 +227,7 @@ static struct platform_driver omap_ts_dr
 	.remove 	= omap_ts_remove,
 	.suspend 	= omap_ts_suspend,
 	.resume 	= omap_ts_resume,
-	.driver {
+	.driver = {
 		.name	= OMAP_TS_NAME,
 	},
 };



--------------030908050709000008020306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030908050709000008020306--
