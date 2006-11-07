From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warnings in N770 build
Date: Tue, 07 Nov 2006 17:04:03 +0100
Message-ID: <4550AE73.6020007@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060605050409010202030400"
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
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------060605050409010202030400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix some warnings in n770_defconfig build:

drivers/mtd/nand/omap-hw.c:390: warning:
'omap_nand_write_byte' defined but not used

ttahvo-usb.c, tahvo-user.c and retu-user.c: ignoring return
value of 'xxx', declared with attribute warn_unused_result

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------060605050409010202030400
Content-Type: text/plain;
 name="n770_build_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="n770_build_warning_patch.txt"

Index: linux-osk/drivers/cbus/retu-user.c
===================================================================
--- linux-osk.orig/drivers/cbus/retu-user.c
+++ linux-osk/drivers/cbus/retu-user.c
@@ -272,6 +272,7 @@ static int retu_ioctl(struct inode *inod
 		      unsigned int cmd, unsigned long arg)
 {
 	struct retu_tahvo_write_parms par;
+	int ret;
 
 	switch (cmd) {
 	case URT_IOCT_IRQ_SUBSCR:
@@ -279,9 +280,13 @@ static int retu_ioctl(struct inode *inod
 	case RETU_IOCH_READ:
 		return retu_user_read_with_mask(arg);
 	case RETU_IOCX_WRITE:
-		copy_from_user(&par, (void __user *) arg, sizeof(par));
+		ret = copy_from_user(&par, (void __user *) arg, sizeof(par));
+		if(ret)
+			printk(KERN_ERR "copy_from_user failed: %d\n", ret);
 		par.result = retu_user_write_with_mask(par.field, par.value);
-		copy_to_user((void __user *) arg, &par, sizeof(par));
+		ret = copy_to_user((void __user *) arg, &par, sizeof(par));
+		if(ret)
+			printk(KERN_ERR "copy_to_user failed: %d\n", ret);
 		break;
 	case RETU_IOCH_ADC_READ:
 		return retu_read_adc(arg);
@@ -326,8 +331,10 @@ static ssize_t retu_read(struct file *fi
 		list_move(&irq->node, &retu_irqs_reserve);
 		spin_unlock_irqrestore(&retu_irqs_lock, flags);
 
-		copy_to_user(buf + i * sizeof(irq_id), &irq_id, sizeof(irq_id));
-
+		ret = copy_to_user(buf + i * sizeof(irq_id), &irq_id,
+				   sizeof(irq_id));
+		if(ret)
+			printk(KERN_ERR "copy_to_user failed: %d\n", ret);
 	}
 
 	return count;
Index: linux-osk/drivers/cbus/tahvo-usb.c
===================================================================
--- linux-osk.orig/drivers/cbus/tahvo-usb.c
+++ linux-osk/drivers/cbus/tahvo-usb.c
@@ -648,10 +648,12 @@ static int tahvo_usb_probe(struct device
 	}
 
 	/* Attributes */
-	device_create_file(dev, &dev_attr_vbus_state);
+	ret = device_create_file(dev, &dev_attr_vbus_state);
 #ifdef CONFIG_USB_OTG
-	device_create_file(dev, &dev_attr_otg_mode);
+	ret |= device_create_file(dev, &dev_attr_otg_mode);
 #endif
+	if(ret)
+		printk(KERN_ERR "attribute creation failed: %d\n", ret);
 
 	/* Create OTG interface */
 	tahvo_usb_power_off(tu);
Index: linux-osk/drivers/cbus/tahvo-user.c
===================================================================
--- linux-osk.orig/drivers/cbus/tahvo-user.c
+++ linux-osk/drivers/cbus/tahvo-user.c
@@ -256,6 +256,7 @@ static int tahvo_ioctl(struct inode *ino
 		       unsigned int cmd, unsigned long arg)
 {
 	struct retu_tahvo_write_parms par;
+	int ret;
 
 	switch (cmd) {
 	case URT_IOCT_IRQ_SUBSCR:
@@ -263,9 +264,13 @@ static int tahvo_ioctl(struct inode *ino
 	case TAHVO_IOCH_READ:
 		return tahvo_user_read_with_mask(arg);
 	case TAHVO_IOCX_WRITE:
-		copy_from_user(&par, (void __user *) arg, sizeof(par));
+		ret = copy_from_user(&par, (void __user *) arg, sizeof(par));
+		if(ret)
+			printk(KERN_ERR "copy_from_user failed: %d\n", ret);
 		par.result = tahvo_user_write_with_mask(par.field, par.value);
-		copy_to_user((void __user *) arg, &par, sizeof(par));
+		ret = copy_to_user((void __user *) arg, &par, sizeof(par));
+		if(ret)
+			printk(KERN_ERR "copy_to_user failed: %d\n", ret);
 		break;
 	default:
 		return -ENOIOCTLCMD;
@@ -308,7 +313,10 @@ static ssize_t tahvo_read(struct file *f
 		list_move(&irq->node, &tahvo_irqs_reserve);
 		spin_unlock_irqrestore(&tahvo_irqs_lock, flags);
 
-		copy_to_user(buf + i * sizeof(irq_id), &irq_id, sizeof(irq_id));
+		ret =copy_to_user(buf + i * sizeof(irq_id), &irq_id,
+                                  sizeof(irq_id));
+		if(ret)
+			printk(KERN_ERR "copy_to_user failed: %d\n", ret);
 	}
 
 	return count;
Index: linux-osk/drivers/mtd/nand/omap-hw.c
===================================================================
--- linux-osk.orig/drivers/mtd/nand/omap-hw.c
+++ linux-osk/drivers/mtd/nand/omap-hw.c
@@ -386,11 +386,6 @@ static u_char omap_nand_read_byte(struct
 	return nand_read_reg8(NND_ACCESS);
 }
 
-static void omap_nand_write_byte(struct mtd_info *mtd, u_char byte)
-{
-	nand_write_reg8(NND_ACCESS, byte);
-}
-
 static int omap_nand_dev_ready(struct mtd_info *mtd)
 {
 	u32 l;


--------------060605050409010202030400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060605050409010202030400--
