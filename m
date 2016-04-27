From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 4/5] ARM: dts: omap5: describe control for ckobuffer
Date: Wed, 27 Apr 2016 16:35:01 +0200
Message-ID: <40536322-073F-48BD-9D07-32B9A9F07AF2@goldelico.com>
References: <cover.1461003660.git.hns@goldelico.com> <a5fb89737594a656318896a8e43814c21ca992eb.1461003660.git.hns@goldelico.com> <20160426172710.GI5995@atomide.com> <70572DA1-BEB4-4681-BA6C-2E1C9002D730@goldelico.com> <5720B107.4000907@ti.com> <A90F1BFC-A834-4EC0-81F9-2C8222AAA010@goldelico.com> <5720C85B.9010701@ti.com> <ce9a7840-e86f-0d0c-3ed6-a571eec6659d@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ce9a7840-e86f-0d0c-3ed6-a571eec6659d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Laxman Dewangan <ldewangan@nvidia.com>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

HI,

> Am 27.04.2016 um 16:23 schrieb Peter Ujfalusi <peter.ujfalusi@ti.com>:
> 
> On 04/27/2016 05:10 PM, Tero Kristo wrote:
>> On 27/04/16 16:10, H. Nikolaus Schaller wrote:
>>> 
>>>> Am 27.04.2016 um 14:31 schrieb Tero Kristo <t-kristo@ti.com>:
>>>> 
>>>> On 27/04/16 09:04, H. Nikolaus Schaller wrote:
>>>>> 
>>>>>> Am 26.04.2016 um 19:27 schrieb Tony Lindgren <tony@atomide.com>:
>>>>>> 
>>>>>> Tero,
>>>>>> 
>>>>>> * H. Nikolaus Schaller <hns@goldelico.com> [160418 11:23]:
>>>>>>> OMAP5 has a register to control if the ckobuffer is enabled
>>>>>>> and defines the polarity. ckobuffer is required to drive a twl6040
>>>>>>> with the system clock. Hence, add the pinctrl,single to the
>>>>>>> OMAP5 SoC description so that omap5-board-common can
>>>>>>> set up the ckobuffer as required.
>>>>>> 
>>>>>> Is this really a mux or should it be a mux clock?
>>>>> 
>>>>> It is a pinmux setting for the clock out buffer to choose what signal
>>>>> (and polarity) is presented on the fref_xtal_clk pad.
>>>>> 
>>>>> The register is part of the CTRL_MODULE_WKUP.
>>>>> The clock signal is the xtal master clock of the whole SoC.
>>>>> 
>>>>> Although there is a bit to choose an alternate clock, there is no
>>>>> alternate in the OMAP5 silicon.
>>>>> 
>>>>> Therefore I would say it is about padconf and not clock or clock mux
>>>>> related.
>>>>> 
>>>>> It just happens to be a clock signal which can be routed to this
>>>>> pad.
>>>> 
>>>> The two could very well be implemented as clock nodes, a mux and a gate.
>>>> This would describe the hardware functionality better imo, if the
>>>> assumptions made here are correct. Implementing the control as pinctrl
>>>> hacks looks rather weird to me.
>>> 
>>> Why do you consider it a "pinctrl hack"? IMHO it is not a hack, but 100%
>>> proper use of pinctrl.
>> 
>> It is just the level of abstraction we are talking about here. If it is a
>> clock we are controlling, we should rather control it as a clock (higher level
>> abstraction), not a pin.
> 
> I second this. I think it is better to have a simple gate clock and handle
> only CONTROL_CKOBUFFER:CKOBUFFER_CLK_EN (bit 28) only as the other bits does
> not have real use.
> 
> Then we can add clk API support for this. On most OMAP4 devices the clock is
> always on,

this is why I am raising the question if we really want to control it on the omap5 or just 
turn it on for all omap5 boards like the omap4 appears to do... I.e. if turning the pin on
as a pinctrl is IMHO sufficient for all practical purposes.

> so the board DTS file need to provide a dummy clock, or we can make
> the high precision clock also as optional (on panda both OMAP4 and twl6040
> uses the same reference clock).

Hm. It looks as if implementing this (and clock gating) is beyond my experiences.
But I am happy to test a proposal on our omap5 board.

BR and thanks,
Nikolaus
