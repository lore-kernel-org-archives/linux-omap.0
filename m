From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 4/6 v2] OMAP2: cpufreq: use clk_init_cpufreq_table if OPPs not available
Date: Tue, 24 May 2011 17:01:21 -0700
Message-ID: <87lixvy7fy.fsf@ti.com>
References: <1305704266-17623-5-git-send-email-nm@ti.com>
	<87d3jeal6r.fsf@ti.com>
	<BANLkTinKByYJ1kbRXkWsc1UWrdxcj9+84g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55528 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932838Ab1EYABZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 20:01:25 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so5521179pxi.24
        for <linux-omap@vger.kernel.org>; Tue, 24 May 2011 17:01:24 -0700 (PDT)
In-Reply-To: <BANLkTinKByYJ1kbRXkWsc1UWrdxcj9+84g@mail.gmail.com> (Nishanth
	Menon's message of "Thu, 19 May 2011 08:51:26 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

> On Thu, May 19, 2011 at 08:12, Kevin Hilman <khilman@ti.com> wrote:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> OMAP2 does not use OPP tables at the moment for DVFS. Currently,
>>> we depend on opp table initialization to give us the freq_table,
>>> which makes sense for OMAP3+. for OMAP2, we should be using
>>> clk_init_cpufreq_table - so if the opp based frequency table
>>> initilization fails, fall back to clk_init_cpufreq_table to give
>>> us the table.
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>
>> This is a good approach, but for readability, the OPP version and the
>> clk version should probably be separated into separate functions, along
>> with their error handling.
>
> Was thinking more of the lines of splitting the file up. OMAP3+ all
> have OPPs defined. only one pending is OMAP2
> Either we introduce OPPs to OMAP2 OR we split it up and depend the OPP
> based stuff on ARCH_HAS_OPP and CPUFREQ

Let's take the latter approach, and just focus on a single OPP-based driver.

When someone wants to add DVFS for OMAP2, all that's necessary is to add
the OPPs.

Kevin
