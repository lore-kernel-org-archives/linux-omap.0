From: "Pakaravoor, Jagadeesh" <j-pakaravoor-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] I2C: OMAP: Add missing wakeup events
Date: Mon, 2 Feb 2009 12:47:05 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A3D44D79@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF17B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF17B-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Ben,

  Did you get a chance to look at this patch?



-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Pakaravoor, Jagadeesh
Sent: Friday, January 23, 2009 2:19 PM
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Ben Dooks
Subject: [PATCH] I2C: OMAP: Add missing wakeup events

From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor-l0cyMroinI0@public.gmane.org>

Include wake up events for receiver overflow and transmitter
underflow in OMAP_I2C_WE_REG configuration. Also fix a small
typo.

Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor-l0cyMroinI0@public.gmane.org>
---
Index: kernel_org/drivers/i2c/busses/i2c-omap.c
===================================================================
--- kernel_org.orig/drivers/i2c/busses/i2c-omap.c	2009-01-23 12:46:58.000000000 +0530
+++ kernel_org/drivers/i2c/busses/i2c-omap.c	2009-01-23 14:15:52.187150630 +0530
@@ -92,8 +92,10 @@
 #define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
 
 /* I2C WE wakeup enable register */
-#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakup */
+#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakeup */
 #define OMAP_I2C_WE_RDR_WE	(1 << 13)	/* RX drain wakeup */
+#define OMAP_I2C_WE_ROVR_WE	(1 << 11)	/* RX overflow wakeup */
+#define OMAP_I2C_WE_XUDF_WE	(1 << 10)	/* TX underflow wakeup */
 #define OMAP_I2C_WE_AAS_WE	(1 << 9)	/* Address as slave wakeup*/
 #define OMAP_I2C_WE_BF_WE	(1 << 8)	/* Bus free wakeup */
 #define OMAP_I2C_WE_STC_WE	(1 << 6)	/* Start condition wakeup */
@@ -104,6 +106,7 @@
 #define OMAP_I2C_WE_AL_WE	(1 << 0)	/* Arbitration lost wakeup */
 
 #define OMAP_I2C_WE_ALL		(OMAP_I2C_WE_XDR_WE | OMAP_I2C_WE_RDR_WE | \
+				OMAP_I2C_WE_ROVR_WE | OMAP_I2C_WE_XUDF_WE | \
 				OMAP_I2C_WE_AAS_WE | OMAP_I2C_WE_BF_WE | \
 				OMAP_I2C_WE_STC_WE | OMAP_I2C_WE_GC_WE | \
 				OMAP_I2C_WE_DRDY_WE | OMAP_I2C_WE_ARDY_WE | \
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
