From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 00/27] ARM: OMAP2+: clock code move under clk driver
Date: Thu, 4 Jun 2015 08:26:09 +0300
Message-ID: <556FE171.5010000@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com> <20150526160557.GD16525@atomide.com> <20150526163216.GF16525@atomide.com> <20150526163931.GO26599@saruman.tx.rr.com> <55660D5B.8020607@ti.com> <20150527231536.GD30984@atomide.com> <556EF42A.9000207@ti.com> <20150603231136.6017.65683@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37024 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbbFDF0K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Jun 2015 01:26:10 -0400
In-Reply-To: <20150603231136.6017.65683@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 06/04/2015 02:11 AM, Michael Turquette wrote:
> Quoting Tero Kristo (2015-06-03 05:33:46)
>> On 05/28/2015 02:15 AM, Tony Lindgren wrote:
>>> * Tero Kristo <t-kristo@ti.com> [150527 11:32]:
>>>> On 05/26/2015 07:39 PM, Felipe Balbi wrote:
>>>>> On Tue, May 26, 2015 at 09:32:16AM -0700, Tony Lindgren wrote:
>>>>>> * Tony Lindgren <tony@atomide.com> [150526 09:08]:
>>>>>>> * Tero Kristo <t-kristo@ti.com> [150525 08:01]:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> As requested, posting v3 with somewhat changed diff parameters and
>>>>>>>> diffstat attached. Just some minor Makefile changes compared to v2,
>>>>>>>> these were discussed under that set.
>>>>>>>>
>>>>>>>> Set has been pushed to:
>>>>>>>> - tree: https://github.com/t-kristo/linux-pm.git
>>>>>>>> - branch: for-4.2/ti-clk-move
>>>>>>>
>>>>>>> Looks like this causes a build error for at least omap2 only .config:
>>>>>>>
>>>>>>> drivers/clk/ti/dpll3xxx.o:(.rodata+0x1c): multiple definition of `clkhwops_omap3_dpll'
>>>>>>> drivers/clk/ti/dpll.o:(.rodata+0x0): first defined here
>>>>>>>
>>>>>>> You may want to create a file selecting ARCH_OMAP2PLUS=y, then point
>>>>>>> KCONFIG_ALLCONFIG to that file for make randconfig. Then just build
>>>>>>> randconfigs :) Usually the issues like this are exposed within few
>>>>>>> randconfig builds, some take longer if the options have dependencies.
>>>>>
>>>>> alternatively, just clone the repository at [1] and use the example
>>>>> script provided in README.md.
>>>>>
>>>>> [1] https://github.com/felipebalbi/omap-seeds
>>>>>
>>>>
>>>> Ok, I pushed an updated branch named: for-4.2/ti-clk-move-v4
>>>>
>>>> This definitely compiles with OMAP2 / OMAP3 / OMAP4 / OMAP5 / DRA7 / AM33xx
>>>> / AM43xx only setups (tried it out.)
>>>
>>> Thanks yeah seems to work for me now.
>>>
>>> Regards,
>>>
>>> Tony
>>>
>>
>> Question to Mike / Stephen, any chance of getting this in during the 4.2
>> merge anymore seeing we are already at 4.1-rc6?
>>
>> I can send a pull request if yes. Otherwise I just wait until we are
>> past the next merge.
>
> Hi Tero,
>
> I'd like more time for any regressions this introduces to be fixed, so
> lets push back to next merge window. The always-wrong-but-never-by-much
> crystal ball[0] predicts June 14. This is less than two weeks away, so
> the wait should be short.

Ok, I'll rebase this against rc1 and send a pull-request once we have it.

-Tero

>
> [0] http://phb-crystal-ball.org/
>
> Thanks,
> Mike
>
>>
>> -Tero

