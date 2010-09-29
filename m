From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 05/13] OMAP: Introduce device specific set rate and get
 rate in device opp structures.
Date: Wed, 29 Sep 2010 16:46:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035E1738E5@dbde02.ent.ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-6-git-send-email-thara@ti.com>
	<87fwxrzpan.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03294424DF@dbde02.ent.ti.com>
 <87aanhd7xj.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0329539FDE@dbde02.ent.ti.com>
 <4C9490B9.7090002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49685 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408Ab0I2LRB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 07:17:01 -0400
In-Reply-To: <4C9490B9.7090002@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Cousson, Benoit
>>Sent: Saturday, September 18, 2010 3:43 PM
>>To: Gopinath, Thara
>>Cc: Kevin Hilman; Paul Walmsley; linux-omap@vger.kernel.org; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH 05/13] OMAP: Introduce device specific set rate and get
>>rate in device opp structures.
>>
>>Hi Thara,
>>
>>On 9/17/2010 4:55 PM, Gopinath, Thara wrote:
>>>
>>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>>> Sent: Thursday, September 16, 2010 8:58 PM
>>>>>
>>>>> "Gopinath, Thara"<thara@ti.com>  writes:
>>>>>
>>>>>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>>>>>> Sent: Friday, September 03, 2010 5:12 AM
>>>>>>>>
>>>>>>>> Thara Gopinath<thara@ti.com>  writes:
>>>>>>>>
>>>>>>>>> This patch extends the device opp structure to contain
>>>>>>>>> pointers to scale the operating rate of the
>>>>>>>>> device and to retrieve the operating rate of the device.
>>>>>>>>> This patch also adds the three new APIs in the opp layer
>>>>>>>>> namely opp_set_rate that can be called to set a new operating
>>>>>>>>> rate for a device, opp_get_rate that can be called to retrieve
>>>>>>>>> the operating frequency for a device and opp_populate_rate_fns
>>>>>>>>> to populte the device specific set_rate and get_rate API's.
>>>>>>>>> The opp_set_rate and opp_get_rate does some routine error
>>>>>>>>> checks and finally calls into the device specific set_rate
>>>>>>>>> and get_rate APIs populated through opp_populate_rate_fns.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Thara Gopinath<thara@ti.com>
>>>>>>>>
>>>>>>>> As I think about this more, I'm not sure the OPP layer is the right
>>>>>>>> layer for the get/set rate functions.  The OPP layer is currently just
>>>>>>>> the data store for OPP data. To me, these set/get functions are better
>>>>>>>> associated directly with an omap_device instead of an OPP.
>>>>>>>>
>>>>>>>> For instance, the new OPP APIs are a bit confusing in terms of OPPs.
>>>>>>>> e.g: opp_get_rate().  What is the "rate" of an OPP, and what's the
>>>>>>>> difference with opp_get_freq()?
>>>>>>>>
>>>>>>>> What's really happening is the rate is being changed for a device, and
>>>>>>>> the need for specific hooks are at the device level, not the OPP
>>level.
>>>>>>>> For example, this current approach would not scale if you needed
>>>>>>>> multiple devices in the same domain that each needed custom
>>>>>>>> set_rate/get_rate hooks.
>>>>>>>>
>>>>>>>> So instead, what about adding custom hooks at the omap_device level?
>>>>>>>> They could be registered at omap_device_build() time in the device
>>>>>>>> specific code.
>>>>>>
>>>>>> This is exactly what I had in my mind when I started implementing this.
>>>>>> But then Paul said hwmod or omap_device is not the place to keep it.
>>>>>
>>>>> IIRC, Paul's concern was that *hwmod* was not the right place for this
>>>>> (and I agree.)  However, I think omap_device is the right place for
>>>>> this.
>>>>>
>>>>> Paul?
>>>>>
>>>>>> Also I do not want the set rate get rate APIs for devices that require
>>>>>> changes dividers in the PRCM clock module to be spread out in the
>>>>>> system. Makes it very very difficult to debug.  If we agree to add the
>>>>>> set_rate and get_rate in the omap_device structure, I would like to
>>>>>> have one more API in the omap_device layer to register these APIs
>>>>>> device wise. Thus we can keep these set rate and get rate APIs in one
>>>>>> single file.
>>>>>
>>>>> Agreed.  And those functions should be in the respective
>>>>> device-specific file, where the omap_device_build() etc are done for
>>>>> that device.
>>>
>>> Hello Kevin,
>>>
>>> I basically agree with all your other suggestions except this. I do not
>>> think device files are the correct place for this. For starters definitely
>>mpu,
>>> l3 and iva devices are not built from any device file. I do not like the
>>idea
>>> of device set rate APIs spread across different files.
>>
>>I don't not understand the reason?
>>If we need to add specific device function for mpu, l3, or iva, we can
>>easily add a file to contain that.
>>BTW, thanks to work done by Santosh and Felipe we will probably soon
>>introduce a l3 driver that will allow to handle interconnect errors. We
>>will thus have a real device for l3 as well.
>>
>>A device set_rate is clearly device specific. If a device will have to
>>play with its own internal dividers along with PRCM dividers, that code
>>still belong to the device.
>>
>>I do not see the need nor the advantage to centralize that? You will
>>end-up with a huge file that every driver owners will have to hack in
>>order to add set_rate support for their device.
>>
>>At device build time, IP with set_rate support will just add non-null
>>parameters to the omap_device_build(), et voila.
>>
>>For the debug point of view, you can just add a new sysfs entry for
>>scalable devices that will allow you to track scalable device vs regular
>>ones.

Hello Benoit/Kevin,

Most of the devices need not scale any internal dividers. For devices that 
need to scale internal dividers, I agree that the set_rate and get_rate should come from the devices file. But for other devices that involve only PRCM dividers, I do not think they should be bothered with implementing these APIs and maintaining them.

Regards
Thara
