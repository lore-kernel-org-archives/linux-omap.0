From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 1/2] add DEVICE_ATTR_RO(name)
Date: Mon, 08 May 2006 12:11:21 +0300
Message-ID: <20537.6203441576$1147079703@news.gmane.org>
Reply-To: Hiroshi.DOYU@nokia.com
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

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

add DEVICE_ATTR_RO(name) as __ATTR_RO(_name) in "sysfs.h"

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>


---

 include/linux/device.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

95e30aadfc789d4791777f27cca139c8418f554d
diff --git a/include/linux/device.h b/include/linux/device.h
index f6e72a6..5763b8a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -300,6 +300,9 @@ struct device_attribute {
 #define DEVICE_ATTR(_name,_mode,_show,_store) \
 struct device_attribute dev_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
+#define DEVICE_ATTR_RO(_name) \
+struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
+
 extern int device_create_file(struct device *device, struct device_attribute * entry);
 extern void device_remove_file(struct device * dev, struct device_attribute * attr);
 struct device {
-- 
1.3.2.g8611
