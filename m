From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5] clk: change clk_ops' ->determine_rate() prototype
Date: Wed, 08 Jul 2015 11:07:42 -0700
Message-ID: <559D66EE.4060707@codeaurora.org>
References: <1436294888-25752-1-git-send-email-boris.brezillon@free-electrons.com>	<20150708005748.GG30412@codeaurora.org> <20150708110005.704c49ff@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20150708110005.704c49ff@bbrezillon>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Tony Lindgren <tony@atomide.com>, Ralf Baechle <ralf@linux-mips.org>, =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Tero Kristo <t-kristo@ti.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mips@linux-mips.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/08/2015 02:00 AM, Boris Brezillon wrote:
> Hi Stephen,
>
> On Tue, 7 Jul 2015 17:57:48 -0700
> Stephen Boyd <sboyd@codeaurora.org> wrote:
>
>> On 07/07, Boris Brezillon wrote:
>>>
>>>  	} else {
>>>  		pr_err("clk: clk_composite_determine_rate function called, but no mux or rate callback set!\n");
>>> +		req->rate = 0;
>>>  		return 0;
>> Shouldn't this return an error now? And then assigning req->rate
>> wouldn't be necessary. Sorry I must have missed this last round.
>>
> Actually I wanted to keep the existing behavior: return a 0 rate (not
> an error) when there is no mux or rate ops.
>
> That's something we can change afterwards, but it might reveals
> new bugs if some users are checking for a 0 rate to detect errors.
>

Ok. Care to send the patch now to do that while we're thinking about it?
We can test it out for a month or two.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

