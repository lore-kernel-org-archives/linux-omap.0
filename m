From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain instance in the voltage driver.
Date: Fri, 03 Sep 2010 09:41:11 -0700
Message-ID: <87r5ha3hlk.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
	<87eiddgjr7.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64923 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910Ab0ICQlQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 12:41:16 -0400
Received: by qwh6 with SMTP id 6so1933217qwh.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Sep 2010 09:41:16 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Fri, 3 Sep 2010 12:39:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

+ Mark, Liam for regulator questions, thread in archives here:
  http://marc.info/?l=linux-omap&m=128349777617270&w=2

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>Sent: Thursday, September 02, 2010 4:22 AM
>>>To: Gopinath, Thara
>>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Sripathy, Vishwanath; Sawant, Anand; Cousson, Benoit;
>>>thomas.petazzoni@free-electrons.com
>>>Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain instance in the
>>>voltage driver.
>>>
>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> This patch introduces a user list of devices associated with each
>>>> voltage domain instance. The user list is implemented using plist
>>>> structure with priority node populated with the voltage values.
>>>> This patch also adds an API which will take in a device and
>>>> requested voltage as parameters, adds the info to the user list
>>>> and returns back the maximum voltage requested by all the user
>>>> devices. This can be used anytime to get the voltage that the
>>>> voltage domain instance can be transitioned into.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>>
>>>Looking closer at this, keeping track of a list of devices and
>>>constraints is what the regulator framework does as well.
>>>
>>>Before we get too far down this path, we need to start working with
>>>Thomas Petazzoni to better understand how we can use the regulator
>>>framework for much of the management levels of the voltage layer.
>>>
>>>I'd rather not re-invent some of the management/constraints management
>>>that could be done by the regulator framework.
>>>
>>>Basically, I think
>>>
>>>  r = regulator_get(dev, voltdm->name)
>>>  regulator_set_voltage(r, volt)
>>>
>>>would basially be the equivalent of
>>>
>>>  omap_voltage_add_userreq(voldm, dev, &volt);
>>>  omap_scale_voltage(voltdm, volt)
>
> Hello Kevin,
>
> Let me startr off by saying that I am not an expert on regulator
> framework and hence my assessment below could be wrong.
> I agree probably regulator framework would be 
> the best place for this but then IMO regulator framework needs a lot of
> changes to support the kind of use-counting we need in the voltage layer.
> To start with regulator_get  keeps the use counting only for enabling or
> disabling a regulator. It does not have a mechanism of adding the requested
> voltage to a list and picking out the highest among the added values.

Like you, I'm no expert on the regulator framework internals, but it
appears to have a pretty thorough system of constraints management that
upon first glance seems to be a good fit for what we need.  It may need
to be extended, but I would rather see us enhance the regulator
framework than re-invent the constraints management.

> regulator_set_voltage could be used to route the call to omap_scale_voltage
> but then it is just a wrapper.

Yes, just a wrapper, but users would be then using a a well defined and
well documented API.

Kevin

