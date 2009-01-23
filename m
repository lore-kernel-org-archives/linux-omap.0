From: "Pakaravoor, Jagadeesh" <j-pakaravoor-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] I2C: OMAP: Include OMAP_I2C_SYSC_REG in save and restore
Date: Fri, 23 Jan 2009 12:51:23 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF0A6@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF069@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF069-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Sorry. I forgot to mention that this patch does not apply on mainline. It is meant for Linux Omap tree only.

Please review/ACK the patch, if you have time.

Thank you.

--
Jagadeesh


-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Pakaravoor, Jagadeesh
Sent: Friday, January 23, 2009 12:25 PM
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare
Subject: [PATCH] I2C: OMAP: Include OMAP_I2C_SYSC_REG in save and restore

From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor-l0cyMroinI0@public.gmane.org>

Save and restore should include OMAP_I2C_SYSC_REG.

Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor-l0cyMroinI0@public.gmane.org>
CC: Jouni Hogander <jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
Index: linux-omap-2.6/drivers/i2c/busses/i2c-omap.c
===================================================================
--- linux-omap-2.6.orig/drivers/i2c/busses/i2c-omap.c	2009-01-22 12:11:12.000000000 +0530
+++ linux-omap-2.6/drivers/i2c/busses/i2c-omap.c	2009-01-22 12:44:12.202367296 +0530
@@ -182,6 +182,7 @@ struct omap_i2c_dev {
 	u16			scllstate;
 	u16			sclhstate;
 	u16			bufstate;
+	u16			syscstate;
 };
 
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
@@ -240,6 +241,7 @@ static void omap_i2c_unidle(struct omap_
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
 	}
 	dev->idle = 0;
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
@@ -300,14 +302,15 @@ static int omap_i2c_init(struct omap_i2c
 		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
 			u32 v;
 
-			v = SYSC_AUTOIDLE_MASK;
-			v |= SYSC_ENAWAKEUP_MASK;
-			v |= (SYSC_IDLEMODE_SMART <<
+			dev->syscstate = SYSC_AUTOIDLE_MASK;
+			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
+			dev->syscstate |= (SYSC_IDLEMODE_SMART <<
 			      __ffs(SYSC_SIDLEMODE_MASK));
-			v |= (SYSC_CLOCKACTIVITY_FCLK <<
+			dev->syscstate |= (SYSC_CLOCKACTIVITY_FCLK <<
 			      __ffs(SYSC_CLOCKACTIVITY_MASK));
 
-			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, v);
+			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
+							dev->syscstate);
 			/*
 			 * Enabling all wakup sources to stop I2C freezing on
 			 * WFI instruction.

--
With Regards,
Jagadeesh Bhaskar P
 
----------------------------
Some men see things as they are and say why - I dream things that never were and say why not.
- George Bernard Shaw
----------------------------

--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
