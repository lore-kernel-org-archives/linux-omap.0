From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning in plat_uds.c
Date: Fri, 17 Aug 2007 17:43:47 +0200
Message-ID: <46C5C233.5090405@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090405000103020007020309"
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
--------------090405000103020007020309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix warning

drivers/usb/musb/plat_uds.c:1731: warning: 'dev_attr_srp' defined but 
not used

if CONFIG_USB_MUSB_OTG isn't set (DaVinci use case)

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

--------------090405000103020007020309
Content-Type: text/plain;
 name="plat_uds_warning_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="plat_uds_warning_fix.txt"

Index: linux-davinci/drivers/usb/musb/plat_uds.c
===================================================================
--- linux-davinci.orig/drivers/usb/musb/plat_uds.c
+++ linux-davinci/drivers/usb/musb/plat_uds.c
@@ -1707,6 +1707,7 @@ musb_vbus_show(struct device *dev, struc
 }
 static DEVICE_ATTR(vbus, 0644, musb_vbus_show, musb_vbus_store);
 
+#ifdef CONFIG_USB_MUSB_OTG
 static ssize_t
 musb_srp_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t n)
@@ -1728,8 +1729,11 @@ musb_srp_store(struct device *dev, struc
 
 	return n;
 }
+
+
 static DEVICE_ATTR(srp, 0644, NULL, musb_srp_store);
 #endif
+#endif
 
 /* Only used to provide cable state change events */
 static void musb_irq_work(struct work_struct *data)


--------------090405000103020007020309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090405000103020007020309--
