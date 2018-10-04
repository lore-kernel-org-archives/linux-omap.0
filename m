From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH RFC 0/2] mach-omap2: handle autoidle denial
Date: Thu, 4 Oct 2018 17:42:25 +0300
Message-ID: <013b01a1-2593-bdc0-dd9a-e5a114388067@ti.com>
References: <20181004055147.23048-1-andreas@kemnade.info>
 <20181004142558.GB5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004142558.GB5662@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Andreas Kemnade <andreas@kemnade.info>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, paul@pwsan.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On 04/10/18 17:25, Tony Lindgren wrote:
> * Andreas Kemnade <andreas@kemnade.info> [181004 05:56]:
>> On the gta04 with a dm3730 omap_hdq does not work properly when the
>> device enters lower power states. Idling uart1 and 2 is enough
>> to show up that problem, if there are no other things enabled.
>> Further research reveals that hdq iclk must not be turned off during
>> transfers, also according to the TRM. That fact is also correctly described
>> in the flags but the code to handle that is incomplete.
>>
>> Since the order is first disable all autoidles, then disable selected
>> and then enable all, we need to either change that order or add
>> a usecount. Since it is done only in init, we could think about changing
>> order.
> 
> These patches look OK to me, assuming Tero will review them more
> closely.

There is no locking whatsoever in the autoidle counting atm, that must 
be fixed otherwise you get races.

> It seems we should just provide a generic interface for
> clk_allow_autoidle() and clk_deny_autoidle()? Otherwise we'll
> be forever stuck with pdata callbacks it seems.

The TI clock driver is actually providing these APIs, so that should be 
fine. I don't think there is any use / need for pdata callbacks atm, it 
just happens hwmod core is calling these at the moment which might have 
confused you.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
