From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH] PM: OPP: introduce function to free cpufreq table
Date: Mon, 23 May 2011 17:05:49 -0700
Message-ID: <20110524000549.GA20225@google.com>
References: <1306192335-19883-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:15644 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883Ab1EXAHL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 May 2011 20:07:11 -0400
Content-Disposition: inline
In-Reply-To: <1306192335-19883-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, May 23, 2011 at 06:12:15PM -0500, Nishanth Menon wrote:
> cpufreq table allocated by opp_init_cpufreq_table is better
> freed by OPP layer itself. This allows future modifications to
> the table handling to be transparent to the users.
...
> +void opp_free_cpufreq_table(struct device *dev,
> +				struct cpufreq_frequency_table **table)
> +{
> +	if (!table)
> +		return;
> +
> +	/* Pretend as if I am an updater */
> +	mutex_lock(&dev_opp_list_lock);
> +	kfree(*table);
> +	*table = NULL;
> +	mutex_unlock(&dev_opp_list_lock);
> +}

Not clear what the mutex protects here.  Currently it protects only
device opp list modifications.  opp_init_cpufreq_table holds the lock only
while looking up and walking the device opp list; the cpufreq table it
creates is not complete by the time the lock is dropped.


Todd
