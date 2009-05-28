From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/13] OMAP2/3: PM: push core PM code from linux-omap
Date: Thu, 28 May 2009 11:22:49 -0700
Message-ID: <87skipm6iu.fsf@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
	<1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
	<1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
	<20090528154823.GD20736@n2100.arm.linux.org.uk>
	<87y6shp3w9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:48506 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbZE1SWu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 14:22:50 -0400
Received: by pxi29 with SMTP id 29so1135128pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 28 May 2009 11:22:52 -0700 (PDT)
In-Reply-To: <87y6shp3w9.fsf@deeprootsystems.com> (Kevin Hilman's message of "Thu\, 28 May 2009 09\:51\:18 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>
>> On Wed, May 20, 2009 at 04:19:25PM -0700, Kevin Hilman wrote:
>>> This patch is to sync the core linux-omap PM code with mainline.  This
>>> code has evolved and been used for a while the linux-omap tree, but
>>> the attempt here is to finally get this into mainline.
>>
>> Hmm..
>>
>>> +static int __init omap_pm_init(void)
>>>  {
>>> -	return 0;
>>> +	int error = -1;
>>> +
>>> +	if (cpu_is_omap24xx())
>>> +		error = omap2_pm_init();
>>> +	if (cpu_is_omap34xx())
>>> +		error = omap3_pm_init();
>>
>> Experience with PXA has shown that this tends to be the wrong way up
>> of doing things.  It seems to be much better to have the SoC specific
>> code call the SoC generic code instead.
>
> OK.
>
>> So, eg, omap2_pm_init() becomes:
>>
>> static int omap2_pm_init(void)
>> {
>> 	if (!cpu_is_omap24xx())
>> 		return -ENODEV;
>>
>> 	... omap24xx initialisation ...
>>
>> 	return omap_pm_init();
>> }
>> late_initcall(omap2_pm_init);
>>
>> (and, since this is always built-in, there's no point doing cleanup if
>> omap_pm_init() fails - you're not going to be able to re-run that
>> initialization again.)
>
> Sounds good, I'll make this change and upate the pm-upstream branch
> for Tony.
>
> This will leave the common omap_pm_init() and pm.c basically empty, so
> I'll just remove them.

OK, pushed an updated version of this patch into a new pm-upstream branch
of my omap-pm tree[1]

Kevin

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git
