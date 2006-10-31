From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Make AIC23 sound work again
Date: Tue, 31 Oct 2006 19:48:13 +0100
Message-ID: <45479A6D.2080100@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090202060208060206060709"
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
--------------090202060208060206060709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hack to add I2C zero length transfers and SMBus quick mode
necessary for AIC23 sound again.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>



--------------090202060208060206060709
Content-Type: text/plain;
 name="i2c_zero_length_smbus_quick_hack_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="i2c_zero_length_smbus_quick_hack_patch.txt"

Index: linux-osk/drivers/i2c/busses/i2c-omap.c
===================================================================
--- linux-osk.orig/drivers/i2c/busses/i2c-omap.c
+++ linux-osk/drivers/i2c/busses/i2c-omap.c
@@ -285,20 +285,29 @@ static int omap_i2c_xfer_msg(struct i2c_
 			     struct i2c_msg *msg, int stop)
 {
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
+	u8 zero_byte = 0;
 	int r;
 	u16 w;
 
 	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
 
-	if (msg->len == 0)
-		return -EINVAL;
-
 	omap_i2c_write_reg(dev, OMAP_I2C_SA_REG, msg->addr);
 
-	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
-	dev->buf = msg->buf;
-	dev->buf_len = msg->len;
+	/* Sigh, seems we can't do zero length transactions. Thus, we
+	 * can't probe for devices w/o actually sending/receiving at least
+	 * a single byte. So we'll set count to 1 for the zero length
+	 * transaction case and hope we don't cause grief for some
+	 * arbitrary device due to random byte write/read during
+	 * probes.
+	 */
+	if (msg->len == 0) {
+		dev->buf = &zero_byte;
+		dev->buf_len = 1;
+	} else {
+		dev->buf = msg->buf;
+		dev->buf_len = msg->len;
+	}
 
 	omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);
 
@@ -383,7 +392,7 @@ out:
 static u32
 omap_i2c_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static inline void


--------------090202060208060206060709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090202060208060206060709--
