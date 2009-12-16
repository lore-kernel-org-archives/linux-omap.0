From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/10 V5] omap3: pm: introduce support for 3630 OPPs
Date: Wed, 16 Dec 2009 14:37:02 -0800
Message-ID: <873a3aa6lt.fsf@deeprootsystems.com>
References: <[PATCH 02/10 V4] omap3: pm: introduce opp accessor functions>
	<1260594031-17268-1-git-send-email-nm@ti.com>
	<87pr6eadx3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:58613 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935413AbZLPWhG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 17:37:06 -0500
Received: by pzk1 with SMTP id 1so1035602pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 14:37:05 -0800 (PST)
In-Reply-To: <87pr6eadx3.fsf@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 16 Dec 2009 11\:59\:04 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Nishanth Menon <nm@ti.com> writes:
>
>> Hi,
>> Thanks for all the comments. Here are the *changed* patches since V5
>>
>> What changed in V5:
>> * review comment incorporated
>> * vsel is deprecated now
>> * I seem to have hit a checkpatch.pl bug as in 
>>   http://lkml.org/lkml/2009/12/11/573, made me check the usage
>>   of __deprecated for struct params, and used it in a
>>   consistent manner to functions..
>> * More warnings added to build :( (deprecated ones ofcourse)
>> * removed OMAP_OPP_DEF_TERMINATOR
>> * 3430 and 3630 patches changed as a result
[...]

> To facilitate the ongoing discussions on OPP rework, and to have a
> common base, this series is available as a branch in my linux-omap-pm
> repo[1].
>
> The branch is called 'pm-wip-opp' and I have rebased onto the PM
> branch I pushed today.

I forgot to mention that I've also pushed the patch for removing OPP
interface from the OMAP PM layer[1] to the work-in-progress OPP
branch.

Kevin

[1] http://marc.info/?l=linux-omap&m=125917007423545&w=2
