From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH RFC 0/2] mach-omap2: handle autoidle denial
Date: Thu, 4 Oct 2018 18:48:06 +0300
Message-ID: <5373dfa1-4134-6d3f-0b66-46eef723d43f@ti.com>
References: <20181004055147.23048-1-andreas@kemnade.info>
 <20181004142558.GB5662@atomide.com>
 <013b01a1-2593-bdc0-dd9a-e5a114388067@ti.com>
 <20181004150751.GF5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004150751.GF5662@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, paul@pwsan.com, letux-kernel@openphoenux.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

On 04/10/18 18:07, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [181004 14:47]:
>> On 04/10/18 17:25, Tony Lindgren wrote:
>>> It seems we should just provide a generic interface for
>>> clk_allow_autoidle() and clk_deny_autoidle()? Otherwise we'll
>>> be forever stuck with pdata callbacks it seems.
>>
>> The TI clock driver is actually providing these APIs, so that should be
>> fine. I don't think there is any use / need for pdata callbacks atm, it just
>> happens hwmod core is calling these at the moment which might have confused
>> you.
> 
> Hmm OK. So do we already have some way to deny autoidle for a
> clock from ti-sysc.c driver without pdata callbacks?
> 
> Suman pointed out few days ago that for a reset driver to work
> we must do clkdm_deny_idle() and clkdm_allow_idle() as the hwmod
> code does. I gues that really just boils down to doing clk deny
> idle and allow idle on the clockdomain clkctrl clock?

Clkdm handling is done via pdata callbacks, that is a separate topic 
from iclk autoidle. Iclk:s are effectively only for omap3, clkdm 
autoidle / deny_idle etc. are a generic mechanism that must be used on 
omap4+ if you want to prevent autoidle of certain domains/IPs.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
