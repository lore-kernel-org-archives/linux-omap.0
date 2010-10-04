From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v5] power: introduce library for device-specific OPPs
Date: Tue, 5 Oct 2010 00:45:27 +0200
Message-ID: <201010050045.27969.rjw@sisk.pl>
References: <1285933174-24053-1-git-send-email-nm@ti.com> <201010050036.23179.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44122 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672Ab0JDWqV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Oct 2010 18:46:21 -0400
In-Reply-To: <201010050036.23179.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Paul <paulmck@linux.vnet.ibm.com>, Kevin H <khilman@deeprootsystems.com>

On Tuesday, October 05, 2010, Rafael J. Wysocki wrote:
> On Friday, October 01, 2010, Nishanth Menon wrote:
...
> > +int opp_init_cpufreq_table(struct device *dev,
> > +			    struct cpufreq_frequency_table **table)
> > +{
> > +	struct device_opp *dev_opp;
> > +	struct opp *opp;
> > +	struct cpufreq_frequency_table *freq_table;
> > +	int i = 0;
> > +
> > +	rcu_read_lock();
> 
> I would pretend I'm an updater here and acquire dev_opp_list_lock instead.
> 
> > +	dev_opp = find_device_opp(dev);
> > +	if (IS_ERR(dev_opp)) {
> > +		rcu_read_unlock();
> 
> So that won't be necessary.

Or rather the lock will have to be dropped here instead.

> > +		pr_warning("Unable to find device\n");
> > +		return PTR_ERR(dev_opp);
> > +	}
> > +

Thanks,
Rafael
