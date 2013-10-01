From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCHv2 1/9] hwspinlock/core: add common dt bindings and OF
 helpers
Date: Tue, 1 Oct 2013 09:36:02 +0100
Message-ID: <20131001083602.GG22259@e106331-lin.cambridge.arm.com>
References: <cover.1379445653.git.s-anna@ti.com>
 <4df03ac30dcc79132e3acc2e586d0ca99b431258.1379445653.git.s-anna@ti.com>
 <14DB8294-1148-446A-A6D3-34E66BA8732C@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <14DB8294-1148-446A-A6D3-34E66BA8732C-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

Apologies for replying to a subthread, due to an earlier mistake on my
part I don't have the original to hand.

On Fri, Sep 27, 2013 at 05:04:22PM +0100, Kumar Gala wrote:
> 
> On Sep 17, 2013, at 2:30 PM, Suman Anna wrote:
> 
> > All the platform-specific hwlock driver implementations need the
> > number of locks and the associated base id for registering the
> > locks present within a hwspinlock device with the driver core.
> > These two variables are represented by 'hwlock-num-locks' and
> > 'hwlock-base-id' properties. The documentation and OF helpers to
> > retrieve these common properties have been added to the driver core.
> > 
> > Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> > ---
> > .../devicetree/bindings/hwlock/hwlock.txt          | 26 +++++++++
> > drivers/hwspinlock/hwspinlock_core.c               | 61 +++++++++++++++++++++-
> > include/linux/hwspinlock.h                         | 11 ++--
> > 3 files changed, 93 insertions(+), 5 deletions(-)
> > create mode 100644 Documentation/devicetree/bindings/hwlock/hwlock.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/hwlock/hwlock.txt b/Documentation/devicetree/bindings/hwlock/hwlock.txt
> > new file mode 100644
> > index 0000000..789930e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwlock/hwlock.txt
> > @@ -0,0 +1,26 @@
> > +Generic hwlock bindings
> > +=======================
> > +
> > +Generic bindings that are common to all the hwlock platform specific driver
> > +implementations, the retrieved values are used for registering the device
> > +specific parameters with the hwspinlock core.
> > +
> > +The validity and need of these common properties may vary from one driver
> > +implementation to another. Look through the individual hwlock driver
> > +binding documentations for identifying which are mandatory and which are
> > +optional for that specific driver.
> > +
> > +Common properties:
> > +- hwlock-base-id:	Base Id for the locks for a particular hwlock device.
> > +			This property is used for representing a set of locks
> > +			present in a hwlock device with a unique base id in
> > +			the driver core. This property is mandatory ONLY if a
> > +			SoC has several hwlock devices.
> > +
> > +			See documentation on struct hwspinlock_pdata in
> > +			linux/hwspinlock.h for more details.

I don't like this, as it seems to be encoding a Linux implementation
detail (the ID of the lock, which means that we have to have a numeric
representation of each hwlock) in the device tree.

I don't see why the ID within Linux should be a concern of the device
tree binding. I think that whatever internal identifier we have in Linux
(be it an integer or struct) should be allocated by Linux. If a driver
needs to request specific hwlocks, then we should have a phandle + args
representation for referring to a specific hwlock that bidnings can use,
and some code for parsing that and returning a Linux-internal
identifier/struct as we do with interrupts and clocks.

> > +
> > +- hwlock-num-locks:	Number of locks present in a hwlock device. This
> > +			property is needed on hwlock devices, where the number
> > +			of supported locks within a hwlock device cannot be
> > +			read from a register.

Hmm... this seems generic, but it doesn't allow for sparse ID spaces on
the hwlock module. It should probably be common for the moment, but if
we encounter a hwlock module with a sparse ID space, we'll need to come
up with a way of handling sparse IDs (that might be device-specific).

> > diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
> > index 461a0d7..aec32e7 100644
> > --- a/drivers/hwspinlock/hwspinlock_core.c
> > +++ b/drivers/hwspinlock/hwspinlock_core.c
> > @@ -1,7 +1,7 @@
> > /*
> >  * Hardware spinlock framework
> >  *
> > - * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com
> > + * Copyright (C) 2010-2013 Texas Instruments Incorporated - http://www.ti.com
> >  *
> >  * Contact: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> >  *
> > @@ -27,6 +27,7 @@
> > #include <linux/hwspinlock.h>
> > #include <linux/pm_runtime.h>
> > #include <linux/mutex.h>
> > +#include <linux/of.h>
> > 
> > #include "hwspinlock_internal.h"
> > 
> > @@ -308,6 +309,64 @@ out:
> > }
> > 
> > /**
> > + * of_hwspin_lock_get_base_id() - OF helper to retrieve base id
> > + * @dn: device node pointer
> > + *
> > + * This is an OF helper function that can be called by the underlying
> > + * platform-specific implementations, to retrieve the base id for the
> > + * set of locks present within a hwspinlock device instance.
> > + *
> > + * Returns the base id value on success, -ENODEV on generic failure or
> > + * an appropriate error code as returned by the OF layer
> > + */
> > +int of_hwspin_lock_get_base_id(struct device_node *dn)
> > +{
> > +	unsigned int val;
> > +	int ret = -ENODEV;
> > +
> > +#ifdef CONFIG_OF
> > +	if (!dn)
> > +		return -ENODEV;
> 
> Checking !dn is done in of_property_read_u32, so you don't need to duplicate
> 
> > +
> > +	ret = of_property_read_u32(dn, "hwlock-base-id", &val);
> > +	if (!ret)
> > +		ret = val;
> > +#endif

Do we need the CONFIG_OF check? of_property_read_u32 is defined to
return -ENOSYS if CONFIG_OF isn't defined. Or would that confuse a
higher layer?

Similarly elsewhere in the file.

Cheers,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
