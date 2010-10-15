From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: hmwod: Update the sysc_cache in case module context is lost
Date: Fri, 15 Oct 2010 08:40:02 -0700
Message-ID: <87tyknmpm5.fsf@deeprootsystems.com>
References: <1287080555-25399-1-git-send-email-rnayak@ti.com>
	<877hhkv2wb.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D09A2FE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46844 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119Ab0JOPkJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Oct 2010 11:40:09 -0400
Received: by gwj17 with SMTP id 17so411326gwj.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Oct 2010 08:40:08 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030D09A2FE@dbde02.ent.ti.com>
	(Santosh Shilimkar's message of "Fri, 15 Oct 2010 11:18:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Friday, October 15, 2010 3:44 AM
>> To: Nayak, Rajendra
>> Cc: linux-omap@vger.kernel.org; Paul Walmsley; Cousson, Benoit; Shilimkar,
>> Santosh
>> Subject: Re: [PATCH] OMAP: hmwod: Update the sysc_cache in case module
>> context is lost
>> 
>> Rajendra Nayak <rnayak@ti.com> writes:
>> 
>> > Do not skip the sysc programming in the hmwod framework based
>> > on the cached value alone, since at times the module might have lost
>> > context (due to the Powerdomain in which the module belongs
>> > transitions to either Open Switch RET or OFF).
>> 
>> Shouldn't the driver for each IP be responsible for restoring it's
>> register contents after context loss, including it's SYSC?
>> 
>> Seems to me that if SYSC is lost, it means the driver's save/restore
>> is buggy.
> 
> I am glad you asked this question. I had a same argument with Benoit
> that driver anyway does context save restore for other registers and
> it can do SYSC as well.
>
> But Benoit's point was that "sysconfig is a part of the PRCM located
> in the IP, but this is purely TI implementation specific. The same
> IP in another platform will not have this sysconfig entry. That's why
> its important to hide them from the driver "

OK, but this patch still doesn't address the real problem.  Namely, that
*somebody* needs to save/restore the SYSC reg for the IP.  

Otherwise, all this patch does is refresh the _sysc_cache with
completely unknown contents.  It also somewhat defeats the purpose of
having a cache.  If you're going to read SYSC in order to determine
whether or not you can avoid a write, you might as well just blindly
write.

One option to fix the save/restore would be that TI specific context
save/restore could be done in the device layer by adding some additional
save/restore do the functions calling omap_device_[idle|enable].

IOW, most devices just call omap_device directly by doing something like:

struct omap_device_pm_latency omap_wdt_latency[] = {
	[0] = {
		.deactivate_func = omap_device_idle_hwmods,
		.activate_func   = omap_device_enable_hwmods,
		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
	},
};


But these [de]activate functions can be anything, and could be made into
functions that do some additional save/restore and then call
omap_device_*

Kevin

