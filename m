From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: Which git to clone for testing prior to submitting bugs?
Date: Thu, 27 Sep 2012 14:39:42 -0500
Message-ID: <CAOCHtYiido11MG55m601CX2isYJ2oFcubgJ7Wkng=HnkT_DdcQ@mail.gmail.com>
References: <50648AA2.2010004@johnea.net>
	<CAOCHtYitbhOMv+YBaYgdTuYZQpZ_VLoP=QKVS=spmqPxEUkATA@mail.gmail.com>
	<5064A173.5000909@johnea.net>
	<CAOCHtYh2DofNoLx1W6ZWy4aKNpQx10P9AbmWbj1yeY1G=ixHPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46337 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320Ab2I0Tjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 15:39:43 -0400
Received: by vcbfo13 with SMTP id fo13so2475065vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 12:39:42 -0700 (PDT)
In-Reply-To: <CAOCHtYh2DofNoLx1W6ZWy4aKNpQx10P9AbmWbj1yeY1G=ixHPg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@johnea.net
Cc: linux-omap@vger.kernel.org

>> Thanks Robert,
>>
>> The 3.4.4 kernel is plain vanilla plus:
>>
>> http://rcn-ee.net/deb/sid-armhf/v3.4.4-x1/patch-3.4.4-x1.diff.gz
>>
>> We're running archlinuxarm, and working with devs there to upgrade to 3.5.4,
>> in hopes this will address most or all of the issues. That will include:
>>
>> http://rcn-ee.net/deb/sid-armhf/v3.5.4-x6/patch-3.5.4-x6.diff.gz
>>
>> We adopted archlinux because it's about as close to a git kernel as can be
>> had in a disto packaged format.
>
> Ah, so my external patchset...  Well, for the patch, nothing actually
> changed between 3.4.3-x1 -> 3.4.4-x1... (besides the stable patchset)
>
> https://github.com/RobertCNelson/stable-kernel/commits/v3.4.x/
>
> (the 3 commits are related to scripts in that git repo.)
>
> So, i would first look at the config (zcat /proc/config.gz) between
> those two releases, and if the arch developers added any more patches
> to it..

https://github.com/archlinuxarm/PKGBUILDs/commit/68a9e5a1609fde10a2f31dac8df211f0c3874eb7

It looks like they disabled CONFIG_OMAP_RESET_CLOCKS

I'm pretty sure that would force you to be stuck with what ever u-boot
sets up for those pins...

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
