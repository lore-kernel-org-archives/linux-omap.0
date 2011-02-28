From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v10 05/18] OMAP2,3 DSS2 Change driver name to omap_display
Date: Mon, 28 Feb 2011 15:00:44 +0100
Message-ID: <4D6BAA8C.2020203@ti.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>	 <1295850125-21405-6-git-send-email-sumit.semwal@ti.com>	 <1298539643.16119.54.camel@deskari> <1298876015.2096.36.camel@deskari>	 <4D6B4A1A.9000304@ti.com> <1298877549.2096.47.camel@deskari>	 <4D6B88BB.5010200@ti.com> <1298895026.9809.27.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34940 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915Ab1B1OA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 09:00:57 -0500
In-Reply-To: <1298895026.9809.27.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

On 2/28/2011 1:10 PM, Valkeinen, Tomi wrote:
> On Mon, 2011-02-28 at 05:36 -0600, Cousson, Benoit wrote:
>> Hi Tomi,
>>
>> On 2/28/2011 8:19 AM, Valkeinen, Tomi wrote:
>>> On Mon, 2011-02-28 at 01:09 -0600, Taneja, Archit wrote:
>>>> Hi,
>>>>
>>>> On Monday 28 February 2011 12:23 PM, Valkeinen, Tomi wrote:
>>>>> On Thu, 2011-02-24 at 03:27 -0600, Tomi Valkeinen wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Mon, 2011-01-24 at 11:51 +0530, ext Sumit Semwal wrote:
>>>>>>> From: Senthilvadivu Guruswamy<svadivu@ti.com>
>>>>>>>
>>>>>>> Change the driver name from omapdss to omap_display as the driver takes care of
>>>>>>> the display devices ie number of panels, type of panels available in the
>>>>>>> platform.  Change the device name in the board files and 2420,2430,3xxx clock
>>>>>>> files from omapdss to omap_display to match the driver name.
>>>>>>
>>>>>> I just realized that changing the driver name will break all scripts and
>>>>>> applications using omapdss sysfs files.
>>>>>>
>>>>>> How does this sound:
>>>>>>
>>>>>> Let's leave the omapdss device name as it is. It represents a "super"
>>>>>> device, containing the dss sysfs files and upper level dss management.
>>
>> This is the case for all the drivers migrated to omap_device anyway due
>> to the change in the top level hierarchy. Everything is below
>> platform/omap now.
>
> The HW module drivers are under platform/omap/, but omapdss is in
> platform/. Do you mean that omapdss should also be under platform/omap/?

This is because you are probably not using omap_device yet. is should 
happen when you will change your platform_device to be omap_device.

> The reason I'm unwilling to change omapdss name, or location, is that
> omapdss directory contains lots of DSS configuration files, used by
> scripts and programs.

Is that used for debug only?

>> That's why we are using that opportunity to clean and provide a
>> consistent naming for all devices.
>>
>>>>>> Name the HW module platform drivers as: omapdss_dss, omapdss_venc,
>>>>>> omapdss_dispc, etc. This would indicate them to be clearly parts of DSS,
>>>>>> and would also prevent any possible name conflict if there would happen
>>>>>> to be a, say, "dsi" block in some other HW component.
>>
>> Cannot you use a device hierarchy then to do that?
>>    omap_dss/core
>>    omap_dss/dsi
>>    omap_dss/venc
>>
>> This is moreover the way the HW is done.
>
> Hmm, how would that work? The devices are platform devices, and they
> have a unique global name, which is used to match the driver for the
> device.

Practically, I don't really know :-) Please see the reply to Russell.

>>>>> Any comments on this?
>>>>
>>>> I also think we need to stick to the older name, "omapdss_dss" sounds a
>>>> bit confusing, and I think one of the previous versions had something
>>>> like "dss_dss" in it and it wasn't approved. Does something like
>>>> "omapdss_core" or "omapdss_dss_core" make sense, or is it more misleading?
>>>
>>> It is confusing, but so is the hardware naming =). There is a DSS module
>>> inside the omap display subsystem. That's why I would like to name it
>>> "dss", not "core", so it's clear it refers to this DSS module.
>>>
>>> "dss_dss" looks a bit silly, but I think "omapdss_dss" is slightly
>>> better in the sense that it doesn't repeat the same "dss", and there is
>>> an "omapdss" device, which acts like "manager" for these module devices.
>>> But yes, I wouldn't call it perfect either.
>>>
>>> "omapdss_dss_core" is one option. But then again, TRM doesn't speak of
>>> "core".
>>
>> We should not maintain silly names just because they are in the TRM, we
>> should just fix the TRM. This is exactly what we are going to do for
>> most HW names we introduced in OMAP4.
>>
>> So if we all agree that this name will avoid confusion and is much
>> better than the current one, we can change it right now with a comment
>> to explain the change and give the pointer to the current TRM naming.
>
> True. But I don't think there's a huge difference with omapdss_dss or
> omapdss_core.

You're right, at the end it is just a name. We are just trying to clean 
a little bit the current devices name mess. So the convention we are 
trying to enforce is to name omap devices omap_XXX.

> The name is used in only a few places inside the kernel, and never from
> userspace, so we can change that also later.
>
> The main issue I had was changing the omapdss device name, which would
> break the userspace.

That's why we'd better break it properly today once and for all :-)
At least when you will migrate to omap_device.

Benoit

