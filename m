From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/3] OMAP4: CPUidle: Add coupled idle support
Date: Tue, 03 Apr 2012 20:36:22 +0530
Message-ID: <4F7B11EE.6030904@ti.com>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com> <87obr9s8wk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:35625 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752210Ab2DCPG2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 11:06:28 -0400
Received: by ghrr20 with SMTP id r20so1944503ghr.41
        for <linux-omap@vger.kernel.org>; Tue, 03 Apr 2012 08:06:27 -0700 (PDT)
In-Reply-To: <87obr9s8wk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, ccross@android.com, linux-arm-kernel@lists.infradead.org

On Tuesday 03 April 2012 10:34 AM, Kevin Hilman wrote:
> Hi Santosh,
> 
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> The series adds the coupled cpuidle support for OMAP4 based on the v2
>> series posted [1]. This makes OMAP4 to support SMP cpuidle and also
>> removes the hard dependency of off-lining CPU1 to trigger deeper
>> C-states.
>>
>> I have put together a branch which is based on 3.3 kernel with
>> Len Browns next branch [2] which has time keeping and other cpuidle
>> patches which will mostly get merged by 3.4-rc1 and rebased coupled
>> idle series from [1].
> 
> Thanks for rebasing this.
> 
>> git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
>> for_3.5/omap4_coupled_cpuidle-rebase
> 
> This branch by itself seems to work fine.  However, when combining with
> other stuff that has merged for v3.4, it hangs during boot.  I haven't
> yet isolated the problem, but it's easy to reproduce by combining your
> branch with v3.4-rc1:
> 
>   git checkout -b test/coupled-v3.4 v3.4-rc1
>   git merge -s recursive -X ours santosh/for_3.5/omap4_coupled_cpuidle-rebase [1]
> 
> This hangs on boot, and it seems like a coupled state deadlock because
> commenting out the coupled states in the C-state creation of
> cpuidle44xx.c makes it boot just fine.
> 
I managed to reproduce the issue. Just to ensure that any OMAP changes
have not introduced the regression I merged all Tony's pull request on
my branch and tried it out. OMAP changes are fine and coupled idle
continue to work.

Started bisecting the commits. For bisect I have to create a series
which is not dependent on Len's cpuidle updates. First round of bisect
was not successful so tried one more time. Was very close to narrowing
down on commit but then encountered set of commits where either CPUIDLE
itself is broken(deeper C-states are not getting attempted) or I get
softIRQ 08 pending error.

The last bad commit in bisect was ...
[8682df25ca9afd3aac30f2c72d00bd98de2118e8] Merge branch
'fortglx/3.4/rtc' of git://git.linaro.org/people/jstultz/linux into
timers/core

So far looks like, one of below series has introduced a race which is
getting highlighted with coupled cpuidle patchset.

9b612fa Merge branch 'fortglx/3.4/clocksource' of
git://git.linaro.org/people/jstultz/linux into timers/core
8682df2 Merge branch 'fortglx/3.4/rtc' of
git://git.linaro.org/people/jstultz/linux into timers/core
97ac984 Merge branch 'fortglx/3.4/time' of
git://git.linaro.org/people/jstultz/linux into timers/core

Will try to continue the debug tomorrow. let me know if you find some
thing interesting in your day time.

Regards
santosh







