From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 00/11] ARM: OMAP: OMAP5 & AM43x DSS
Date: Tue, 20 May 2014 11:01:19 +0530
Message-ID: <537AE8A7.4080307@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com> <5370CBD5.3060107@ti.com> <20140512143604.GB31772@atomide.com> <5370E172.20009@ti.com> <20140512154850.GG31772@atomide.com> <5375C8E8.1020209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50932 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbaETFdB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 01:33:01 -0400
In-Reply-To: <5375C8E8.1020209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi,

On Friday 16 May 2014 01:44 PM, Tomi Valkeinen wrote:
> On 12/05/14 18:48, Tony Lindgren wrote:
>
>>>> Also, I'm wondering why we still have .clk and .opt_clks entries in the
>>>> hwmod data for am43xx and omap5 which are both device tree based with
>>>> all the clocks coming from .dts files?
>>>
>>> I think they are needed for the omap_device/hwmod stuff to work. Only
>>> omapdss driver knows about the clocks defined in the .dts files, and the
>>> omap_device/hwmod code still needs to do the reset and maybe some other
>>> tasks that require the clocks.
>>
>> We're already populating the hwmod data from dts entries, that's done by
>> omap_device_build_from_dt. Why aren't we doing that for dt defined clocks?
>>
>> I'd rather not start adding new data that will then just be removed, that's
>> what people call "pointless extra churn".
>
> I don't know why. I have to say I'm not 100% sure if that's done or not,
> but at least I can't find where it's done.

The reason why clocks are needed from hwmod data is because we still 
don't populate hwmod fields like main_clk and opt_clock from DT clocks.

The reason why this isn't done yet is because we currently haven't 
figured out a clean way to tell hwmod what clock is the main_clk, and 
what clocks are optional clocks.

One of the proposed methods was to assume the clock named to be "fck" as 
main_clk, and the remaining clocks as optional clocks for hwmod. That 
method wasn't agreed upon, this looks like the thread which discusses this:

http://marc.info/?l=linux-arm-kernel&m=138928084823142&w=2

Archit


