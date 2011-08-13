From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/15] PM QoS: generalize and export the constraints management code
Date: Sat, 13 Aug 2011 22:34:17 +0200
Message-ID: <201108132234.17377.rjw@sisk.pl>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com> <1313075212-8366-6-git-send-email-j-pihet@ti.com> <20110813030937.GE639@gvim.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39255 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab1HMUci (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 13 Aug 2011 16:32:38 -0400
In-Reply-To: <20110813030937.GE639@gvim.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: markgross@thegnar.org
Cc: jean.pihet@newoldbits.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Saturday, August 13, 2011, mark gross wrote:
> On Thu, Aug 11, 2011 at 05:06:42PM +0200, jean.pihet@newoldbits.com wrote:
> > From: Jean Pihet <j-pihet@ti.com>
> > 
> > In preparation for the per-device constratins support:
> > - rename update_target to pm_qos_update_target
> > - generalize and export pm_qos_update_target for usage by the upcoming
> > per-device latency constraints framework:
> >    . operate on struct pm_qos_constraints for constraints management,
> >    . introduce an 'action' parameter for constraints add/update/remove,
> >    . the return value indicates if the aggregated constraint value has
> >      changed,
> > - update the internal code to operate on struct pm_qos_constraints
> > - add a NULL pointer check in the API functions
> > 
> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
> > 
> > ---
> >  include/linux/pm_qos.h |   14 ++++++
> >  kernel/power/qos.c     |  123 ++++++++++++++++++++++++++----------------------
> >  2 files changed, 81 insertions(+), 56 deletions(-)
> > 
> > diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> > index 9772311..84aa150 100644
> > --- a/include/linux/pm_qos.h
> > +++ b/include/linux/pm_qos.h
> > @@ -44,7 +44,16 @@ struct pm_qos_constraints {
> >  	struct blocking_notifier_head *notifiers;
> >  };
> >  
> > +/* Action requested to pm_qos_update_target */
> > +enum pm_qos_req_action {
> > +	PM_QOS_ADD_REQ,		/* Add a new request */
> > +	PM_QOS_UPDATE_REQ,	/* Update an existing request */
> > +	PM_QOS_REMOVE_REQ	/* Remove an existing request */
> > +};
> > +
> 
> What do you need this enum for?  The function names *_update_*, *_add_*,
> and  *_remove_* seem to be pretty redundant if you have to pass an enum
> that could possibly conflict with the function name.
> 
> >  #ifdef CONFIG_PM
> > +int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
> > +			 enum pm_qos_req_action action, int value);
> The action for update_target better damn well be "PM_QOS_UPDATE_REQ" or
> there is something strange going on....  BTW what shold this function do
> if the pm_qos_req_action was *not* the UPDATE one?
> 
> 
> pm_qos_update_target should be a static to the C- file along with the
> enum pm_qos_req_action.
> 
> 
> >  void pm_qos_add_request(struct pm_qos_request *req, int pm_qos_class,
> >  			s32 value);
> >  void pm_qos_update_request(struct pm_qos_request *req,
> > @@ -56,6 +65,11 @@ int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
> >  int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
> >  int pm_qos_request_active(struct pm_qos_request *req);
> >  #else
> > +static inline int pm_qos_update_target(struct pm_qos_constraints *c,
> > +				       struct plist_node *node,
> > +				       enum pm_qos_req_action action,
> > +				       int value)
> > +			{ return 0; }
> >  static inline void pm_qos_add_request(struct pm_qos_request *req,
> >  				      int pm_qos_class, s32 value)
> >  			{ return; }
> > diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> > index 66e8d6f..fc60f96 100644
> > --- a/kernel/power/qos.c
> > +++ b/kernel/power/qos.c
> > @@ -121,17 +121,17 @@ static const struct file_operations pm_qos_power_fops = {
> >  };
> >  
> >  /* unlocked internal variant */
> > -static inline int pm_qos_get_value(struct pm_qos_object *o)
> > +static inline int pm_qos_get_value(struct pm_qos_constraints *c)
> >  {
> > -	if (plist_head_empty(&o->constraints->list))
> > -		return o->constraints->default_value;
> > +	if (plist_head_empty(&c->list))
> > +		return c->default_value;
> >  
> > -	switch (o->constraints->type) {
> > +	switch (c->type) {
> >  	case PM_QOS_MIN:
> > -		return plist_first(&o->constraints->list)->prio;
> > +		return plist_first(&c->list)->prio;
> >  
> >  	case PM_QOS_MAX:
> > -		return plist_last(&o->constraints->list)->prio;
> > +		return plist_last(&c->list)->prio;
> >  
> >  	default:
> >  		/* runtime check for not using enum */
> > @@ -139,47 +139,73 @@ static inline int pm_qos_get_value(struct pm_qos_object *o)
> >  	}
> >  }
> >  
> > -static inline s32 pm_qos_read_value(struct pm_qos_object *o)
> > +static inline s32 pm_qos_read_value(struct pm_qos_constraints *c)
> >  {
> > -	return o->constraints->target_value;
> > +	return c->target_value;
> >  }
> >  
> > -static inline void pm_qos_set_value(struct pm_qos_object *o, s32 value)
> > +static inline void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
> >  {
> > -	o->constraints->target_value = value;
> > +	c->target_value = value;
> >  }
> >  
> > -static void update_target(struct pm_qos_object *o, struct plist_node *node,
> > -			  int del, int value)
> > +/**
> > + * pm_qos_update_target - manages the constraints list and calls the notifiers
> > + *  if needed
> > + * @c: constraints data struct
> > + * @node: request to add to the list, to update or to remove
> > + * @action: action to take on the constraints list
> > + * @value: value of the request to add or update
> > + *
> > + * This function returns 1 if the aggregated constraint value has changed, 0
> > + *  otherwise.
> > + */
> > +int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
> > +			 enum pm_qos_req_action action, int value)
> >  {
> >  	unsigned long flags;
> > -	int prev_value, curr_value;
> > +	int prev_value, curr_value, new_value;
> >  
> >  	spin_lock_irqsave(&pm_qos_lock, flags);
> > -	prev_value = pm_qos_get_value(o);
> > -	/* PM_QOS_DEFAULT_VALUE is a signal that the value is unchanged */
> > -	if (value != PM_QOS_DEFAULT_VALUE) {
> > +	prev_value = pm_qos_get_value(c);
> > +	if (value == PM_QOS_DEFAULT_VALUE)
> > +		new_value = c->default_value;
> > +	else
> > +		new_value = value;
> > +
> > +	switch (action) {
> > +	case PM_QOS_REMOVE_REQ:
> We have a remove request API already.  This overloading of this
> interface feels wrong to me.
> 
> > +		plist_del(node, &c->list);
> > +		break;
> > +	case PM_QOS_UPDATE_REQ:
> >  		/*
> >  		 * to change the list, we atomically remove, reinit
> >  		 * with new value and add, then see if the extremal
> >  		 * changed
> >  		 */
> > -		plist_del(node, &o->constraints->list);
> > -		plist_node_init(node, value);
> > -		plist_add(node, &o->constraints->list);
> > -	} else if (del) {
> > -		plist_del(node, &o->constraints->list);
> > -	} else {
> > -		plist_add(node, &o->constraints->list);
> > +		plist_del(node, &c->list);
> > +	case PM_QOS_ADD_REQ:
> Don't we have an API for adding a request?  if you want to overload
> update like this then either we lose the add API or this shouldn't be
> here.
> 
> 
> > +		plist_node_init(node, new_value);
> > +		plist_add(node, &c->list);
> > +		break;
> > +	default:
> > +		/* no action */
> > +		;
> >  	}
> > -	curr_value = pm_qos_get_value(o);
> > -	pm_qos_set_value(o, curr_value);
> > +
> > +	curr_value = pm_qos_get_value(c);
> > +	pm_qos_set_value(c, curr_value);
> > +
> >  	spin_unlock_irqrestore(&pm_qos_lock, flags);
> >  
> > -	if (prev_value != curr_value)
> > -		blocking_notifier_call_chain(o->constraints->notifiers,
> > +	if (prev_value != curr_value) {
> > +		blocking_notifier_call_chain(c->notifiers,
> >  					     (unsigned long)curr_value,
> >  					     NULL);
> > +		return 1;
> > +	} else {
> > +		return 0;
> > +	}
> >  }
> >  
> >  /**
> > @@ -190,7 +216,7 @@ static void update_target(struct pm_qos_object *o, struct plist_node *node,
> >   */
> >  int pm_qos_request(int pm_qos_class)
> >  {
> > -	return pm_qos_read_value(pm_qos_array[pm_qos_class]);
> > +	return pm_qos_read_value(pm_qos_array[pm_qos_class]->constraints);
> >  }
> >  EXPORT_SYMBOL_GPL(pm_qos_request);
> >  
> > @@ -216,20 +242,16 @@ EXPORT_SYMBOL_GPL(pm_qos_request_active);
> >  void pm_qos_add_request(struct pm_qos_request *req,
> >  			int pm_qos_class, s32 value)
> >  {
> > -	struct pm_qos_object *o =  pm_qos_array[pm_qos_class];
> > -	int new_value;
> > +	if (!req) /*guard against callers passing in null */
> > +		return;
> >  
> >  	if (pm_qos_request_active(req)) {
> >  		WARN(1, KERN_ERR "pm_qos_add_request() called for already added request\n");
> >  		return;
> >  	}
> > -	if (value == PM_QOS_DEFAULT_VALUE)
> > -		new_value = o->constraints->default_value;
> > -	else
> > -		new_value = value;
> > -	plist_node_init(&req->node, new_value);
> >  	req->pm_qos_class = pm_qos_class;
> > -	update_target(o, &req->node, 0, PM_QOS_DEFAULT_VALUE);
> > +	pm_qos_update_target(pm_qos_array[pm_qos_class]->constraints,
> > +			     &req->node, PM_QOS_ADD_REQ, value);
> 
> Ok, using pm_qos_update_target to reduce the LOC is ok but I don't think
> this function and the enum should be exported outside of pm_qos.c

They are used by the next patches adding the per-device QoS.

Thanks,
Rafael
