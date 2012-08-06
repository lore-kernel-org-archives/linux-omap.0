From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 4/8] ARM: OMAP3: add manual control for mpu / core pwrdm usecounting
Date: Mon, 06 Aug 2012 16:32:16 -0700
Message-ID: <87ehnj4mwv.fsf@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
	<1342189185-5306-5-git-send-email-t-kristo@ti.com>
	<878ve5j8se.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:52256 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756965Ab2HFXcS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 19:32:18 -0400
Received: by pbcxa7 with SMTP id xa7so1718703pbc.39
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 16:32:17 -0700 (PDT)
In-Reply-To: <878ve5j8se.fsf@ti.com> (Kevin Hilman's message of "Fri, 27 Jul
	2012 12:36:33 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> Tero Kristo <t-kristo@ti.com> writes:
>
>> mpu / core powerdomain usecounts are now statically increased
>> by 1 during MPU activity. This allows the domains to reflect
>> actual usage, and will allow the usecount to reach 0 just before
>> all CPUs are ready to idle. Proper powerdomain usecounts are
>> propageted to voltagedomain level also, and will allow vc
>> callbacks to be triggered at right point of time.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>
> IMO, the idea is fine, but I'm not crazy about the implementation in
> powerdomain.c, which is meant for pwrdm generic code.   In particular,
> I'm not crazy about the pwrdm lookups in powerdomain.c.
>
> Since pm<soc>.c already has references to mpu_pwrdm and core_pwrdm, why
> not just add the pwrdm_clkdm_enable/disable calls directly in pm<soc>.c
>
> Also, the changelog should be a bit more specific about why CORE
> powerdomain is also handled here when most of the code only talks about
> the CPU.

After playing with this some more, and doing a test hack of my idea
above, along with the per-pwrdm pre/post changes now in mainline, I
thinks this series should go one step further.

Basically, we should be able to get rid of the calls to
prdm_pre|post_transition that are outside the powerdomain code.  With
the addition of pwrdm_clkdm_enable|disable, it seems that the pre|post
transition calls should be called directly from
pwrdm_clkdm_enable|disable when the usecount transitions to/from zero.

Kevin



