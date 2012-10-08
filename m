From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/4] cpufreq: OMAP: fixes for v3.7-rc2
Date: Mon, 08 Oct 2012 14:36:51 -0700
Message-ID: <87k3v08x3g.fsf@deeprootsystems.com>
References: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
	<1505601.8trb51fSMV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61915 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab2JHVgy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 17:36:54 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4334120pad.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Oct 2012 14:36:54 -0700 (PDT)
In-Reply-To: <1505601.8trb51fSMV@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Sun, 07 Oct 2012 22:13:51 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Wednesday 03 of October 2012 16:00:25 Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@ti.com>
>> 
>> Here's a series with a couple bug fixes and a couple fixes that
>> make this driver support newer OMAP-based SoCs.
>> 
>> The 'get_cpu_device' patch is needed due to a change in the OMAP
>> OMAP PM core code which enforces use of get_cpu_device() instead of
>> a deprecated OMAP-specific API.
>> 
>> The usage of plat/*.h headers breaks single zImage, so platforms are
>> cleaning up and/or removing plat/*.h so the driver needs to be fixed
>> accordingly.
>> 
>> This series is based on the merge of Rafael's pm-for-3.7-rc1 tag into
>> Linus' master branch: commit 16642a2e7be23bbda013fc32d8f6c68982eab603.
>> 
>> Tested CPUfreq on OMAP platforms: 3430/n900, 3530/Overo,
>> 3730/OveroSTORM, 3730/Beagle-XM, 4430/Panda.
>> 
>> Rafael, if you're OK with this series, I'll get a pull request
>> ASAP so it can be included for v3.7-rc2.
>
> The patches are fine by me, but there may be a bit of a timing issue with
> them, because I'll be travelling between October 12 and October 21 inclusive
> and I won't be pushing stuff to kernel.org during that time.
>
> So I think it would be better to merge this material through the arm-soc tree,
> if that's not a problem.  If you decide to do so, please feel free to add my
> ACK to the patches.

Thanks, I'll get them queued.

Kevin
