From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 08/11] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
Date: Mon, 25 Oct 2010 17:19:49 +0100
Message-ID: <87bp6imehm.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-9-git-send-email-thara@ti.com>
	<87tykopccd.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EB95EAB@dbde02.ent.ti.com>
	<87lj5q891i.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EB96206@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54362 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616Ab0JYQT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Oct 2010 12:19:56 -0400
Received: by wyf28 with SMTP id 28so3580095wyf.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Oct 2010 09:19:55 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035EB96206@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Mon, 25 Oct 2010 14:30:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>Sent: Friday, October 22, 2010 10:22 PM
>>>To: Gopinath, Thara
>>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>>Vishwanath; Sawant, Anand
>>>Subject: Re: [PATCH v3 08/11] OMAP3: PM: Adding debug support to Voltage and
>>>Smartreflex drivers
>>>
>>>"Gopinath, Thara" <thara@ti.com> writes:
>>>
>>>>>>Thara Gopinath <thara@ti.com> writes:
>>>>>>
>>>>>>> This patch adds debug support to the voltage and smartreflex drivers.
>>>>>>> This means a whole bunch of voltage processor and smartreflex
>>>>>>> parameters are now visible through the pm debugfs. By default
>>>>>>> only a read of these parameters are permitted. If you need to
>>>>>>> write into them then
>>>>>>>     echo 1 > /pm_debug/enable_sr_vp_debug
>>>>>>
>>>>>>Why a read-only interface by default?   As a debug interface it seems
>>>>>>redundant to have to enable it.
>>>>>>
>>>>
>>>> Read-only interface by default so that we can read these values from
>>>> user space even if we do not want to manipulate it from user-side.
>>>>
>>>
>>>If we do not want to manipulate it from the user-side, then simply don't
>>>write to it.   Remember, this is a debug interface, not a primary
>>>interface.
>>>
>>>I think the enable_sr_vp_debug flag should disappear, and it should be a
>>>read/write interface.
>>>
>>>If the values are changed via debugfs, then set some per-SR instance
>>>flag that can be checked.
>>>
>>>Basically, the current code is confusing because you're using the the
>>>flag called 'enable' to determine whether the user *might have* written
>>>the values.
>>>
>>>[...]
>>>
>>>>>>> +   /*
>>>>>>> +    * Getting  vp errorgain based on the voltage. If the debug option
>>>is
>>>>>>> +    * enabled allow the override of errorgain from user side.
>>>>>>> +    */
>>>>>>
>>>>>>As suggested in earlier comment, please use a specific flag that this
>>>>>>has been overridden instead of the 'debug enabled' flag (which should
>>>>>>disappear, IMO)
>>>>
>>>> What do you mean by a separate flag. You want a flag to be maintained
>>>> for just this purpose ?
>>>
>>>Yes.  I want a flag to be maintained *specifically* for this purpose,
>>>instead of using a much more general flag that only means a user *might*
>>>have overridden the values, use one that specifically means a user *has*
>>>overridden the values.
>
> Hello Kevin,
>
> I tried this. Couple of questions/concerns I have.
> 1. If you take a look at the definition of these debugfs parameters, the omap_vdd_info struct is not passed as an argument. The actual variables are the parameters. I am not sure how to extract omap_vdd_info from this. Maybe container_of will help, but then it will be clumsy. Same concern for smartreflex  err_minlimit variable. There is no way to get the sr instance except use container of which I am not sure will work or not
> 2.Also in voltage layer we export out eight parameters tat can be over-ridden from the user side. I do not think we should be maintaining one flag per variable. The design will be too very clumsy.

I didn't mean to suggest one flag per varialble.  Just one flag to
indicate that the user *has* overridden the defaults.

Kevin

