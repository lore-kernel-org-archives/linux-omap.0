From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clock cleanup for v3.17 merge window
Date: Fri, 4 Jul 2014 10:02:33 +0300
Message-ID: <53B65189.4070807@ti.com>
References: <53B59C5D.7010405@ti.com> <20140704064813.GA28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40218 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbaGDHBr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2014 03:01:47 -0400
In-Reply-To: <20140704064813.GA28884@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 07/04/2014 09:48 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [140703 11:10]:
>> Hi Tony,
>>
>> Posting this early, as I will be going for vacation from next week and might
>> miss the merge window myself. Small cleanup set for the clock drivers
>> residing under mach-omap2 folder to prepare their move under drivers/clk.
>> I'll leave it for your judgement whether you pull this or not based on the
>> potential feedback.
>>
>> ----------------------------------------------------------------
>>
>> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
>>
>>    Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
>>
>> are available in the git repository at:
>>
>>    git@github.com:t-kristo/linux-pm.git for-v3.17/omap2-clk-cleanup
>>
>> for you to fetch changes up to 4eccc64a2bc25514754c30cdfc985207aee8b2fd:
>>
>>    ARM: OMAP2+: clock/interface: remove some headers from clkt_iclk.c file
>> (2014-07-01 17:46:27 +0300)
>
> This would be best queued by Paul if OK. I'm assuming all these
> pull requests are independet of each other, right?

Yea this is fine with me. All the pull-requests are independent.

-Tero

>
> Regards,
>
> Tony
>
>
>> ----------------------------------------------------------------
>> Tero Kristo (13):
>>        ARM: OMAP2+: clock/dpll: fix _dpll_test_fint arithmetics overflow
>>        ARM: OMAP4+: clock: remove DEFINE_CLK_OMAP_HSDIVIDER macro
>>        ARM: OMAP4+: dpll: remove cpu_is_omap44xx checks
>>        ARM: OMAP4+: dpll44xx: remove cm-regbits-44xx.h and clock44xx.h
>> includes
>>        ARM: OMAP2+: clock: introduce ti_clk_features flags
>>        ARM: OMAP2+: clock: add fint values to the ti_clk_features struct
>>        ARM: OMAP2+: clock/dpll: add private API for checking if DPLL is in
>> bypass
>>        ARM: OMAP2+: clock/dpll: convert bypass check to use clk_features
>>        ARM: OMAP2+: clock/dpll: add jitter correction behind clk_features
>>        ARM: OMAP2+: clock/interface: add a clk_features definition for idlest
>> value
>>        ARM: OMAP2+: clock/dpll: remove unused header includes from
>> clkt_dpll.c
>>        ARM: OMAP2+: clock/dpll: remove unused header includes from dpll3xxx.c
>>        ARM: OMAP2+: clock/interface: remove some headers from clkt_iclk.c
>> file
>>
>>   arch/arm/mach-omap2/clkt_dpll.c |  100
>> ++++++++++++++++++---------------------
>>   arch/arm/mach-omap2/clkt_iclk.c |    8 ++--
>>   arch/arm/mach-omap2/clock.c     |   76 ++++++++++++++++++++++++++---
>>   arch/arm/mach-omap2/clock.h     |   44 ++++++++---------
>>   arch/arm/mach-omap2/dpll3xxx.c  |    7 +--
>>   arch/arm/mach-omap2/dpll44xx.c  |   19 +++++---
>>   arch/arm/mach-omap2/io.c        |    2 +
>>   7 files changed, 155 insertions(+), 101 deletions(-)

