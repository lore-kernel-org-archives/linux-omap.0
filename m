From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 03/13] PM: QoS: extend the in-kernel API with per-device latency constraints
Date: Tue, 2 Aug 2011 23:02:59 +0200
Message-ID: <201108022302.59637.rjw@sisk.pl>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com> <201107300055.49468.rjw@sisk.pl> <CAORVsuVY63VYGEB7CM50UzJS3wLt+jZn5U6S9X+277GB_ETV1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42460 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313Ab1HBVCC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Aug 2011 17:02:02 -0400
In-Reply-To: <CAORVsuVY63VYGEB7CM50UzJS3wLt+jZn5U6S9X+277GB_ETV1g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

Hi,

On Tuesday, August 02, 2011, Jean Pihet wrote:
...
> I will keep pm_qos_class if the rename brings in some confusion. The
> intention was to simplify the names of the fields in structs with
> explicit names.

Please keep it for now.  You can rename it later if there's a clear
benefit, but I'm not sure still.

> >
> >> +     struct device *dev;
> >>  };
> >>
> >> -void pm_qos_add_request(struct pm_qos_request_list *l, int pm_qos_class, s32 value);
> >> -void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
> >> -             s32 new_value);
> >> -void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req);
> >> +struct pm_qos_parameters {
> >> +     int class;
> >> +     struct device *dev;
> >> +     s32 value;
> >> +};
> >
> > What exactly is the "dev" member needed for?
> This is the target device that is passed as parameter to the API. It
> is used for constraints of the devices latency class.

Well, I don't like this change.

In fact, I'd prefer it if the old interface were kept unmodified.

> ...
> >> +static BLOCKING_NOTIFIER_HEAD(dev_lat_notifier);
> >> +static struct pm_qos_object dev_pm_qos = {
> >> +     .requests = PLIST_HEAD_INIT(dev_pm_qos.requests, pm_qos_lock),
> >> +     .notifiers = &dev_lat_notifier,
> >> +     .name = "dev_latency",
> >> +     .target_value = PM_QOS_DEV_LAT_DEFAULT_VALUE,
> >> +     .default_value = PM_QOS_DEV_LAT_DEFAULT_VALUE,
> >> +     .type = PM_QOS_MIN,
> >> +};
> >> +
> >
> > You seem to be confusing things here.  Since devices will have their own lists
> > of requests now (as per the previous patch), the .requests member above is not
> > necessary.  Moreover, it seems to be used incorrectly below.
> The idea was to split the patches as requested previously: first the
> API changes (this very patch [03/13]) and then the actual
> implementation ([04/13]). Is this correct?

The idea is right in general, but so to speak it didn't work out too well.

The most important change is the introduction of struct pm_qos_constraints,
which doesn't need any preparation IMO.  I'd do this possibly early in the
series and I'd do it like this:

+struct pm_qos_constraints {
+       struct plist_head list;
+       s32 target_value;
+       s32 default_value;
+       struct blocking_notifier_head *notifiers;
+};

(more on the notifiers later).  Please note the lack of the type field.

At the same time I'd redefine struct pm_qos_object in the following way:

 struct pm_qos_object {
-       struct plist_head requests;
+       struct pm_qos_constraints *constraints;
-       struct blocking_notifier_head *notifiers;
        struct miscdevice pm_qos_power_miscdev;
        char *name;
-       s32 target_value;       /* Do not change to 64 bit */
-       s32 default_value;
        enum pm_qos_type type;
 };

so for the _existing_ PM QoS classes you can simply use
constraints->list instead of requests, constraints->target_value
instead of target_value, constraints->defaul_value instead of default_value
and constraints->notifiers instead of notifiers.

I wouldn't introduce a "global" PM QoS class for devices.

That should be a relatively simple patch that doesn't change the
existing interface and functionality.

The next patch would be to modify update_target() so that it takes
a pointer to struct pm_qos_constraints instead of the pointers to
struct pm_qos_object and struct plist_node (possibly also to take
an "operation" argument instead of the "del" one).  All it needs is
in struct pm_qos_constraints, so that should be simple too.
The modified update_target() should return a value indicating
whether or not prev_value was different from curr_value, so that
the device PM QoS functions (introduced by the next patch) can use it
to trigger system-wide notifications.

The next patch would introduce the per-device PM QoS by (1) adding
a struct pm_qos_constraints _pointer_ to struct dev_pm_info (assuming
that at least _some_ devices won't use PM QoS) and (2) adding
dev_pm_qos_add/update/remove_request() in drivers/base/power/qos.c,
all of them using the modified update_target().

Now if system-wide notifier chain for devices is necessary, you can
simply define it as a static variable in drivers/base/power/qos.c
without actually adding any "PM QoS object" for this purpose.  Now,
you can use the value returned by the modified update_target() to
decide whether or not to run notifiers from dev_pm_qos_*_request().

Does it make sense to you?

Rafael
