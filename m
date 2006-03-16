From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] Fix menelaus
Date: Thu, 16 Mar 2006 16:19:36 +0100
Message-ID: <44198208.9000706@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010803070505000209070206"
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
--------------010803070505000209070206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ARM: OMAP: Fix menelaus.c compile for GCC 4.1.0:

drivers/i2c/chips/menelaus.c:453: error: expected '=' before
'{' token
drivers/i2c/chips/menelaus.c:456: error: expected '}' before
'.' token

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------010803070505000209070206
Content-Type: text/plain;
 name="menelaus_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="menelaus_patch.txt"

--- ./drivers/i2c/chips/menelaus.c_orig	2006-03-16 16:13:53.000000000 +0100
+++ ./drivers/i2c/chips/menelaus.c	2006-03-16 16:15:13.000000000 +0100
@@ -450,7 +450,7 @@ static int menelaus_scan_bus(struct i2c_
 }
 
 static struct i2c_driver menelaus_i2c_driver = {
-	.driver {
+	.driver = {
 		.name		= DRIVER_NAME,
 	},
 	.id		= I2C_DRIVERID_MISC, /*FIXME:accroding to i2c-ids.h */


--------------010803070505000209070206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010803070505000209070206--
