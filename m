From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 4/5] Add MMC password protection (lock/unlock) support V3
Date: Mon, 09 Jan 2006 18:16:29 -0400
Message-ID: <43C2E0BD.5040601@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090103050800050608030500"
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
To: linux-kernel@vger.kernel.org, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
Cc: linux@arm.linux.org.uk, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, drzeus-list@drzeus.cx
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090103050800050608030500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit






--------------090103050800050608030500
Content-Type: text/x-patch;
 name="mmc_sysfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_sysfs.diff"

Implement MMC password reset and forced erase support. It uses the sysfs
mechanism to send commands to the MMC subsystem. Usage:

Forced erase:

echo erase > /sys/bus/mmc/devices/mmc0\:0001/lockable

Remove password:

echo remove > /sys/bus/mmc/devices/mmc0\:0001/lockable

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-2.6.15-rc4/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-2.6.15-rc4.orig/drivers/mmc/mmc_sysfs.c	2006-01-09 10:35:09.000000000 -0400
+++ linux-2.6.15-rc4/drivers/mmc/mmc_sysfs.c	2006-01-09 12:19:05.000000000 -0400
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/key.h>
+#include <linux/err.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -26,6 +27,10 @@
 #define KEY_OP_INSTANTIATE 1
 #define KEY_OP_UPDATE 2
 
+#ifdef CONFIG_MMC_DEBUG
+#define DEBUG  /* for dev_dbg(), pr_debug(), etc */
+#endif
+
 #define dev_to_mmc_card(d)	container_of(d, struct mmc_card, dev)
 #define to_mmc_driver(d)	container_of(d, struct mmc_driver, drv)
 #define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
@@ -67,6 +72,58 @@ static struct device_attribute mmc_dev_a
 
 static struct device_attribute mmc_dev_attr_scr = MMC_ATTR_RO(scr);
 
+#ifdef	CONFIG_MMC_PASSWORDS
+
+static ssize_t
+mmc_lockable_show(struct device *dev, struct device_attribute *att, char *buf)
+{
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	if (!mmc_card_lockable(card))
+		return sprintf(buf, "unlockable\n");
+	else
+		return sprintf(buf, "lockable, %slocked\n", mmc_card_locked(card) ?
+			"" : "un");
+}
+
+/*
+ * implement MMC password reset ("remove password") and forced erase ("forgot
+ * password").
+ */
+static ssize_t
+mmc_lockable_store(struct device *dev, struct device_attribute *att,
+	const char *data, size_t len)
+{
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	if (!mmc_card_lockable(card))
+		return -EINVAL;
+
+	if (mmc_card_locked(card) && !strncmp(data, "erase", 5)) {
+		/* forced erase only works while card is locked */
+		mmc_lock_unlock(card, NULL, MMC_LOCK_MODE_ERASE);
+		return len;
+	} else if (!mmc_card_locked(card) && !strncmp(data, "remove", 6)) {
+		/* remove password only works while card is unlocked */
+		struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", NULL);
+
+		if (!IS_ERR(mmc_key)) {
+			int err = mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_CLR_PWD);
+			if (!err)
+				return len;
+		} else
+			dev_dbg(&card->dev, "request_key returned error %ld\n", PTR_ERR(mmc_key));
+	}
+
+	return -EINVAL;
+}
+
+static struct device_attribute mmc_dev_attr_lockable =
+	__ATTR(lockable, S_IWUSR | S_IRUGO,
+		 mmc_lockable_show, mmc_lockable_store);
+
+#endif
+
 
 static void mmc_release_card(struct device *dev)
 {
@@ -238,6 +295,11 @@ int mmc_register_card(struct mmc_card *c
 			if (ret)
 				device_del(&card->dev);
 		}
+#ifdef CONFIG_MMC_PASSWORDS
+		ret = device_create_file(&card->dev, &mmc_dev_attr_lockable);
+		if (ret)
+			device_del(&card->dev);
+#endif
 	}
 	return ret;
 }
@@ -251,7 +313,9 @@ void mmc_remove_card(struct mmc_card *ca
 	if (mmc_card_present(card)) {
 		if (mmc_card_sd(card))
 			device_remove_file(&card->dev, &mmc_dev_attr_scr);
-
+#ifdef CONFIG_MMC_PASSWORDS
+		device_remove_file(&card->dev, &mmc_dev_attr_lockable);
+#endif
 		device_del(&card->dev);
 	}
 
@@ -305,19 +369,25 @@ static int manage_key(struct key *key, c
 
 	zap = NULL;
 	ret = -EINVAL;
-	if (datalen <= 0 || datalen > MMC_KEYLEN_MAXBYTES || !data)
+	if (datalen <= 0 || datalen > MMC_KEYLEN_MAXBYTES || !data){
+		dev_dbg(&card->dev, "Invalid data\n");
 		goto error;
+	}
 
 	if (operation == KEY_OP_INSTANTIATE) { /* KEY_OP_INSTANTIATE */
                ret = key_payload_reserve(key, datalen);
-               if (ret < 0)
-                       goto error;
+               if (ret < 0){
+		       dev_dbg(&card->dev, "ret = %d", ret);
+		       goto error;
+	       }
 	}
 
 	ret = -ENOMEM;
 	mpayload = kmalloc(sizeof(*mpayload) + datalen, GFP_KERNEL);
-	if (!mpayload)
+	if (!mpayload){
+		dev_dbg(&card->dev, "Unable to allocate mpayload structure\n");
 		goto error;
+	}
 
 	mpayload->datalen = datalen;
 	memcpy(mpayload->data, data, datalen);
@@ -341,8 +411,10 @@ static int manage_key(struct key *key, c
 	
 	ret = -EINVAL;
 	dev = bus_find_device(&mmc_bus_type, NULL, NULL, mmc_match_lockable);
-	if (!dev)
+	if (!dev){
+		dev_dbg(&card->dev, "Unable to locate device\n");
 		goto error;
+	}
 	card = dev_to_mmc_card(dev);
 	
 	if (operation == KEY_OP_INSTANTIATE) { /* KEY_OP_INSTANTIATE */
@@ -359,8 +431,10 @@ static int manage_key(struct key *key, c
                        ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_SET_PWD);
        }
        
-       if (ret)
+       if (ret){
 	       ret = -EKEYREJECTED;
+	       dev_dbg(&card->dev, "Key was rejected\n");
+       }
 
        if (operation == KEY_OP_UPDATE) /* KEY_OP_UPDATE */
 	       call_rcu(&zap->rcu, mmc_key_update_rcu_disposal);

--------------090103050800050608030500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090103050800050608030500--
