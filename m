From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 08/11] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
Date: Fri, 22 Oct 2010 09:52:09 -0700
Message-ID: <87lj5q891i.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-9-git-send-email-thara@ti.com>
	<87tykopccd.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EB95EAB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38666 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab0JVQwO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 12:52:14 -0400
Received: by pwj8 with SMTP id 8so12180pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 09:52:13 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035EB95EAB@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Fri, 22 Oct 2010 20:11:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> This patch adds debug support to the voltage and smartreflex drivers.
>>>> This means a whole bunch of voltage processor and smartreflex
>>>> parameters are now visible through the pm debugfs. By default
>>>> only a read of these parameters are permitted. If you need to
>>>> write into them then
>>>>     echo 1 > /pm_debug/enable_sr_vp_debug
>>>
>>>Why a read-only interface by default?   As a debug interface it seems
>>>redundant to have to enable it.
>>>
>
> Read-only interface by default so that we can read these values from
> user space even if we do not want to manipulate it from user-side.
>

If we do not want to manipulate it from the user-side, then simply don't
write to it.   Remember, this is a debug interface, not a primary
interface.

I think the enable_sr_vp_debug flag should disappear, and it should be a
read/write interface.

If the values are changed via debugfs, then set some per-SR instance
flag that can be checked.

Basically, the current code is confusing because you're using the the
flag called 'enable' to determine whether the user *might have* written
the values.

[...]

>>>> +   /*
>>>> +    * Getting  vp errorgain based on the voltage. If the debug option is
>>>> +    * enabled allow the override of errorgain from user side.
>>>> +    */
>>>
>>>As suggested in earlier comment, please use a specific flag that this
>>>has been overridden instead of the 'debug enabled' flag (which should
>>>disappear, IMO)
>
> What do you mean by a separate flag. You want a flag to be maintained
> for just this purpose ?

Yes.  I want a flag to be maintained *specifically* for this purpose,
instead of using a much more general flag that only means a user *might*
have overridden the values, use one that specifically means a user *has*
overridden the values.

Kevin
