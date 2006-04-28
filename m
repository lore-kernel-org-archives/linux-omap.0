From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix tlv320aic23.c
Date: Fri, 28 Apr 2006 17:44:14 +0200
Message-ID: <4452384E.7080409@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050803070906060707030808"
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
--------------050803070906060707030808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix error from GCC 4.1.0:

drivers/i2c/chips/tlv320aic23.c:157: error: expected '='
before '{' token
drivers/i2c/chips/tlv320aic23.c:161: error: expected '}'
before '.' token

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

-- cut, comment not to go into git below --

Seems that the first part of

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=51c0cddf5027bd4e5c1903845047d7d7e266c79b

was lost somewhere??

--------------050803070906060707030808
Content-Type: text/plain;
 name="tlv320aic23_gcc_410_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tlv320aic23_gcc_410_patch.txt"

--- ./drivers/i2c/chips/tlv320aic23.c_orig	2006-04-28 17:29:49.000000000 +0200
+++ ./drivers/i2c/chips/tlv320aic23.c	2006-04-28 17:30:55.000000000 +0200
@@ -154,7 +154,7 @@ static int aic23_attach_adapter(struct i
 }
 
 static struct i2c_driver aic23_driver = {
-	.driver {
+	.driver = {
 		.name	= "OMAP+TLV320AIC23 codec",
 		/*.flags	= I2C_DF_NOTIFY,*/
 	},


--------------050803070906060707030808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050803070906060707030808--
