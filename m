From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 05/13] OMAP: Introduce device specific set rate and get rate in device opp structures.
Date: Mon, 20 Sep 2010 10:35:13 -0700
Message-ID: <87vd60xqr2.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-6-git-send-email-thara@ti.com>
	<87fwxrzpan.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03294424DF@dbde02.ent.ti.com>
	<87aanhd7xj.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0329539FDE@dbde02.ent.ti.com>
	<4C9490B9.7090002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:37215 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab0ITRfQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 13:35:16 -0400
Received: by pxi10 with SMTP id 10so1217848pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Sep 2010 10:35:16 -0700 (PDT)
In-Reply-To: <4C9490B9.7090002@ti.com> (Benoit Cousson's message of "Sat, 18
	Sep 2010 12:13:13 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Gopinath, Thara" <thara@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Thara,
>
> On 9/17/2010 4:55 PM, Gopinath, Thara wrote:
>>
>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>> Sent: Thursday, September 16, 2010 8:58 PM
>>>>
>>>> "Gopinath, Thara"<thara@ti.com>  writes:
>>>>
>>>>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>>>>> Sent: Friday, September 03, 2010 5:12 AM
>>>>>>>
>>>>>>> Thara Gopinath<thara@ti.com>  writes:
>>>>>>>
>>>>>>>> This patch extends the device opp structure to contain
>>>>>>>> pointers to scale the operating rate of the
>>>>>>>> device and to retrieve the operating rate of the device.
>>>>>>>> This patch also adds the three new APIs in the opp layer
>>>>>>>> namely opp_set_rate that can be called to set a new operating
>>>>>>>> rate for a device, opp_get_rate that can be called to retrieve
>>>>>>>> the operating frequency for a device and opp_populate_rate_fns
>>>>>>>> to populte the device specific set_rate and get_rate API's.
>>>>>>>> The opp_set_rate and opp_get_rate does some routine error
>>>>>>>> checks and finally calls into the device specific set_rate
>>>>>>>> and get_rate APIs populated through opp_populate_rate_fns.
>>>>>>>>
>>>>>>>> Signed-off-by: Thara Gopinath<thara@ti.com>
>>>>>>>
>>>>>>> As I think about this more, I'm not sure the OPP layer is the right
>>>>>>> layer for the get/set rate functions.  The OPP layer is currently just
>>>>>>> the data store for OPP data. To me, these set/get functions are better
>>>>>>> associated directly with an omap_device instead of an OPP.
>>>>>>>
>>>>>>> For instance, the new OPP APIs are a bit confusing in terms of OPPs.
>>>>>>> e.g: opp_get_rate().  What is the "rate" of an OPP, and what's the
>>>>>>> difference with opp_get_freq()?
>>>>>>>
>>>>>>> What's really happening is the rate is being changed for a device, and
>>>>>>> the need for specific hooks are at the device level, not the OPP level.
>>>>>>> For example, this current approach would not scale if you needed
>>>>>>> multiple devices in the same domain that each needed custom
>>>>>>> set_rate/get_rate hooks.
>>>>>>>
>>>>>>> So instead, what about adding custom hooks at the omap_device level?
>>>>>>> They could be registered at omap_device_build() time in the device
>>>>>>> specific code.
>>>>>
>>>>> This is exactly what I had in my mind when I started implementing this.
>>>>> But then Paul said hwmod or omap_device is not the place to keep it.
>>>>
>>>> IIRC, Paul's concern was that *hwmod* was not the right place for this
>>>> (and I agree.)  However, I think omap_device is the right place for
>>>> this.
>>>>
>>>> Paul?
>>>>
>>>>> Also I do not want the set rate get rate APIs for devices that require
>>>>> changes dividers in the PRCM clock module to be spread out in the
>>>>> system. Makes it very very difficult to debug.  If we agree to add the
>>>>> set_rate and get_rate in the omap_device structure, I would like to
>>>>> have one more API in the omap_device layer to register these APIs
>>>>> device wise. Thus we can keep these set rate and get rate APIs in one
>>>>> single file.
>>>>
>>>> Agreed.  And those functions should be in the respective
>>>> device-specific file, where the omap_device_build() etc are done for
>>>> that device.
>>
>> Hello Kevin,
>>
>> I basically agree with all your other suggestions except this. I do not
>> think device files are the correct place for this. For starters definitely mpu,
>> l3 and iva devices are not built from any device file. I do not like the idea
>> of device set rate APIs spread across different files.
>
> I don't not understand the reason?
> If we need to add specific device function for mpu, l3, or iva, we can
> easily add a file to contain that.
> BTW, thanks to work done by Santosh and Felipe we will probably soon
> introduce a l3 driver that will allow to handle interconnect
> errors. We will thus have a real device for l3 as well.
>
> A device set_rate is clearly device specific. If a device will have to
> play with its own internal dividers along with PRCM dividers, that
> code still belong to the device.
>
> I do not see the need nor the advantage to centralize that? You will
> end-up with a huge file that every driver owners will have to hack in
> order to add set_rate support for their device.
>
> At device build time, IP with set_rate support will just add non-null
> parameters to the omap_device_build(), et voila.
>
> For the debug point of view, you can just add a new sysfs entry for
> scalable devices that will allow you to track scalable device vs
> regular ones.

I agree with Benoit.

For MPU, IVA/DSP, L3, they are currently done in pm.c because they have
not device init or device file associate with them.   For those, the
new rate functions belong there, since that' where the omap_device_build
is done.

For all others, they should stay in device specific init.

Kevin



>> What I am proposing is like we have  opp_populate_rate_fns(which I have introduced)
>> we should have something like omap_device_populate_rate_fns. This can be then called
>> from one file to register the set_rate and get_rate APIs for all the relevant devices
>> for a Soc. This will be done through an init function. And the device specific
>> set_rate and get_rate can be implemented in this file. I am not sure which is
>> this file at this point of time. Maybe for OMAP3 opp3xxx_data.c or pm34xx.c. What
>> do you think about this?
>>
>> Regards
>> Thara
>>
>>>>
>>>>> Also if we move these hooks to omap_device struct we will need to
>>>>> rename the current omap_device_set_rate (the main API) to
>>>>> omap_device_scale and introduce a new omap_device_set_rate which just
>>>>> finds out the omap device from the passed dev pointer and does a
>>>>> od->set_rate. Similarly for get rate also.
>>>>
>>>> Yes, that's what I was thinking.
>>>>
>>>> Kevin
