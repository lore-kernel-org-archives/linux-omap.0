From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3 0/3] mach-omap2: handle autoidle denial
Date: Fri, 15 Feb 2019 21:19:02 +0200
Message-ID: <a3f9aa94-33c3-9f14-1656-5bee705b3537@ti.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190121195803.GH5544@atomide.com> <20190209195105.74bb9085@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190209195105.74bb9085@aktux>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On 09/02/2019 20:53, Andreas Kemnade wrote:
> On Mon, 21 Jan 2019 11:58:03 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
>> * Andreas Kemnade <andreas@kemnade.info> [190116 14:04]:
>>> On the gta04 with a dm3730 omap_hdq does not work properly when the
>>> device enters lower power states. Idling uart1 and 2 is enough
>>> to show up that problem, if there are no other things enabled.
>>> Further research reveals that hdq iclk must not be turned off during
>>> transfers, also according to the TRM. That fact is also correctly described
>>> in the flags but the code to handle that is incomplete.
>>>
>>> To handle multiple users of a single ick, autoidle is disabled
>>> when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))
>>>
>>> Changes v3:
>>> - replace CLK_IS_BASIC
>>>
>>> Changes v2:
>>> - uses spinlocks instead of mutexes
>>> - invert counter logic
>>> - check whether clock type is basic
>>
>> For this series it's best to merge it all via the
>> clock tree along with the related clock patches:
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>>
> hmm, this is stalled. Have I missed any new objections?

Sorry, I've just been pretty busy as usual, queued up for 5.1 now, thanks.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
