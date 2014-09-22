From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: change clock init to use generic of_clk_init
Date: Mon, 22 Sep 2014 10:55:32 +0300
Message-ID: <541FD5F4.6020909@ti.com>
References: <1408628959-32442-1-git-send-email-t-kristo@ti.com> <20140918171725.GL14505@atomide.com> <alpine.DEB.2.02.1409191632170.22526@utopia.booyaka.com> <541FC714.9050203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33432 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753214AbaIVHzS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Sep 2014 03:55:18 -0400
In-Reply-To: <541FC714.9050203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Stefan Assmann <sassmann@kpanic.de>

On 09/22/2014 09:52 AM, Tero Kristo wrote:
> On 09/19/2014 07:33 PM, Paul Walmsley wrote:
>> On Thu, 18 Sep 2014, Tony Lindgren wrote:
>>
>>> * Tero Kristo <t-kristo@ti.com> [140821 06:52]:
>>>> Previously, the TI clock driver initialized all the clocks
>>>> hierarchically
>>>> under each separate clock provider node. Now, each clock that requires
>>>> IO access will instead check their parent node to find out which IO
>>>> range
>>>> to use.
>>>>
>>>> This patch allows the TI clock driver to use a few new features
>>>> provided
>>>> by the generic of_clk_init, and also allows registration of clock nodes
>>>> outside the clock hierarchy (for example, any external clocks.)
>>>
>>> Paul, any comments on this one?
>>
>> Not at this point.
>
> Tony, ok to merge this through clock tree?

Oh btw, this is v1, I posted v2 a week back here:

http://article.gmane.org/gmane.linux.ports.arm.omap/118551

v2 has the retry init logic fixed in it (mainly for DPLLs which can have 
two separate parents which of both must be available during init.)

-Tero
