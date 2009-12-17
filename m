From: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/2] omap i2c: make errata 1.153 workaround a separate
 function
Date: Thu, 17 Dec 2009 14:48:43 +0200
Message-ID: <20091217124843.GB29059@shisha.kicks-ass.net>
References: <1260972144-31593-1-git-send-email-virtuoso@slind.org>
 <1260972144-31593-2-git-send-email-virtuoso@slind.org>
 <4B29A036.2040807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B29A036.2040807-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
Cc: "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 17, 2009 at 08:36:30 +0530, Menon, Nishanth wrote:
> Alexander Shishkin said the following on 12/16/2009 07:32 PM:
> >This is to avoid insanely long lines and levels of indentation.
> >
> >Signed-off-by: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
> >CC: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >CC: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >---
> > drivers/i2c/busses/i2c-omap.c |   43 ++++++++++++++++++++++------------------
> > 1 files changed, 24 insertions(+), 19 deletions(-)
> >
> >diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> >index 75bf3ad..ad8242a 100644
> >--- a/drivers/i2c/busses/i2c-omap.c
> >+++ b/drivers/i2c/busses/i2c-omap.c
> >@@ -671,6 +671,27 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
> > #define omap_i2c_rev1_isr		NULL
> > #endif
> >+/*
> >+ * OMAP3430 Errata 1.153: When an XRDY/XDR is hit, wait for XUDF before writing
> >+ * data to DATA_REG. Otherwise some data bytes can be lost while transferring
> >+ * them from the memory to the I2C interface.
> >+ */
> >+static int omap3430_workaround(struct omap_i2c_dev *dev, u16 *stat, int *err)
> 
> note, though this is identified as being part of 3430, it is not
> really restricted to 3430 alone
> we might want to rename this as errata_omap3_1p153() perhaps?

Ok, I don't see why not.

> >+{
> >+	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
> >+		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
> >+			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
> >+							OMAP_I2C_STAT_XDR));
> >+			*err |= OMAP_I2C_STAT_XUDF;
> >+			return -1;
> >+		}
> >+		cpu_relax();
> >+		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> >+	}
> >+
> >+	return 0;
> >+}
> wonder if using an inline might help throw away the function call
> overhead (considering it is used only once)?

objdump -S says it's implicitly inlined already. I actually had in mind
the conversation about generalizing the features/erratas for chips/IPs
and that somehow stopped me from explicitly inlining this. Do you think
it makes sense (for the next version of this patchset) to explicitly
inline this?

> >+
> > static irqreturn_t
> > omap_i2c_isr(int this_irq, void *dev_id)
> > {
> >@@ -794,25 +815,9 @@ complete:
> > 					break;
> > 				}
> >-				/*
> >-				 * OMAP3430 Errata 1.153: When an XRDY/XDR
> >-				 * is hit, wait for XUDF before writing data
> >-				 * to DATA_REG. Otherwise some data bytes can
> >-				 * be lost while transferring them from the
> >-				 * memory to the I2C interface.
> >-				 */
> >-
> >-				if (dev->rev <= OMAP_I2C_REV_ON_3430) {
> >-						while (!(stat & OMAP_I2C_STAT_XUDF)) {
> >-							if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
> >-								omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> >-								err |= OMAP_I2C_STAT_XUDF;
> >-								goto complete;
> >-							}
> >-							cpu_relax();
> >-							stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> >-						}
> >-				}
> >+				if (dev->rev <= OMAP_I2C_REV_ON_3430 &&
> >+				    omap3430_workaround(dev, &stat, &err))
> >+					goto complete;
> > 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
> > 			}
> 
> Regards,
> Nishanth Menon
