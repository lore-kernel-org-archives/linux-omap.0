From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: ads7846 init: fix fault caused by freeing pen-down GPIO
Date: Fri, 27 Jul 2012 12:05:51 -0700
Message-ID: <87pq7hja7k.fsf@ti.com>
References: <1342048700-15040-1-git-send-email-khilman@ti.com>
	<500D494D.8020606@compulab.co.il> <500D4F2A.9090706@compulab.co.il>
	<87zk6mpbfa.fsf@ti.com> <5012E4F0.20609@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:52170 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752404Ab2G0TGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jul 2012 15:06:18 -0400
Received: by pbbro8 with SMTP id ro8so6243435pbb.39
        for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 12:05:52 -0700 (PDT)
In-Reply-To: <5012E4F0.20609@compulab.co.il> (Igor Grinberg's message of "Fri,
	27 Jul 2012 21:58:56 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Zumeng Chen <zumeng.chen@windriver.com>

Igor Grinberg <grinberg@compulab.co.il> writes:

> On 07/26/12 22:30, Kevin Hilman wrote:
>> + Zumeng Chen
>> 
>> Igor Grinberg <grinberg@compulab.co.il> writes:
>> 
>>> Hi Kevin,
>>>
>>> I've just noticed that the patch has been modified by Arnd in a way
>>> that of course will trigger GPIO use without being requested.
>>> I'm sorry, I was not available by that time Arnd changed the patch.
>> 
>> Your right, your original patch isn't the problem.  I found the root
>> cause.
>> 
>> The real problem is actually introduced by the merge of your patch from
>> the arm-soc/cleanup branch, and this one from Zumeng Chen: commit
>> 16aced80f6 (ARM: OMAP3530evm: set pendown_state and debounce time for
>> ads7846) from the arm-soc/boards branch.
>> 
>> However, looking closer at the one from Zumeng, that one is clearly not
>> right.  It unconditionally adds a *board-specific* ->get_pendown_state
>> function to the pdata that is common to *all* boards.  That's just wrong
>> and has the side-effect of making ->get_pendown_state() wrong on every
>> board except the OMAP3EVM.  Oops.
>> 
>> So, IMO, in addition to $SUBJECT patch, in order to get the touchscreen
>> GPIO working on non OMAP3EVM boards, we also need something like this as
>> well.
>> 
>> Igor, Zumeng, could you try this out on your boards anc confirm if it's
>> working?  I currently don't have a board setup with a touchscreen in my
>> board farm.
>> 
>> Kevin
>> 
>>>From 85516c6a3354967caf4cff434d28c3001cd411eb Mon Sep 17 00:00:00 2001
>> From: Kevin Hilman <khilman@ti.com>
>> Date: Thu, 26 Jul 2012 12:15:38 -0700
>> Subject: [PATCH 2/2] ARM: OMAP2+: ads7846: fix ->get_pendown_state() to work
>>  on all boards
>> 
>> commit 16aced80f6 (ARM: OMAP3530evm: set pendown_state and debounce
>> time for ads7846) introduced a common ->get_pendown_state() function
>> into the generic code, but that function was board-specific for the
>> OMAP3EVM.
>> 
>> Fix this up to work for all boards that pass in a pendown GPIO.
>> 
>> Cc: Zumeng Chen <zumeng.chen@windriver.com>
>> Cc: Igor Grinberg <grinberg@compulab.co.il>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> Tested-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks to both of you for testing, I've updated the branch to include
the tags, and will submit during the v3.6-rc cycle.

Thanks,

Kevin
