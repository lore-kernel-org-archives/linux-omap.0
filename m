From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: 2.6.19 + omap patch on the OSK
Date: Wed, 03 Jan 2007 18:08:54 +0100
Message-ID: <459BE326.7030903@googlemail.com>
References: <459AB907.1030102@balister.org> <20070102201156.GA9733@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000602010102060907050402"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070102201156.GA9733@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: tony@atomide.com
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000602010102060907050402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

tony@atomide.com wrote:
> Please try this patch:
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008232.html
> 
> I'll apply it back to linux-omap tree as now there is a longer term
> solution with David Brownell's I2C patches that should eventually
> solve this problem for mainline kernel also.

Looks like the removal of  ~I2C_FUNC_SMBUS_QUICK was missed
while applying it. Update of this in attachment.

-- cut --

ARM: OMAP: Remove ~I2C_FUNC_SMBUS_QUICK to make this hack
working. Beautify #ifdef.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------000602010102060907050402
Content-Type: text/plain; name="i2c_zero_length_smbus_quick_hack_patch_new.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="i2c_zero_length_smbus_quick_hack_patch_new.txt"

Index: linux-osk/drivers/i2c/busses/i2c-omap.c
===================================================================
--- linux-osk.orig/drivers/i2c/busses/i2c-omap.c
+++ linux-osk/drivers/i2c/busses/i2c-omap.c
@@ -36,6 +36,10 @@
 
 #include <asm/io.h>
 
+/* Hack to enable zero length transfers and smbus quick until clean fix
+   is available */
+#define OMAP_HACK
+
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
 
@@ -285,14 +289,16 @@ static int omap_i2c_xfer_msg(struct i2c_
 			     struct i2c_msg *msg, int stop)
 {
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
+#ifdef OMAP_HACK
 	u8 zero_byte = 0;
+#endif
 	int r;
 	u16 w;
 
 	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
 
-#if 0
+#ifndef OMAP_HACK
 	if (msg->len == 0)
 		return -EINVAL;
 
@@ -406,7 +412,11 @@ out:
 static u32
 omap_i2c_func(struct i2c_adapter *adap)
 {
+#ifndef OMAP_HACK
 	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
+#else
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+#endif
 }
 
 static inline void


--------------000602010102060907050402
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000602010102060907050402--
