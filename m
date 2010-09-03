From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 01/13] OMAP: Introduce a user list for each voltage
 domain instance in the voltage driver.
Date: Fri, 3 Sep 2010 12:39:21 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
 <87eiddgjr7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46628 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064Ab0ICHJe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 03:09:34 -0400
In-Reply-To: <87eiddgjr7.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, September 02, 2010 4:22 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Sripathy, Vishwanath; Sawant, Anand; Cousson, Benoit;
>>thomas.petazzoni@free-electrons.com
>>Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain instance in the
>>voltage driver.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch introduces a user list of devices associated with each
>>> voltage domain instance. The user list is implemented using plist
>>> structure with priority node populated with the voltage values.
>>> This patch also adds an API which will take in a device and
>>> requested voltage as parameters, adds the info to the user list
>>> and returns back the maximum voltage requested by all the user
>>> devices. This can be used anytime to get the voltage that the
>>> voltage domain instance can be transitioned into.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>Looking closer at this, keeping track of a list of devices and
>>constraints is what the regulator framework does as well.
>>
>>Before we get too far down this path, we need to start working with
>>Thomas Petazzoni to better understand how we can use the regulator
>>framework for much of the management levels of the voltage layer.
>>
>>I'd rather not re-invent some of the management/constraints management
>>that could be done by the regulator framework.
>>
>>Basically, I think
>>
>>  r = regulator_get(dev, voltdm->name)
>>  regulator_set_voltage(r, volt)
>>
>>would basially be the equivalent of
>>
>>  omap_voltage_add_userreq(voldm, dev, &volt);
>>  omap_scale_voltage(voltdm, volt)

Hello Kevin,

Let me startr off by saying that I am not an expert on regulator
framework and hence my assessment below could be wrong.
I agree probably regulator framework would be 
the best place for this but then IMO regulator framework needs a lot of
changes to support the kind of use-counting we need in the voltage layer.
To start with regulator_get  keeps the use counting only for enabling or
disabling a regulator. It does not have a mechanism of adding the requested
voltage to a list and picking out the highest among the added values.
regulator_set_voltage could be used to route the call to omap_scale_voltage
but then it is just a wrapper.

Regards
Thara
