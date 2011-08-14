From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 06/15] PM QoS: implement the per-device PM QoS constraints
Date: Sun, 14 Aug 2011 15:51:21 +0200
Message-ID: <201108141551.21449.rjw@sisk.pl>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com> <201108132308.26265.rjw@sisk.pl> <CAORVsuVZjrqY0qhEvCpRRvt5RDcG-YT5SJo6Ejhyr-_fTyk9HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40056 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252Ab1HNNtl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 14 Aug 2011 09:49:41 -0400
In-Reply-To: <CAORVsuVZjrqY0qhEvCpRRvt5RDcG-YT5SJo6Ejhyr-_fTyk9HQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi,

On Sunday, August 14, 2011, Jean Pihet wrote:
...
> >> +
> >> +     if (dev_pm_qos_request_active(req)) {
> >> +             WARN(1, KERN_ERR "dev_pm_qos_add_request() called for already "
> >> +                     "added request\n");
> >> +             return;
> >> +     }
> >> +     req->dev = dev;
> >> +
> >> +     /* Allocate the constraints struct on the first call to add_request */
> >> +     if (req->dev->power.constraints_state == DEV_PM_QOS_DEVICE_PRESENT)
> >> +             dev_pm_qos_constraints_allocate(dev);
> >
> > Why not to do
> >
> > +       if (!req->dev->power.constraints)
> > +               dev_pm_qos_constraints_allocate(dev);
> 
> Cf. my comments at the end of this message for the data structs
> alloc/free and the locking.
> 
> >
> >> +
> >> +     /* Silently return if the device has been removed */
> >> +     if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
> >> +             return;
> >> +
> >
> > Hmm.  What will happen if two callers run dev_pm_qos_add_request()
> > concurrently for the same device?
> update_target is using the power.lock to protect the constraints lists changes.

I was referring to the scenario in particular:

Suppose that there are no constraits for dev initially.
A -> calls dev_pm_qos_add_request(dev)
B -> calls dev_pm_qos_add_request(dev)
A -> sees power.constraints_state == DEV_PM_QOS_DEVICE_PRESENT
     and calls dev_pm_qos_constraints_allocate(dev)
B -> sees power.constraints_state == DEV_PM_QOS_DEVICE_PRESENT
     and calls dev_pm_qos_constraints_allocate(dev)

As a result, the structure allocated by A is leaked.

...
> 
> Your remarks are inline with the concerns I had about the adata
> structs alloc/free and the locking.
> 
> 1) data structs alloc/free
> As described in the changelog:
> >> To minimize the data usage by the per-device constraints, the data struct
> >> is only allocated at the first call to dev_pm_qos_add_request.
> >> The data is later free'd when the device is removed from the system.
> A basic state machine is needed in order to allocate the data at the
> first call to add_request and free it when the device is removed.
> Another option is to allocate the data when the device is added to the
> system and free it when the device is removed. That would make the
> code simpler but it is using a lot of memory for unneeded data.

That's fine.  You simply need to be more careful about the possible
race conditions when the constraints objects are created and destroyed.

> 2) Race conditions
> I will add a lock to isolate the API callers from
> dev_pm_qos_constraints_destroy().
> The power.lock is already used by update_target so another lock is
> needed to protect the data allocation/free.

OK

> I will rework this tomorrow and re-submit asap when it is ready.
> Is that OK?

Yes, it is.

Thanks,
Rafael
