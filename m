From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v7 1/3] Documentation: common clk API
Date: Wed, 21 Mar 2012 12:41:41 -0700
Message-ID: <4F6A2EF5.3010008@codeaurora.org>
References: <4F6A2042.9030302@codeaurora.org> <20120321190741.GL3226@opensource.wolfsonmicro.com> <20120321193304.GO9859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120321193304.GO9859@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Paul Walmsley <paul@pwsan.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Amit Kucheria <amit.kucheria@linaro.org>, linaro-dev@lists.linaro.org, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Jeremy Kerr <jeremy.kerr@canonical.com>, Mike Turquette <mturquette@ti.com>, Mike Turquette <mturquette@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Deepak Saxena <dsaxena@linaro.org>, patches@linaro.org, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Zhao <richard.zhao@linaro.org>, Shawn Guo <shawn.guo@freescale.com>, Linus Walleij <linus.walleij@stericsson.com>, Stephen Boyd <sboyd@codeaurora.org>l
List-Id: linux-omap@vger.kernel.org

On 03/21/2012 12:33 PM, Tony Lindgren wrote:
> * Mark Brown<broonie@opensource.wolfsonmicro.com>  [120321 12:11]:
>> On Wed, Mar 21, 2012 at 11:38:58AM -0700, Saravana Kannan wrote:
>>
>>>> So it would be interesting to know more about why you (or anyone else)
>>>> perceive that the Kconfig changes would be harmful.
>>
>>> But the enthusiasm of the clock driver developers doesn't
>>> necessarily translate to users of the clock APIs (other driver
>>> devs). My worry with marking it as experimental in Kconfig and to a
>>> certain extent in the documentation is that it will discourage the
>>> driver devs from switching to the new APIs. If no one is using the
>>> new APIs, then platforms can't switch to the common clock framework
>>
>> These aren't new APIs, the clock API has been around since forever.

I disagree. When I say clock API, I mean the actual functions and their 
semantics. Not the existence of a header file.

The meaning of clk_enable/disable has been changed and they won't work 
without calling clk_prepare/unprepare. So, these are definitely new 
APIs. If it weren't new APIs, then none of the general drivers would 
need to change.

>> For driver authors working on anything that isn't platform specific the
>> issue has been that it's not implemented at all on the overwhelming
>> majority of architectures and those that do all have their own random
>> implementations with their own random quirks and with no ability for
>> anything except the platform to even try to do incredibly basic stuff
>> like register a new clock.
>>
>> Simply having something, anything, in place even if it's going to churn
>> is a massive step forward here for people working with clocks.
>
> Right, and now at least the people reading this thread are pretty
> aware of the yet unsolved issues with clock fwk api :)

:-) Shhh... not so loud!

-Saravana


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
