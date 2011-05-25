From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 4/6 v2] OMAP2: cpufreq: use
 clk_init_cpufreq_table if OPPs not available
Date: Wed, 25 May 2011 00:44:32 -0700
Message-ID: <BANLkTim1TzQ_XyhigQra3ZKVg=Kd_NJ2_g@mail.gmail.com>
References: <1305704266-17623-5-git-send-email-nm@ti.com> <87d3jeal6r.fsf@ti.com>
 <BANLkTinKByYJ1kbRXkWsc1UWrdxcj9+84g@mail.gmail.com> <87lixvy7fy.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60201 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755235Ab1EYHoy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 03:44:54 -0400
Received: by mail-ww0-f51.google.com with SMTP id 26so7484135wwf.8
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 00:44:52 -0700 (PDT)
In-Reply-To: <87lixvy7fy.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Tue, May 24, 2011 at 17:01, Kevin Hilman <khilman@ti.com> wrote:
> "Menon, Nishanth" <nm@ti.com> writes:
>
>> On Thu, May 19, 2011 at 08:12, Kevin Hilman <khilman@ti.com> wrote:
>>> Nishanth Menon <nm@ti.com> writes:
>>>
>>>> OMAP2 does not use OPP tables at the moment for DVFS. Currently,
>>>> we depend on opp table initialization to give us the freq_table,
>>>> which makes sense for OMAP3+. for OMAP2, we should be using
>>>> clk_init_cpufreq_table - so if the opp based frequency table
>>>> initilization fails, fall back to clk_init_cpufreq_table to give
>>>> us the table.
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>
>>> This is a good approach, but for readability, the OPP version and the
>>> clk version should probably be separated into separate functions, along
>>> with their error handling.
>>
>> Was thinking more of the lines of splitting the file up. OMAP3+ all
>> have OPPs defined. only one pending is OMAP2
>> Either we introduce OPPs to OMAP2 OR we split it up and depend the OPP
>> based stuff on ARCH_HAS_OPP and CPUFREQ
>
> Let's take the latter approach, and just focus on a single OPP-based driver.
>
> When someone wants to add DVFS for OMAP2, all that's necessary is to add
> the OPPs.
yes, I have isolated the code to do that earlier today.. hopefully I
should get time to post this out asap.

Regards,
Nishanth Menon
