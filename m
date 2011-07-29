From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 08/13] OMAP2+: powerdomain: control power domains next
 state
Date: Fri, 29 Jul 2011 00:59:42 -0700
Message-ID: <20110729075942.GA26959@google.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
 <1311841821-10252-9-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:57380 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758Ab1G2IAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 04:00:21 -0400
Content-Disposition: inline
In-Reply-To: <1311841821-10252-9-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

On Thu, Jul 28, 2011 at 10:30:15AM +0200, jean.pihet@newoldbits.com wrote:
...
> +int pwrdm_set_wkup_lat_constraint(struct powerdomain *pwrdm, void *cookie,
> +				  long min_latency)
> +{
> +	struct pwrdm_wkup_constraints_entry *user = NULL;
> +	struct pwrdm_wkup_constraints_entry *tmp_user, *new_user;
> +	int ret = 0, free_new_user = 0, free_node = 0;
> +	long value = 0;
> +	unsigned long flags;
> +
> +	pr_debug("powerdomain: %s: pwrdm %s, cookie=0x%p, min_latency=%ld\n",
> +		 __func__, pwrdm->name, cookie, min_latency);
> +
> +	new_user = kzalloc(sizeof(struct pwrdm_wkup_constraints_entry),
> +			   GFP_KERNEL);
> +	if (!new_user) {
> +		pr_err("%s: FATAL ERROR: kzalloc failed\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	spin_lock_irqsave(&pwrdm->wkup_lat_plist_lock, flags);
> +
> +	/* Check if there already is a constraint for cookie */
> +	plist_for_each_entry(tmp_user, &pwrdm->wkup_lat_plist_head, node) {
> +		if (tmp_user->cookie == cookie) {
> +			user = tmp_user;
> +			free_new_user = 1;
> +			break;
> +		}
> +	}
> +
> +	if (min_latency != PM_QOS_DEV_LAT_DEFAULT_VALUE) {
> +		/* If nothing to update, job done */
> +		if (user && (user->node.prio == min_latency))
> +			goto exit_ok;
> +
> +		if (!user) {
> +			/* Add new entry to the list */
> +			user = new_user;
> +			user->cookie = cookie;
> +		} else {
> +			/* Update existing entry */
> +			plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
> +		}
> +
> +		plist_node_init(&user->node, min_latency);
> +		plist_add(&user->node, &pwrdm->wkup_lat_plist_head);
> +	} else {
> +		/* Remove the constraint from the list */
> +		if (!user) {
> +			pr_err("%s: Error: no prior constraint to release\n",
> +			       __func__);
> +			ret = -EINVAL;
> +			goto exit_error;
> +		}
> +
> +		plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
> +		free_node = 1;

All min_latency != PM_QOS_DEV_LAT_DEFAULT_VALUE paths need
free_new_user = 1.  (Or maybe change the logic to check user !=
new_user and free new_user if so.)

> +	}
> +
> +exit_ok:
> +	/* Find the strongest constraint from the list */
> +	if (!plist_head_empty(&pwrdm->wkup_lat_plist_head))
> +		value = plist_first(&pwrdm->wkup_lat_plist_head)->prio;
> +
> +	spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags);
> +
> +	if (free_node)
> +		kfree(user);
> +
> +	if (free_new_user)
> +		kfree(new_user);
> +
> +	/* Apply the constraint to the pwrdm */
> +	pr_debug("powerdomain: %s: pwrdm %s, value=%ld\n",
> +		 __func__, pwrdm->name, value);
> +	pwrdm_wakeuplat_update_pwrst(pwrdm, value);
> +
> +	return 0;
> +
> +exit_error:
> +	spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags);

Need:
        kfree(new_user);

> +	return ret;
> +}


Todd
