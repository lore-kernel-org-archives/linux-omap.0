From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 04/13] OMAP: Introduce API to return a device list associated with a voltage domain
Date: Thu, 16 Sep 2010 08:22:23 -0700
Message-ID: <874odpems0.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-5-git-send-email-thara@ti.com>
	<87y6brblt3.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03294424C1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56415 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761Ab0IPPWc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 11:22:32 -0400
Received: by pvg2 with SMTP id 2so366962pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 08:22:32 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03294424C1@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Thu, 16 Sep 2010 15:34:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>> +struct device **opp_init_voltage_params(struct voltagedomain *voltdm,
>>>> +					int *dev_count)
>>>> +{
>>>> +	struct device_opp *dev_opp;
>>>> +	struct device **dev_list;
>>>> +	int count = 0, i = 0;
>>>> +
>>>> +	list_for_each_entry(dev_opp, &dev_opp_list, node) {
>>>> +		if (!dev_opp->oh->vdd_name)
>>>> +			continue;
>>>> +
>>>> +		if (!strcmp(dev_opp->oh->vdd_name, voltdm->name)) {
>>>> +			dev_opp->oh->voltdm = voltdm;
>>>
>>>Couldn't we assign the voltdm at opp_add() time since you added it as
>>>part of the hwmod?
>
> We cannot as the voltage layer is not initialized at the point of opp_add.
> Having said this, today voltage layer is dependent on opp layer only to figure out 
> the current nominal voltage from the opp table. If that can be some how decoupled we
> can initialize voltage layer early on and implement this.

We could decouple the voltage init into and early init and late init to
handle this.

Kevin
