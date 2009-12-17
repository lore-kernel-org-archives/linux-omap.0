From: "Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/2] omap i2c: add a timeout to the busy waiting
Date: Thu, 17 Dec 2009 16:46:19 -0600
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202A9A04FC6@dlee06.ent.ti.com>
References: <1260972144-31593-1-git-send-email-virtuoso@slind.org>
 <1260972144-31593-2-git-send-email-virtuoso@slind.org>
 <1260972144-31593-3-git-send-email-virtuoso@slind.org>
 <4B29A0B7.1020908@ti.com> <20091217133113.GC29059@shisha.kicks-ass.net>
 <4B2A3926.9090800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B2A3926.9090800-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29Tb/PtFMR13I2A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Alex,

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Thursday, December 17, 2009 7:59 AM
> To: Menon, Nishanth; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Sonasath, Moiz; Pandita, Vikram
> Subject: Re: [PATCH 2/2] omap i2c: add a timeout to the busy waiting
> 
> Alexander Shishkin said the following on 12/17/2009 07:01 PM:
> > On Thu, Dec 17, 2009 at 08:38:39 +0530, Menon, Nishanth wrote:
> >
> >> Alexander Shishkin said the following on 12/16/2009 07:32 PM:
> >>
> >>> The errata 1.153 workaround is busy waiting on XUDF bit in interrupt
> >>> context, which may lead to kernel hangs. The problem can be reproduced
> >>> by running the bus with wrong (too high) speed.
> >>>
> >>> Signed-off-by: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
> >>> CC: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>> CC: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>> ---
> >>> drivers/i2c/busses/i2c-omap.c |    7 ++++++-
> >>> 1 files changed, 6 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-
> omap.c
> >>> index ad8242a..b474c20 100644
> >>> --- a/drivers/i2c/busses/i2c-omap.c
> >>> +++ b/drivers/i2c/busses/i2c-omap.c
> >>> @@ -678,7 +678,9 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
> >>>  */
> >>> static int omap3430_workaround(struct omap_i2c_dev *dev, u16 *stat,
> int *err)
> >>> {
> >>> -	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
> >>> +	unsigned long timeout = 10000;
> >>> +
> >>> +	while (!(*stat & OMAP_I2C_STAT_XUDF && --timeout)) {
> >>>
> >> a) timeout without using an actual delay is not a good idea -
> >> consider each OPP - we can go upto 1ghz on 3630,
> >> the actual time for 10000 iterations will depend on the MPU speed.
> >>
> >
> > Well, I could calculate the timeout value based on current operating
> speed,
> > I guess. Or a delay. Perhaps OMAP_I2C_TIMEOUT can be used here?
> >
> it might be an overkill trying to generate counter based on opp speeds.
> wondering if this delay is required in the first place..

The reason why this timeout was not put in place was that if the I2C controller is functional, the XUDF has to set after XRDY/XDR are set, the only case where it might not be set is when there is a sudden NACK | AL condition produced on the bus and the transfer stops (thereby the FIFO is not getting empty). The code takes care of this error situation so IMHO we can do without a timeout here.

--- Moiz
> 
> Moiz Sonasath / Vikram P, (commit cd086d3a) could probably comment?
> Ref: http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg15317.html
> 
> >
> >> b) how did you arrive at the 10k iteration limit?
> >>
> >
> > It was random, but then it seemed ok considering the l4 latency.
> >
> I had guessed this is an emperical value. It will be good to know the
> exact rationale on why a timeout will happen, else we will have all kind
> of questions pending trying to figure out if a timeout happened.
> 
> >
> >>> 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
> >>> 			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
> >>> 							OMAP_I2C_STAT_XDR));
> >>> @@ -689,6 +691,9 @@ static int omap3430_workaround(struct omap_i2c_dev
> *dev, u16 *stat, int *err)
> >>> 		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> >>> 	}
> >>> +	if (!timeout)
> >>> +		dev_err(dev->dev, "timeout waiting on XUDF bit\n");
> >>> +
> >>> 	return 0;
> >>> }
> Regards,
> Nishanth Menon
