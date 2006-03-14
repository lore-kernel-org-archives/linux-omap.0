From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] Fix tlv320aic23.c
Date: Tue, 14 Mar 2006 17:48:27 +0100
Message-ID: <4416F3DB.1090605@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060207030301010206060009"
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
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------060207030301010206060009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix error from GCC 4.1.0:

drivers/i2c/chips/tlv320aic23.c:157: error: expected '='
before '{' token
drivers/i2c/chips/tlv320aic23.c:161: error: expected '}'
before '.' token
drivers/i2c/chips/tlv320aic23.c:597: error: expected '='
before '{' token
drivers/i2c/chips/tlv320aic23.c:601: error: expected '}'
before '.' token

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>



--------------060207030301010206060009
Content-Type: text/plain;
 name="tlv320aic23_error.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tlv320aic23_error.txt"

--- ./drivers/i2c/chips/tlv320aic23.c_orig	2006-03-14 17:39:07.000000000 +0100
+++ ./drivers/i2c/chips/tlv320aic23.c	2006-03-14 17:41:19.000000000 +0100
@@ -154,7 +154,7 @@ static int tlv320aic23_attach_adapter(st
 }
 
 static struct i2c_driver tlv320aic23_driver = {
-	.driver {
+	.driver = {
 		.name	= "OMAP+TLV320AIC23 codec",
 		/*.flags	= I2C_DF_NOTIFY,*/
 	},
@@ -594,7 +594,7 @@ static int audio_i2c_resume(struct platf
 }
 
 static struct platform_driver audio_i2c_driver = {
-	.driver {
+	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= "audio-i2c",
 	},


--------------060207030301010206060009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060207030301010206060009--
