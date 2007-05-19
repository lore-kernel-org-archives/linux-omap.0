From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Remove warning in tlv320aic23.c
Date: Sat, 19 May 2007 16:53:42 +0200
Message-ID: <464F0F76.3090302@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090201090305050202090604"
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
--------------090201090305050202090604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Remove warning in tlv320aic23.c about unused variable

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------090201090305050202090604
Content-Type: text/plain;
 name="fix_warning_tlv320aic23.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_warning_tlv320aic23.txt"

Index: linux-osk/drivers/i2c/chips/tlv320aic23.c
===================================================================
--- linux-osk.orig/drivers/i2c/chips/tlv320aic23.c
+++ linux-osk/drivers/i2c/chips/tlv320aic23.c
@@ -652,8 +652,6 @@ static int __init aic23_init(void)
 
 static void __exit aic23_exit(void)
 {
-	int res;
-
 	aic23_power_down();
 	i2c_del_driver(&aic23_driver);
 

--------------090201090305050202090604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090201090305050202090604--
