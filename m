From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 1/2] clk: change clk_ops' ->round_rate() prototype
Date: Fri, 5 Jun 2015 09:46:09 +0100
Message-ID: <557161D1.3040107@nvidia.com>
References: <1430407809-31147-1-git-send-email-boris.brezillon@free-electrons.com> <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com> <alpine.DEB.2.02.1506042258530.12316@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1506042258530.12316@utopia.booyaka.com>
Sender: linux-media-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawn.guo@linaro.org>, ascha Hauer <kernel@pengutronix.de>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Max Filippov <jcmvbkbc@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-omap@vger.kernel.org


On 05/06/15 00:02, Paul Walmsley wrote:
> Hi folks
> 
> just a brief comment on this one:
> 
> On Thu, 30 Apr 2015, Boris Brezillon wrote:
> 
>> Clock rates are stored in an unsigned long field, but ->round_rate()
>> (which returns a rounded rate from a requested one) returns a long
>> value (errors are reported using negative error codes), which can lead
>> to long overflow if the clock rate exceed 2Ghz.
>>
>> Change ->round_rate() prototype to return 0 or an error code, and pass the
>> requested rate as a pointer so that it can be adjusted depending on
>> hardware capabilities.
> 
> ...
> 
>> diff --git a/Documentation/clk.txt b/Documentation/clk.txt
>> index 0e4f90a..fca8b7a 100644
>> --- a/Documentation/clk.txt
>> +++ b/Documentation/clk.txt
>> @@ -68,8 +68,8 @@ the operations defined in clk.h:
>>  		int		(*is_enabled)(struct clk_hw *hw);
>>  		unsigned long	(*recalc_rate)(struct clk_hw *hw,
>>  						unsigned long parent_rate);
>> -		long		(*round_rate)(struct clk_hw *hw,
>> -						unsigned long rate,
>> +		int		(*round_rate)(struct clk_hw *hw,
>> +						unsigned long *rate,
>>  						unsigned long *parent_rate);
>>  		long		(*determine_rate)(struct clk_hw *hw,
>>  						unsigned long rate,
> 
> I'd suggest that we should probably go straight to 64-bit rates.  There 
> are already plenty of clock sources that can generate rates higher than 
> 4GiHz.

An alternative would be to introduce to a frequency "base" the default
could be Hz (for backwards compatibility), but for CPUs we probably only
care about MHz (or may be kHz) and so 32-bits would still suffice. Even
if CPUs cared about Hz they could still use Hz, but in that case they
probably don't care about GHz. Obviously, we don't want to break DT
compatibility but may be the frequency base could be defined in DT and
if it is missing then Hz is assumed. Just a thought ...

Jon
