From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [PATCH] MMC - CONFIG_HOTPLUG support
Date: Fri, 16 Dec 2005 15:50:13 -0400
Message-ID: <43A31A75.7070500@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040203050404060901000702"
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
To: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------040203050404060901000702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

This patch improves the CONFIG_HOTPLUG support on the mmc core driver.
Kernel version: 2.6.15-rc4-omap1

BR,

--
Anderson Briglia

--------------040203050404060901000702
Content-Type: text/x-patch;
 name="mmc_config_hotplug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_config_hotplug.diff"

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>

Index: linux-2.6.15-rc4/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-2.6.15-rc4.orig/drivers/mmc/mmc_sysfs.c	2005-12-15 17:00:52.000000000 -0400
+++ linux-2.6.15-rc4/drivers/mmc/mmc_sysfs.c	2005-12-15 17:54:07.000000000 -0400
@@ -145,6 +145,8 @@ static int mmc_bus_match(struct device *
 	return !mmc_card_bad(card);
 }
 
+#ifdef CONFIG_HOTPLUG
+
 static int
 mmc_bus_hotplug(struct device *dev, char **envp, int num_envp, char *buf,
 		int buf_size)
@@ -180,6 +182,17 @@ mmc_bus_hotplug(struct device *dev, char
 	return 0;
 }
 
+#else
+
+static int
+mmc_bus_hotplug(struct device *dev, char **envp, int num_envp, char *buf,
+		int buf_size)
+{
+	return -ENODEV;
+}
+
+#endif  /* CONFIG_HOTPLUG */
+
 static int mmc_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);

--------------040203050404060901000702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040203050404060901000702--
