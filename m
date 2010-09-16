From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain instance in the voltage driver.
Date: Thu, 16 Sep 2010 08:20:28 -0700
Message-ID: <87bp7xemv7.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
	<87iq2vipe7.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03294424BB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54797 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab0IPPUj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 11:20:39 -0400
Received: by pwi3 with SMTP id 3so440078pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 08:20:38 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03294424BB@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Thu, 16 Sep 2010 15:29:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>> + * omap_voltage_add_userreq : API to keep track of various requests to
>>>> + *			    scale the VDD and returns the best possible
>>>> + *			    voltage the VDD can be put to.
>>>> + * @volt_domain: pointer to the voltage domain.
>>>> + * @dev : the device pointer.
>>>> + * @volt : the voltage which is requested by the device.
>>>> + *
>>>> + * This API is to be called before the actual voltage scaling is
>>>> + * done to determine what is the best possible voltage the VDD can
>>>> + * be put to. This API adds the device <dev> in the user list of the
>>>> + * vdd <volt_domain> with <volt> as the requested voltage. The user list
>>>> + * is a plist with the priority element absolute voltage values.
>>>> + * The API then finds the maximum of all the requested voltages for
>>>> + * the VDD and returns it back through <volt> pointer itself.
>>>> + * Returns error value in case of any errors.
>>>> + */
>>>> +int omap_voltage_add_userreq(struct voltagedomain *voltdm, struct device *dev,
>>>> +		unsigned long *volt)
>>>
>>>How about just omap_voltage_add_request()
>>>
>>>Also, do we need both voltdm and dev?  With your other patches, can't we
>>>look up the voltm based on dev?  Or, is there a need for a device to add
>>>a request in a voltage domain other than the one to which it belongs?
>>>
>>>Also, how does one remove a voltage request?
>
> Hello Kevin,
>
> I could rename this API to what you have suggested. Yes we do need voltdm and dev.
> Let us say I have three devices in a voltdm and I need to maintain a request for each
> of these devices.

OK, thanks for clarifying.

> When a omap_device_set_rate API is called by the device to lower its rate the voltage
> request will automatically get lowered.

OK, but what about removing a request when a device no longer has any
voltage constraints. 

[...]

Kevin
