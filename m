From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: Fix OMAP3 ISP functional clock configuration
Date: Mon, 19 May 2014 16:11:48 +0300
Message-ID: <537A0314.4080001@ti.com>
References: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com> <8771357.o1oFFUoBzb@avalon> <20140513010610.GJ5668@atomide.com> <1740476.H24kT8Bx1K@avalon> <5374E337.7070703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38279 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932366AbaESNMA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 May 2014 09:12:00 -0400
In-Reply-To: <5374E337.7070703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 05/15/2014 06:54 PM, Tero Kristo wrote:
> On 05/15/2014 06:53 PM, Laurent Pinchart wrote:
>> On Monday 12 May 2014 18:06:10 Tony Lindgren wrote:
>>> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [140512 16:17]:
>>>> On Thursday 08 May 2014 13:57:15 Tomi Valkeinen wrote:
>>>>> On 21/04/14 13:41, Laurent Pinchart wrote:
>>>>>> Hello,
>>>>>>
>>>>>> This patch set enables rate propagation from the OMAP3 ISP functional
>>>>>> clock to the DPLL4 M5 clock. It copies Tomi Valkeinen's similar patch
>>>>>> set for the OMAP DSS functional clock from the "OMAP: OMAP3 DSS
>>>>>> related clock patches" patch series.
>>>>>>
>>>>>> Laurent Pinchart (2):
>>>>>>    ARM: dts: use ti,fixed-factor-clock for dpll4_m5x2_mul_ck
>>>>>>    ARM: dts: set 'ti,set-rate-parent' for dpll4_m5 path
>>>>>>
>>>>>>   arch/arm/boot/dts/omap36xx-clocks.dtsi | 2 +-
>>>>>>   arch/arm/boot/dts/omap3xxx-clocks.dtsi | 7 ++++---
>>>>>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>>>>
>>>>> These look fine to me.
>>>>>
>>>>> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>>>
>>>> Thank you.
>>>>
>>>> Tony, could you please pick the patches up for v3.16 ?
>>>
>>> I'd like to see acks from Tero on these two, or Tero queue
>>> them along with other clock dts clock changes.
>>
>> I'm fine with Tero queuing the patches in his tree. Tero, could they
>> go in
>> v3.16 ?
>>
>
> Yeah, am fine with these, I'll queue these in my branch once I have
> those setup.

Just to let you know, I have now queued these patches in my branch for 
3.16/clk-dt.

-Tero
