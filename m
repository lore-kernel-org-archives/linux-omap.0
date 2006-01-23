From: Paul Mundt <paul.mundt@nokia.com>
Subject: [PATCH] i2c: Fix bogus endmenu reference for GPIOEXPANDER_OMAP.
Date: Mon, 23 Jan 2006 16:16:00 +0200
Message-ID: <20060123141600.GC25124@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
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

Signed-off-by: Paul Mundt <paul.mundt@nokia.com>

---

 drivers/i2c/chips/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

180618404fb979f540dc98344b7914747b94ec22
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index abc8d29..946cc21 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -114,7 +114,7 @@ config GPIOEXPANDER_OMAP
 	depends on I2C && (ARCH_OMAP16XX || ARCH_OMAP24XX)
 	help
 	  If you say yes here you get support for I/O expander calls
-	  to configure IrDA, Camera and audio devices endmenu
+	  to configure IrDA, Camera and audio devices.
 
 config MENELAUS
 	bool "Menelaus PM chip"
