From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 01/13] OMAP: Introduce a user list for each voltage
 domain instance in the voltage driver.
Date: Fri, 17 Sep 2010 20:03:59 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0329539FD6@dbde02.ent.ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
	<87iq2vipe7.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03294424BB@dbde02.ent.ti.com>
 <87bp7xemv7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58969 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602Ab0IQOeG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 10:34:06 -0400
In-Reply-To: <87bp7xemv7.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, September 16, 2010 8:50 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Sripathy, Vishwanath; Sawant, Anand; Cousson, Benoit
>>Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain instance in the
>>voltage driver.
>>
>>"Gopinath, Thara" <thara@ti.com> writes:
>>
>>[...]
>>
>>>>>> + * omap_voltage_add_userreq : API to keep track of various requests to
>>>>>> + *			    scale the VDD and returns the best possible
>>>>>> + *			    voltage the VDD can be put to.
>>>>>> + * @volt_domain: pointer to the voltage domain.
>>>>>> + * @dev : the device pointer.
>>>>>> + * @volt : the voltage which is requested by the device.
>>>>>> + *
>>>>>> + * This API is to be called before the actual voltage scaling is
>>>>>> + * done to determine what is the best possible voltage the VDD can
>>>>>> + * be put to. This API adds the device <dev> in the user list of the
>>>>>> + * vdd <volt_domain> with <volt> as the requested voltage. The user list
>>>>>> + * is a plist with the priority element absolute voltage values.
>>>>>> + * The API then finds the maximum of all the requested voltages for
>>>>>> + * the VDD and returns it back through <volt> pointer itself.
>>>>>> + * Returns error value in case of any errors.
>>>>>> + */
>>>>>> +int omap_voltage_add_userreq(struct voltagedomain *voltdm, struct device *dev,
>>>>>> +		unsigned long *volt)
>>>>>
>>>>>How about just omap_voltage_add_request()
>>>>>
>>>>>Also, do we need both voltdm and dev?  With your other patches, can't we
>>>>>look up the voltm based on dev?  Or, is there a need for a device to add
>>>>>a request in a voltage domain other than the one to which it belongs?
>>>>>
>>>>>Also, how does one remove a voltage request?
>>>
>>> Hello Kevin,
>>>
>>> I could rename this API to what you have suggested. Yes we do need voltdm and dev.
>>> Let us say I have three devices in a voltdm and I need to maintain a request for each
>>> of these devices.
>>
>>OK, thanks for clarifying.
>>
>>> When a omap_device_set_rate API is called by the device to lower its rate the voltage
>>> request will automatically get lowered.
>>
>>OK, but what about removing a request when a device no longer has any
>>voltage constraints.
Hi Kevin,

The devices will use omap_device_set_rate to lower their frequency.
This will in turn call the use counting API in voltage layer and add
which in turn will remove the old request for the device and add the new
request which will be for a lower voltage. Hence releasing gets taken
care of.

Regards
Thara

