From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 01/14] OMAP: Introduce a user list for each voltage domain instance in the voltage driver.
Date: Thu, 11 Nov 2010 15:53:25 -0800
Message-ID: <87oc9vs9hm.fsf@deeprootsystems.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
	<1288366708-32302-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45010 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0KKXxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 18:53:30 -0500
Received: by gyh4 with SMTP id 4so1586753gyh.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Nov 2010 15:53:29 -0800 (PST)
In-Reply-To: <1288366708-32302-2-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Fri, 29 Oct 2010 21:08:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch introduces a user list of devices associated with each
> voltage domain instance. The user list is implemented using plist
> structure with priority node populated with the voltage values.
> This patch also adds an API which will take in a device and
> requested voltage as parameters, adds the info to the user list
> and returns back the maximum voltage requested by all the user
> devices. This can be used anytime to get the voltage that the
> voltage domain instance can be transitioned into.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

[...]

> +/**
> + * omap_voltage_add_request() - API to keep track of various requests to
> + *				scale the VDD and returns the best possible
> + *				voltage the VDD can be put to.
> + * @volt_domain:	pointer to the voltage domain.
> + * @dev:		the device pointer.
> + * @volt:		the voltage which is requested by the device.
> + *
> + * This API is to be called before the actual voltage scaling is
> + * done to determine what is the best possible voltage the VDD can
> + * be put to. This API adds the device <dev> in the user list of the
> + * vdd <volt_domain> with <volt> as the requested voltage. The user list
> + * is a plist with the priority element absolute voltage values.
> + * The API then finds the maximum of all the requested voltages for
> + * the VDD and returns it back through <volt> pointer itself.
> + * Returns error value in case of any errors.
> + */
> +int omap_voltage_add_request(struct voltagedomain *voltdm, struct device *dev,
> +		unsigned long *volt)
> +{
> +	struct omap_vdd_info *vdd;
> +	struct omap_vdd_user_list *user;
> +	struct plist_node *node;
> +	int found = 0;
> +
> +	if (!voltdm || IS_ERR(voltdm)) {
> +		pr_warning("%s: VDD specified does not exist!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
> +
> +	mutex_lock(&vdd->scaling_mutex);
> +
> +	plist_for_each_entry(user, &vdd->user_list, node) {
> +		if (user->dev == dev) {
> +			found = 1;

please drop the use of 'found' here.  This can be solved using
a tmp iterator instead:

	struct omap_vdd_user_list *tmp_user, *user = NULL;

	plist_for_each_entry(tmp_user, &vdd->user_list, node)
		if (tmp_user->dev == dev) {
			user = tmp_user;
			break;
		}

> +			break;
> +		}
> +	}
> +
> +	if (!found) {

        if (!user) {

> +		user = kzalloc(sizeof(struct omap_vdd_user_list), GFP_KERNEL);
> +		if (!user) {
> +			pr_err("%s: Unable to creat a new user for vdd_%s\n",
> +				__func__, voltdm->name);
> +			mutex_unlock(&vdd->scaling_mutex);
> +			return -ENOMEM;
> +		}
> +		user->dev = dev;
> +	} else {
> +		plist_del(&user->node, &vdd->user_list);
> +	}
> +
> +	plist_node_init(&user->node, *volt);
> +	plist_add(&user->node, &vdd->user_list);
> +	node = plist_last(&vdd->user_list);

The use of plist_last() doesn't seem right here. Won't plist_last()
return the node with the lowest voltage?, but this function is meant to
return the highest requested voltage.

I guess it currently works because it's only been tested with a single
requested voltage, so first and last are the same thing, but if I
understand the intent of the code correctly, I think it is broken if
ever there is more than one requester.

In [PATCH v2 07/14] OMAP: Introduce dependent voltage domain support, 
plist_first() is used to get the currently requesting node, so that is
what caused the confusion.   One side is using plist_first(), the other
plist_last() so one of them must be wrong.

> +	*volt = user->volt = node->prio;
> +
> +	mutex_unlock(&vdd->scaling_mutex);
> +
> +	return 0;
> +}

The above problems make me think that the 'request' and the 'get' part
of the above function should actually be separated out into two separate
functions.  One to add the request voltage, and another to query the
current max request.

The query function could then be used in patch 07/14 instead of using
plist directly.  That would clear up some of the confusion.

Kevin

