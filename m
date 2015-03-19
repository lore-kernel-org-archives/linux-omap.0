From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 08/35] clk: ti: fix ti_clk_get_reg_addr error handling
Date: Thu, 19 Mar 2015 09:14:47 +0200
Message-ID: <550A7767.6030509@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com> <1424891085-10392-9-git-send-email-t-kristo@ti.com> <20150306191821.11109.2610@quantum> <20150317183808.GI31346@atomide.com> <550923DB.2020503@ti.com> <20150318170223.GR31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34597 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709AbbCSHPP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 03:15:15 -0400
In-Reply-To: <20150318170223.GR31346@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Turquette <mturquette@linaro.org>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/18/2015 07:02 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [150318 00:06]:
>> On 03/17/2015 08:38 PM, Tony Lindgren wrote:
>>> * Mike Turquette <mturquette@linaro.org> [150306 11:18]:
>>>> Quoting Tero Kristo (2015-02-25 11:04:18)
>>>>> There is a case where NULL can be a valid return value for
>>>>> ti_clk_get_reg_addr, specifically the case where both the provider index
>>>>> and register offsets are zero. In this case, the current error checking
>>>>> against a NULL pointer will fail. Thus, change the API to return a
>>>>> ERR_PTR value in an error case, and change all the users of this API to
>>>>> check against IS_ERR instead.
>>>>>
>>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>>> Cc: Michael Turquette <mturquette@linaro.org>
>>>>
>>>> Looks good to me.
>>> ...
>>>
>>>>> ---
>>>>>   drivers/clk/ti/apll.c      |    5 +++--
>>>>>   drivers/clk/ti/autoidle.c  |    2 +-
>>>>>   drivers/clk/ti/clk.c       |    7 ++++---
>>>>>   drivers/clk/ti/divider.c   |    4 ++--
>>>>>   drivers/clk/ti/dpll.c      |    6 +++---
>>>>>   drivers/clk/ti/gate.c      |    4 ++--
>>>>>   drivers/clk/ti/interface.c |    2 +-
>>>>>   drivers/clk/ti/mux.c       |    4 ++--
>>>>>   8 files changed, 18 insertions(+), 16 deletions(-)
>>>
>>> Can this patch be queued separately by Mike or is there some
>>> dependency to this series?
>>
>> Without this patch, patch #10 in the set causes a boot failure on omap3,
>> because the specific NULL value is returned for iva2_ck and the clock
>> register fails. This in turn breaks hwmod registration because iva2_ck is
>> missing.
>
> Oh OK.
>
>> I would just queue this patch as part of this series to avoid any trouble.
>
> Can this patch be applied separately before this series or does
> it cause other problems? If it can be separated, Mike can maybe put it
> into an immutable branch that I can merge in too.

Yea, that works also if Mike is okay with it.

-Tero

>
>>> Other than wondering about the above and the dts related comments,
>>> this series works for me with PM tests.
>>
>> I hope to post a series with the dts related comments fixed later today.
>
> Yes I'll take a look, thanks for doing that.
>
> Regards,
>
> Tony
>

