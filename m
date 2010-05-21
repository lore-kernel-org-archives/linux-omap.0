From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: collaboration on hwmod conversions and runtime PM
Date: Fri, 21 May 2010 08:06:33 -0700
Message-ID: <87ljbdl2fa.fsf@deeprootsystems.com>
References: <87mxvucekw.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0322FA7EE5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:34254 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab0EUPGg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 11:06:36 -0400
Received: by pzk15 with SMTP id 15so638399pzk.15
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 08:06:35 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322FA7EE5@dbde02.ent.ti.com> (Rajendra Nayak's message of "Fri\, 21 May 2010 16\:28\:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

>> There has been quite a bit of activity on the hwmod front, but no
>> common place to combine patches for testing.
>> 
>> To that end, I've update the pm-wip/hwmods branch in my tree to 
>> the two fixes/cleanup series from Benoit (which will be merged
>> via for 2.6.35):
>> 
>>   [PATCH 00/10] OMAP: HWMOD fixes and cleanup
>>   [PATCH 0/5] OMAP4: PRCM: Spring cleanup
>> 
>> On top of this, there is the pm-wip/hwmods-omap4 branch which includes
>> the OMAP4 series from Benoit
>> 
>>   [PATCH 0/6] OMAP: hwmod: Full data set for OMAP4430 ES1.0
>> 
>> so that conversions for OMAP4 can also be done and tested.  Note that
>> I've reverted the two "temporary" patches in this series since they
>> cause problems on OMAP3,
>
> Hi Kevin,
>
> These temp patches might not be needed anymore, even for omap4. The clockdomain
> has cpu checks to take care of the dependency, and there is already a patch from
> Santosh to keep the emif clocks always active.
>
> If you pull these 2 patches, we don't need the hacks anymore and multi omap build
> would work as well on these branches.
> https://patchwork.kernel.org/patch/100932/
> https://patchwork.kernel.org/patch/96048/

OK, I'll pull those two in while waiting for them to merge upstream.

> I was able to boot test on my 4430sdp with these 2 patches on pm-wip/hwmods-omap4
> branch.

Excellent, Thanks for testing!

Kevin

