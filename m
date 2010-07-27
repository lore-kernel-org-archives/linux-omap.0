From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: Issue with file transfers to a mass storage device on SMP
	system
Date: Tue, 27 Jul 2010 15:21:13 +0100
Message-ID: <20100727142113.GE11468@n2100.arm.linux.org.uk>
References: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com> <20100727100121.GB7846@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF75B@dbde02.ent.ti.com> <20100727104133.GA10665@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF83C@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF8F3@dbde02.ent.ti.com> <20100727135939.GD11468@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF90B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF90B-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 27, 2010 at 07:44:20PM +0530, Shilimkar, Santosh wrote:
> OMAP doesn't override because the default definition is good enough now.

Ah, good to know.

> Shouldn't below work ?
> #elif __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
> #define mb()            do { dsb(); outer_sync(); } while (0)
> #define rmb()           dmb()
> #define wmb()           mb()

Yes, that should get it out of the CPU and caches, and onto the bus.
However, I need to check up exactly what a write to the L2x0 SYNC
register gives us...

> > As the OMAP mandatory barrier implementation isn't in mainline, I can't
> > comment on that.  However, I feel certain that this is where the problem
> > is.
> 
> Do you think with above setting it should be still a problem ? I mean
> with " CONFIG_ARCH_HAS_BARRIERS" not enabled

Well, the question is whether getting it out of the outer cache (and
performing an effective memory barrier to the outer cache) is sufficient
for the DMA agent to see the data.

Could the data be sitting somewhere in the interconnect between the
CPU pushing it out of the outer cache and the DMA agent trying to read
from memory?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
