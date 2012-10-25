From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 7/8] i2c: add 'transferred' field to struct i2c_msg
Date: Thu, 25 Oct 2012 14:14:59 +0100
Message-ID: <20121025131459.GG28061@n2100.arm.linux.org.uk>
References: <1350899218-13624-1-git-send-email-balbi@ti.com> <1350899218-13624-8-git-send-email-balbi@ti.com> <20121025145748.760c218b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121025145748.760c218b-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 25, 2012 at 02:57:48PM +0200, Jean Delvare wrote:
> Hi Felipe, Shubhrajyoti,
> 
> On Mon, 22 Oct 2012 12:46:57 +0300, Felipe Balbi wrote:
> > From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> > 
> > In case of a NACK, it's wise to tell our clients
> > drivers about how many bytes were actually transferred.
> > 
> > Support this by adding an extra field to the struct
> > i2c_msg which gets incremented the amount of bytes
> > actually transferred.
> > 
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > ---
> >  include/uapi/linux/i2c.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
> > index 0e949cb..4b35c9b 100644
> > --- a/include/uapi/linux/i2c.h
> > +++ b/include/uapi/linux/i2c.h
> > @@ -77,6 +77,7 @@ struct i2c_msg {
> >  #define I2C_M_NO_RD_ACK		0x0800	/* if I2C_FUNC_PROTOCOL_MANGLING */
> >  #define I2C_M_RECV_LEN		0x0400	/* length will be first received byte */
> >  	__u16 len;		/* msg length				*/
> > +	__u16 transferred;	/* actual bytes transferred             */
> >  	__u8 *buf;		/* pointer to msg data			*/
> >  };
> 
> On the principle I am fine with this, however you also need to define
> who should initialize this field, and to what value.

You also miss one very very very big point.  This will break every I2C
using userspace program out there unless it is rebuilt - this change will
require the exact right version of those userspace programs for the
kernel that they're being used on.

Now that we have the userspace API headers separated, this is now much
easier to detect: a patch which touches a uapi header needs much more
careful consideration than one which doesn't.

So no, strong NAK.  This is not how we treat userspace.

If we want to change userspace API then we do it in a sane manner, where
we provide the new functionality in a way that it doesn't break existing
users.  There's two ways to do this:

1. Leave the existing struct alone, introduce a new one with new ioctls.
   Schedule the removal of the old interfaces for maybe 10 years time.

2. Rename the existing struct (eg struct old_i2c_msg), and create a new
   struct called i2c_msg.  Rename the existing ioctls to have OLD_ in
   their names.  Provide the existing ioctls under those names, and
   make them print a warning once that userspace programs need updating.
   Schedule the removal of the old interfaces for a shorter number of
   years than (1);

Remember all those "old" syscalls we have... this is no different from
those.
