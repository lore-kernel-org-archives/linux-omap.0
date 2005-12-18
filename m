From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] fix watchdog
Date: Sun, 18 Dec 2005 06:09:22 -0800 (PST)
Message-ID: <20051218140922.88154.qmail@web32915.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1207545726-1134914962=:83926"
Content-Transfer-Encoding: 8bit
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

--0-1207545726-1134914962=:83926
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Change .driver_name from "omap-wdt" to "omap_wdt".

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1207545726-1134914962=:83926
Content-Type: text/plain; name="fix-watchdog.patch"
Content-Description: 3502949089-fix-watchdog.patch
Content-Disposition: inline; filename="fix-watchdog.patch"

diff --git a/drivers/char/watchdog/omap_wdt.c b/drivers/char/watchdog/omap_wdt.c
index 9904165..8f6fa68 100644
--- a/drivers/char/watchdog/omap_wdt.c
+++ b/drivers/char/watchdog/omap_wdt.c
@@ -362,7 +362,7 @@ static struct platform_driver omap_wdt_d
 	.resume		= omap_wdt_resume,
 	.driver		= {
 		.owner	= THIS_MODULE,
-		.name	= "omap-wdt",
+		.name	= "omap_wdt",
 	},
 };
 

--0-1207545726-1134914962=:83926
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1207545726-1134914962=:83926--
