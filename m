From: Tom Rini <trini-l0cyMroinI0@public.gmane.org>
Subject: Re: Unifying cape overlays into boot .dtb for
 BeagleBoard.org boards
Date: Tue, 17 Jun 2014 08:37:09 -0400
Message-ID: <53A03675.1000908@ti.com>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com> <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com> <20140617090931.GB3705@n2100.arm.linux.org.uk>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <beagleboard+bncBCF77LUSWAKRBA7NQCOQKGQEJS6TTHI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140617090931.GB3705-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/beagleboard/subscribe>, <mailto:beagleboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe>, <mailto:googlegroups-manage+1035534660134+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 06/17/2014 05:09 AM, Russell King - ARM Linux wrote:
> On Mon, Jun 16, 2014 at 09:22:50AM -0400, Jason Kridner wrote:
>> Adding devicetree and linux-arm-kernel lists based on feedback on IRC...
>>
>> On Tue, Jun 10, 2014 at 12:46 PM, Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> I'd like to discuss moving our current library of cape devicetree
>>> overlay sources into a single tree, including the boot .dtb files for
>>> BeagleBoard.org boards and moving towards enabling as much of the cape
>>> support into a single boot-time .dtb file with an approach similar to
>>> the cape-universal overlay
>>> (https://github.com/cdsteinkuehler/beaglebone-universal-io), but not
>>> in an overlay.
>>>
>>> First of all, I want to note this doesn't change my view on the
>>> importance of mainline support for devicetree overlays. They are still
>>> absolutely critical and highly useful, solving problems that cannot be
>>> solved through boot-time devicetrees. I'm simply looking for an
>>> approach that will complement the availability of overlays and provide
>>> the best user experience.
> 
> Here's the most obvious question in the world on this topic.  Are capes
> hot-pluggable?
> 
> Looking at the posts on google+ from David Anders, they're using pin
> headers for connectivity, with no additional protection against hot-
> plugging, and no sequencing of pin connection.  In other words, they are
> not hot-pluggable.
> 
> So, why do we need to add a load of infrastructure to the kernel to allow
> the device tree to be modified at run time?  At present, the way the
> entire DT infrastructure works is that it assumes the DT remains static
> and never changes - this applies not only to the core DT code, but also
> to all the drivers which have been converted.
> 
> So, you're asking for a feature which is impossible to really make use
> of on the hardware which you want to use it.
> 
> Why should kernel developers go to the extent of adding support for DT
> modification at runtime when the platform you want this for doesn't even
> support hotplugging of these capes?
> 
> The logical way to deal with this is to have the boot loader merge DT
> fragments together before it calls the kernel, so the kernel sees a single
> DT blob which describes the whole hardware.

Frankly, if we're going to push device tree merging to be someone elses
problem, I'd like to push it out to userspace.

> A good way that this could have been done is to put an I2C EEPROM on
> each cape, and have that store the DT fragment.  The boot loader could
> have then read that from each cape, and used that information to build
> up the final DT.  Why this hasn't been thought of, considering that the
> kernel has been moving towards DT for years, is quite unbelievable.

I had actually talked about this a long while back (face to face) with
people, but the problem was (and still kind of is) the bindings
changing, etc.

-- 
Tom

-- 
For more options, visit http://beagleboard.org/discuss
--- 
You received this message because you are subscribed to the Google Groups "BeagleBoard" group.
To unsubscribe from this group and stop receiving emails from it, send an email to beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
