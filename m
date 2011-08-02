From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 04/13] PM: QoS: implement the per-device latency constraints
Date: Tue, 2 Aug 2011 23:13:47 +0200
Message-ID: <201108022313.47986.rjw@sisk.pl>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com> <201107310030.29286.rjw@sisk.pl> <CAORVsuXzn8wGZsyxUcAN7stjbU4Kshwdg2CW06w17Y5O7oJVsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42487 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755152Ab1HBVMU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Aug 2011 17:12:20 -0400
In-Reply-To: <CAORVsuXzn8wGZsyxUcAN7stjbU4Kshwdg2CW06w17Y5O7oJVsA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

Hi,

On Tuesday, August 02, 2011, Jean Pihet wrote:

...
> >> -static inline void pm_qos_set_value(struct pm_qos_object *o, s32 value)
> >> +static inline void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
> >>  {
> >> -     o->target_value = value;
> >> +     c->target_value = value;
> >>  }
> >
> > Well, I'm not sure that this function is necessary at all.  You might as well
> > simply remove it as far as I'm concerned.
> The idea is to provide an efficient and lockless way to get the
> aggregated constraint class value. When the constraints a re changing
> the new value is calculated and stored using pm_qos_get_value and
> pm_qos_set_value. Then pm_qos_read_value is used to retrieve the
> value. For example cpuidle calls pm_qos_request which uses
> pm_qos_read_value to get the CPU/DMA minimum latency.

Still, pm_qos_set_value() is static in this file and doesn't really serve
any specific purpose except for symmetry with pm_qos_read_value().

Anyway, as I said I'm not sure, so it's OK to leave it as is to me too.

> 
> >
> >> -static void update_target(struct pm_qos_object *o, struct plist_node *node,
> >> -                       int del, int value)
> >> +static void update_target(struct pm_qos_request *req,
> >> +                       enum pm_qos_req_action action, int value)
> >>  {
> >>       unsigned long flags;
> >> -     int prev_value, curr_value;
> >> +     int prev_value, curr_value, new_value;
> >> +     struct pm_qos_object *o = pm_qos_array[req->class];
> >> +     struct pm_qos_constraints *c;
> >> +
> >> +     switch (req->class) {
> >> +     case PM_QOS_DEV_LATENCY:
> >> +             if (!req->dev) {
> >> +                     WARN(1, KERN_ERR "PM QoS API called with NULL dev\n");
> >> +                     return;
> >> +             }
> >> +             c = &req->dev->power.latency_constraints;
> >> +             break;
> >> +     case PM_QOS_CPU_DMA_LATENCY:
> >> +     case PM_QOS_NETWORK_LATENCY:
> >> +     case PM_QOS_NETWORK_THROUGHPUT:
> >> +             c = o->constraints;
> >> +             break;
> >> +     case PM_QOS_RESERVED:
> >> +     default:
> >> +             WARN(1, KERN_ERR "PM QoS API called with wrong class %d, "
> >> +                     "req 0x%p\n", req->class, req);
> >> +             return;
> >> +     }
> >
> > Do we _really_ need that switch()?
> >
> > What about introducing dev_pm_qos_add_request() and friends specifically
> > for devices, such that they will take the target device object (dev) as
> > their first argument?  Then, you could keep pm_qos_add_request() pretty
> > much as is, right?
> Yes but in that case I need to duplicate the API functions for devices
> (add, update, remove). Those functions will call update_target.
> I prefer the way this patch does it: simplify the API functions and
> have only 1 place with the constraints management and notification
> logic (in update_target).

The device functions would still call update_target(), but directly on the
device's struct struct pm_qos_constraints, so they wouldn't really duplicate
the existing pm_qos_*_request().

> 
> >
> >>
> >>       spin_lock_irqsave(&pm_qos_lock, flags);
> >> -     prev_value = pm_qos_get_value(o);
> >> -     /* PM_QOS_DEFAULT_VALUE is a signal that the value is unchanged */
> >> -     if (value != PM_QOS_DEFAULT_VALUE) {
> >> +
> >> +     prev_value = pm_qos_get_value(c);
> >> +     if (value == PM_QOS_DEFAULT_VALUE)
> >> +             new_value = c->default_value;
> >> +     else
> >> +             new_value = value;
> >
> > What about writing that as
> >
> >        new_value = value != PM_QOS_DEFAULT_VALUE ? value : c->default_value;
> This is shorter but more difficult to read ;8

That depends on who you ask. :-)

> >
> >> +
> >> +     switch (action) {
> >> +     case PM_QOS_REMOVE_REQ:
> >> +             plist_del(&req->node, &c->list);
> >> +             break;
> >> +     case PM_QOS_UPDATE_REQ:
> >>               /*
> >>                * to change the list, we atomically remove, reinit
> >>                * with new value and add, then see if the extremal
> >>                * changed
> >>                */
> >> -             plist_del(node, &o->requests);
> >> -             plist_node_init(node, value);
> >> -             plist_add(node, &o->requests);
> >> -     } else if (del) {
> >> -             plist_del(node, &o->requests);
> >> -     } else {
> >> -             plist_add(node, &o->requests);
> >> +             plist_del(&req->node, &c->list);
> >> +     case PM_QOS_ADD_REQ:
> >> +             plist_node_init(&req->node, new_value);
> >> +             plist_add(&req->node, &c->list);
> >> +             break;
> >> +     default:
> >> +             /* no action */
> >> +             ;
> >>       }
> >> -     curr_value = pm_qos_get_value(o);
> >> -     pm_qos_set_value(o, curr_value);
> >> +
> >> +     curr_value = pm_qos_get_value(c);
> >> +     pm_qos_set_value(c, curr_value);
> >>       spin_unlock_irqrestore(&pm_qos_lock, flags);
> >>
> >>       if (prev_value != curr_value)
> >>               blocking_notifier_call_chain(o->notifiers,
> >
> > That's why I'm thinking that it would be helpful to have a pointer
> > to the notifier list from struct pm_qos_constraints .
> I think having a per-device notifier list is complicating things. If a
> subsystem needs te be notified it needs to register a notifier
> callback for _every_ device in the system.

I'm not really sure.  For example, why would a video subsystem want to be
notified of a PM QoS change in a keyboard?

> As a first implementation for OMAP the low-level PM code is using a
> single notifier to retrieve all the devices latency constraints and
> apply them to the pwer domains. I do not see how this could work with
> a per-device notifier list.

If you need a global notifier chain, it can be implemented as a separate
static variable as I said in my last reply in the [03/13] thread.

> 
> >
> > Besides, you can use "pm_qos_array[req->class]->notifiers" instead of
> > "o->notifiers".
> Ok
> 
> ...
> >> +static int find_pm_qos_object_by_minor(int minor)
> >> +{
> >> +     int pm_qos_class;
> >> +
> >> +     for (pm_qos_class = 0;
> >> +             pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
> >> +             if (minor ==
> >> +                     pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
> >> +                     return pm_qos_class;
> >> +     }
> >> +     return -1;
> >> +}
> >
> > This function doesn't seem to be used anywhere, what's the purpose of it?
> It is used by pm_qos_power_open in order to retrieve the class
> associated with the MISC device.
> BTW this patch is moving the code so that all the MISC related
> functions are grouped together.

OK, one more thing that needs to be done in a separate patch. :-)

Thanks,
Rafael
