From: David Brownell <david-b@pacbell.net>
Subject: [PATCH 2.6.17-rc3-omap] touchscreen doesn't imply tsc2101
Date: Mon, 1 May 2006 13:56:40 -0700
Message-ID: <200605011356.41056.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JYnVEGOMa1CRtDv"
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

--Boundary-00=_JYnVEGOMa1CRtDv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Remove a bogus kconfig line.

--Boundary-00=_JYnVEGOMa1CRtDv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="omap-touch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="omap-touch.patch"

Remove incorrect dependency of OMAP touchscreen support on TSC2101;

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/drivers/input/touchscreen/Kconfig
===================================================================
--- osk.orig/drivers/input/touchscreen/Kconfig	2006-04-22 14:41:05.000000000 -0700
+++ osk/drivers/input/touchscreen/Kconfig	2006-04-23 08:02:33.000000000 -0700
@@ -112,12 +112,12 @@ endif
 config TOUCHSCREEN_OMAP
 	tristate "OMAP touchscreen input driver"
 	depends on INPUT && INPUT_TOUCHSCREEN && ARCH_OMAP
-	select OMAP_TSC2101
 	help
 	  Say Y here if you have an OMAP based board with touchscreen
 	  attached to it, e.g. OMAP Innovator, OSK, H2 or H3
 
-	  If unsure, say N.
+	  If unsure, or you're using drivers in the newer SPI
+	  framework, say N.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap_ts.

--Boundary-00=_JYnVEGOMa1CRtDv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_JYnVEGOMa1CRtDv--
