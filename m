From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 1/3] ARM: omap: clk: add clk_prepare and clk_unprepare
Date: Mon, 02 Jul 2012 15:17:45 +0530
Message-ID: <4FF16E41.8020906@ti.com>
References: <1340786915-29507-1-git-send-email-rnayak@ti.com> <1340786915-29507-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1206291416180.2338@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:45878 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932717Ab2GBJrz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 05:47:55 -0400
Received: by obbup19 with SMTP id up19so3880441obb.26
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 02:47:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1206291416180.2338@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: mturquette@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Saturday 30 June 2012 01:49 AM, Paul Walmsley wrote:
> Hi
>
> On Wed, 27 Jun 2012, Rajendra Nayak wrote:
>
>> As part of Common Clk Framework (CCF) the clk_enable() operation
>> was split into a clk_prepare() which could sleep, and a clk_enable()
>> which should never sleep. Similarly the clk_disable() was
>> split into clk_disable() and clk_unprepare(). This was
>> needed to handle complex cases where in a clk gate/ungate
>> would require a slow and a fast part to be implemented.
>> None of the clocks below seem to be in the 'complex' clocks
>> category and are just simple clocks which are enabled/disabled
>> through simple register writes.
>> Most of the instances also seem to be called in non-atomic
>> context which means its safe to move all of those from
>> using a clk_enable() to clk_prepare_enable() and clk_disable() to
>> clk_disable_unprepare().
>> For a few others where there is a possibility they get called from
>> an interrupt or atomic context, there is an additonal clk_prepare()
>> done before a clk_enable() and a clk_unprepare()
>> after a clk_disable().
>> This is in preparation of OMAP moving to CCF.
>>
>> Based on initial changes from Mike turquette.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> This patch generates quite a few checkpatch warnings:
>
> WARNING: please, no space before tabs
> #294: FILE: arch/arm/mach-omap2/clock3xxx_data.c:3479:
> +^ICLK(NULL, ^I"mcbsp4_ick",^I&mcbsp2_ick,^ICK_3XXX),$
>
> etc.
>
> Please fix these.
>
> The 80 column warnings from checkpatch on the CLK(... lines can be
> ignored.

Sorry, I seemed to have overlooked these thinking all to be 80 column
warnings. Will fix all the non 80 column warnings and repost.

regards,
Rajendra

>
>
> - Paul

