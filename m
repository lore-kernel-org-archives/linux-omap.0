From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [RFC/PATCH 1/3] i2c: Add SCCB support
Date: Tue, 17 Jul 2012 13:57:25 +0200
Message-ID: <3429100.CjPKYaDDfQ@avalon>
References: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com> <1340720229-30356-2-git-send-email-laurent.pinchart@ideasonboard.com> <20120717135307.6745729f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120717135307.6745729f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Jean,

On Tuesday 17 July 2012 13:53:07 Jean Delvare wrote:
> On Tue, 26 Jun 2012 16:17:07 +0200, Laurent Pinchart wrote:
> > SCCB is a serial communication bus developed by Omnivision. Its 2-wire
> > mode is very similar to SMBus byte data transactions, but requires the
> > controller to ignore the ACK bit and to insert a stop condition after
> > each message.
> > 
> > Add a device SCCB flag and a message stop flag to be passed to
> > controller drivers.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > ---
> > 
> >  drivers/i2c/i2c-core.c |   13 ++++++++++++-
> >  include/linux/i2c.h    |    2 ++
> >  2 files changed, 14 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index feb7dc3..8cfa660 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -1939,6 +1939,12 @@ static s32 i2c_smbus_xfer_emulated(struct
> > i2c_adapter *adapter, u16 addr,> 
> >  	u8 partial_pec = 0;
> >  	int status;
> > 
> > +	if (unlikely(flags & I2C_CLIENT_SCCB) && size != I2C_SMBUS_BYTE_DATA) 
{
> > +		dev_err(&adapter->dev,
> > +			"SCCB devices only support I2C_SMBUS_BYTE_DATA\n");
> > +		return -EINVAL;
> > +	}
> > +
> 
> I'm not sure if we really want this. If the SCCB protocol evolves,
> we'll have to loosen the check. If a devices follows SCCB for byte data
> transactions and I2C/SMBus for others, it won't work. Plus it slows
> down the function a bit, to catch a developer error which would not
> result in anything catastrophic anyway.
> 
> I propose that we either drop the check completely (my preference) or
> make it depend on DEBUG.

I'm OK with dropping the check. Should I resubmit the patch or can you modify 
it when applying ?

> >  	msgbuf0[0] = command;
> >  	switch (size) {
> > 
> >  	case I2C_SMBUS_QUICK:

-- 
Regards,

Laurent Pinchart
