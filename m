From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 7/8] i2c: add 'transferred' field to struct i2c_msg
Date: Sat, 27 Oct 2012 16:32:24 +0200
Message-ID: <20121027163224.67d57aef@endymion.delvare>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
	<1350899218-13624-8-git-send-email-balbi@ti.com>
	<20121025145748.760c218b@endymion.delvare>
	<20121025131459.GG28061@n2100.arm.linux.org.uk>
	<20121025154202.41f3cbba@endymion.delvare>
	<20121025134609.GH28061@n2100.arm.linux.org.uk>
	<20121025155633.609c5554@endymion.delvare>
	<20121025141800.GI28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121025141800.GI28061-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 25 Oct 2012 15:18:00 +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 25, 2012 at 03:56:33PM +0200, Jean Delvare wrote:
> > The original idea of using the hole in the i2c_msg structure is from
> > David Brownell, who was apparently familiar with such practice, so I
> > assumed it was OK. Actually I still assume it is, until someone comes
> > with an supported architecture where it is not.
> 
> According to Al Viro, that would be m68k.

OK... So to make things clear, let me ask Al directly about it. Al, can
you please tell us if:

--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
 struct i2c_msg {
 	__u16 addr;		/* slave address			*/
 	__u16 flags;
 	__u16 len;		/* msg length				*/
+	__u16 transferred;	/* actual bytes transferred             */
 	__u8 *buf;		/* pointer to msg data			*/
 };
 
would break binary compatibility on m68k or any other architecture you
are familiar with? Note that struct i2c_msg isn't declared with
attribute packed, so my assumption was that pointer "buf" was align on
at least 4 bytes, leaving a hole between len and buf. Am I wrong?

Thanks,
-- 
Jean Delvare
