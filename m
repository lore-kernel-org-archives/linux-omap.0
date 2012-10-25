From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 7/8] i2c: add 'transferred' field to struct i2c_msg
Date: Thu, 25 Oct 2012 15:56:33 +0200
Message-ID: <20121025155633.609c5554@endymion.delvare>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
	<1350899218-13624-8-git-send-email-balbi@ti.com>
	<20121025145748.760c218b@endymion.delvare>
	<20121025131459.GG28061@n2100.arm.linux.org.uk>
	<20121025154202.41f3cbba@endymion.delvare>
	<20121025134609.GH28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121025134609.GH28061-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 25 Oct 2012 14:46:09 +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 25, 2012 at 03:42:02PM +0200, Jean Delvare wrote:
> > On Thu, 25 Oct 2012 14:14:59 +0100, Russell King - ARM Linux wrote:
> > > You also miss one very very very big point.  This will break every I2C
> > > using userspace program out there unless it is rebuilt - this change will
> > > require the exact right version of those userspace programs for the
> > > kernel that they're being used on.
> > 
> > How that? The extra field is added in a hole, so we don't change the
> > struct size nor the relative positions of existing fields. Why would
> > user-space care?
> 
> You know the layout of that struct for certain across all Linux supported
> architectures, including some of the more obscure ones which may not
> require pointers to be aligned?

No I don't, I naively supposed it would be fine. I would expect gcc to
always align pointers even when the architecture doesn't need them to
be, for performance reasons, even when it doesn't have to, as long as
attribute packed isn't used. After all, integers don't _have_ to be
aligned on x86, but gcc aligns them.

The original idea of using the hole in the i2c_msg structure is from
David Brownell, who was apparently familiar with such practice, so I
assumed it was OK. Actually I still assume it is, until someone comes
with an supported architecture where it is not.

-- 
Jean Delvare
