From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 05/13] OMAP: Introduce device specific set rate and get
 rate in device opp structures.
Date: Thu, 16 Sep 2010 15:51:32 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03294424DF@dbde02.ent.ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-6-git-send-email-thara@ti.com>
 <87fwxrzpan.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52995 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab0IPKVk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 06:21:40 -0400
In-Reply-To: <87fwxrzpan.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Friday, September 03, 2010 5:12 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Sripathy, Vishwanath; Sawant, Anand; Cousson, Benoit
>>Subject: Re: [PATCH 05/13] OMAP: Introduce device specific set rate and get rate in device opp
>>structures.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch extends the device opp structure to contain
>>> pointers to scale the operating rate of the
>>> device and to retrieve the operating rate of the device.
>>> This patch also adds the three new APIs in the opp layer
>>> namely opp_set_rate that can be called to set a new operating
>>> rate for a device, opp_get_rate that can be called to retrieve
>>> the operating frequency for a device and opp_populate_rate_fns
>>> to populte the device specific set_rate and get_rate API's.
>>> The opp_set_rate and opp_get_rate does some routine error
>>> checks and finally calls into the device specific set_rate
>>> and get_rate APIs populated through opp_populate_rate_fns.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>As I think about this more, I'm not sure the OPP layer is the right
>>layer for the get/set rate functions.  The OPP layer is currently just
>>the data store for OPP data. To me, these set/get functions are better
>>associated directly with an omap_device instead of an OPP.
>>
>>For instance, the new OPP APIs are a bit confusing in terms of OPPs.
>>e.g: opp_get_rate().  What is the "rate" of an OPP, and what's the
>>difference with opp_get_freq()?
>>
>>What's really happening is the rate is being changed for a device, and
>>the need for specific hooks are at the device level, not the OPP level.
>>For example, this current approach would not scale if you needed
>>multiple devices in the same domain that each needed custom
>>set_rate/get_rate hooks.
>>
>>So instead, what about adding custom hooks at the omap_device level?
>>They could be registered at omap_device_build() time in the device
>>specific code.

This is exactly what I had in my mind when I started implementing this.
But then Paul said hwmod or omap_device is not the place to keep it. Also I do not
want the set rate get rate APIs for devices that require changes dividers in the PRCM
clock module to be spread out in the system. Makes it very very difficult to debug.
If we agree to add the set_rate and get_rate in the omap_device structure, I would like to have
one more API in the omap_device layer to register these APIs device wise. Thus we can keep these
set rate and get rate APIs in one single file.

Also if we move these hooks to omap_device struct we will need to rename the current omap_device_set_rate (the main API) to omap_device_scale and introduce a new omap_device_set_rate which just finds out the omap device from the passed dev pointer and does a od->set_rate. Similarly for get rate also.

Regards
Thara
