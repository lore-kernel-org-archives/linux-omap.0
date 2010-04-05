From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] OMAP3: I2C: Errata i207: Clear wrong RDR interrupt
Date: Mon, 5 Apr 2010 23:45:24 +0100
Message-ID: <20100405224524.GB32401@fluff.org.uk>
References: <1270124427-11208-1-git-send-email-manjugk@ti.com>
 <4BB4A540.9080000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4BB4A540.9080000-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 01, 2010 at 08:53:04AM -0500, Nishanth Menon wrote:
> G, Manjunath Kondaiah had written, on 04/01/2010 07:20 AM, the following:
> >Under certain rare conditions, I2C_STAT[13].RDR bit may be set
> >and the corresponding interrupt fire, even there is no data in
> >the receive FIFO, or the I2C data transfer is still ongoing.
> >These spurious RDR events must be ignored by the software.
> >
> >This patch handles and ignores RDR spurious interrupts.
> >
> >Reviewed-by: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>
> >Signed-off-by: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
> >Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> >Cc: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>
> >---
> > drivers/i2c/busses/i2c-omap.c |   13 +++++++++++++
> > 1 files changed, 13 insertions(+), 0 deletions(-)
> >
> >diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> >index f2019d2..acf4076 100644
> >--- a/drivers/i2c/busses/i2c-omap.c
> >+++ b/drivers/i2c/busses/i2c-omap.c
> >@@ -796,6 +796,19 @@ complete:
> > 		}
> > 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
> > 			u8 num_bytes = 1;
> >+
> >+			/*
> >+			 * OMAP3 I2C Errata ID: i207
> >+			 * Under certain rare conditions, RDR could be set again
> >+			 * when the bus is busy, then clear and ignore the interrupt
> >+			 */
> >+			if (!(stat & OMAP_I2C_STAT_RRDY) && (stat &
> >+						OMAP_I2C_STAT_BB)) {
> >+				/* clear RDR */
> >+				omap_i2c_ack_stat(dev, stat & OMAP_I2C_STAT_RDR);
> >+				dev_err(dev->dev, "I2C: RDR when bus is busy.\n");
> >+				return IRQ_HANDLED;
> >+			}
> couple of comments after reading thru the errata:
> a) the sequence in the errata doc is:
> if (stat & OMAP_I2C_STAT_RDR) { /* This is cleaner that using an
> obtuse check using !(stat & OMAP_I2C_STAT_RRDY) */
> 	omap_i2c_ack_stat(dev, stat & OMAP_I2C_STAT_RDR); /* dummy read - i
> think this needs clarification as to why */
> 	if (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB)
> /* reason for the i2c_read_reg is because errata mentions a dummy
> stat read  which might mean something for BB -> I am not sure may
> need to be checked with H/w team. */
> 		continue; /* recheck - faster response compared to return and re
> generate interrupt */
> }
> 
> 
> b) does this apply to  OMAP2 and OMAP4?

Ok, should this be held for further discussion?

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
