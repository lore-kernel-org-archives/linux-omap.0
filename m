From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL 2/5] omap pm clean-up for v3.10 merge window
Date: Tue, 09 Apr 2013 09:38:28 -0700
Message-ID: <87vc7virqz.fsf@linaro.org>
References: <0MarPy-1U9XGk2D8s-00Ks1o@mx.kundenserver.de>
	<201304091652.28385.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:57862 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936621Ab3DIQie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 12:38:34 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq13so3888275pab.15
        for <linux-omap@vger.kernel.org>; Tue, 09 Apr 2013 09:38:33 -0700 (PDT)
In-Reply-To: <201304091652.28385.arnd@arndb.de> (Arnd Bergmann's message of
	"Tue, 9 Apr 2013 16:52:28 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday 09 April 2013, Tony Lindgren wrote:
>> The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
>> 
>>   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
>> 
>> are available in the git repository at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/cleanup-pm-signed
>> 
>> for you to fetch changes up to ca8cdff548da76da01f3783548ceb917139a5ddc:
>> 
>>   Merge tag 'omap-pm-v3.10/cleanup/cpuidle' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm
>> into omap-for-v3.10/cleanup-pm (2013-04-08 09:51:00 -0700)
>> 
>> ----------------------------------------------------------------
>> 
>> PM cleanup to prepare for omap5 PM via Kevin Hilman <khilman@linaro.org>:
>> 
>> OMAP3/4 CPUidle cleanups for v3.10
>
> Adding Daniel and Rafael to Cc.
>
> Is this series coordinated with the other cpuidle changes? Please tell me if this
> is good to go into arm-soc.

Hmm, looks like it's not ready.  There are some minor conflicts with
what Rafael has queued up from Daniel.

I will work this out with Daniel to figure out how we should proceed.

Kevin
