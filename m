From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] Fix ADS7846 dependencies
Date: Fri, 10 Nov 2006 14:27:42 +0100
Message-ID: <85psbv77ox.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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

--=-=-=

Hi,

While playing with my kernel configuration, I found out that now,
setting CONFIG_HWMON to 'n' and TOUCHSCREEN_ADS7846 to 'y' was allowed,
which leads to a build failure.
This was caused by the commit 954423251daf362272076c6228dcdac65d72b287
which reverts the changes introduced by the commit
659cb49d6a8ba8d5651e53dd22a0addab6a479e6. 
This patch fix the trouble.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fix_ads7846_kconfig_deps.patch

---
 drivers/input/touchscreen/Kconfig |    5 	4 +	1 -	0 !
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6.18/drivers/input/touchscreen/Kconfig
===================================================================
--- linux-2.6.18.orig/drivers/input/touchscreen/Kconfig	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18/drivers/input/touchscreen/Kconfig	2006-11-10 14:24:47.000000000 +0100
@@ -14,10 +14,13 @@ if INPUT_TOUCHSCREEN
 config TOUCHSCREEN_ADS7846
 	tristate "ADS 7846 based touchscreens"
 	depends on SPI_MASTER
+	select HWMON
 	help
 	  Say Y here if you have a touchscreen interface using the
 	  ADS7846 controller, and your board-specific initialization
-	  code includes that in its table of SPI devices.
+	  code includes that in its table of SPI devices.  You will
+	  also get hwmon interfaces for the temperature and voltage
+	  sensors this chip provides.
 
 	  If unsure, say N (but it's safe to say "Y").
 

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
