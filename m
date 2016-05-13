From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 00/28] ARM: OMAP2+: hwmod module clock type support
Date: Fri, 13 May 2016 13:58:44 +0300
Message-ID: <5735B364.9000504@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
 <20160512233935.GN3492@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160512233935.GN3492@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: tony@atomide.com, paul@pwsan.com, mturquette@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 13/05/16 02:39, Stephen Boyd wrote:
> On 04/14, Tero Kristo wrote:
>> Hi,
>>
>> v2 contains following changes in comparison to v1:
>>
>> - Patch ordering changed a bit, clk/ti, mach-omap2, dts patches are now
>>    mostly grouped together, with the exception of the introduction of
>>    clock helper API, which is needed by everything else. Please note
>>    that the ordering must be preserved between mach-omap2/clk-driver/dts
>>    to avoid boot problems.
>> - Dropped hwmod data removal patches for now, this allows booting with
>>    either new or old DTS data.
>> - Fixed a typo in the hwmod clock driver timeout handling, the comparison
>>    for timeout against ktime_us_delta was wrong causing too short
>>    timeouts, this was apparent with cpuidle enabled on OMAP4
>> - Added patch #6 to fetch hwmod main clock based on the hwmod name itself,
>>    if found, ignore main_clk / clkctrl setup for the hwmod
>> - Added patch #7 to fix issue in omap2 timer caused by patch #6, with
>>    dynamic parsing of main clock, the hwmod must be setup before attempting
>>    to access main_clk.
>
> What's the general design goal of this series? This cover letter
> is more like a change and test log instead of an overall argument
> for why the series should be merged so I'm left to piecing
> together the commit text from the 28 different patches. I suspect
> it's to get rid of DT_CLK macros and do something with hwmod in a
> more generic way, but that's all I got.

Sorry I think this was lost someone along the series, and looking back I 
did not explain it that well at any point either.

The major motivation of this series is to get rid of the hwmod database 
from kernel eventually, Tony is working on an interconnect driver which 
will provide most of the other functionality currently done by hwmod, 
but he is going to depend on the clkctrl part being done with this 
series. Another important aspect of the series is that hwmod clkctrl is 
now done with proper clock nodes, which provides multiple benefits like 
usecounting, better debugging capabilities, better hierarchy support etc.

-Tero

