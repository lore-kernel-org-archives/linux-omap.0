From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2 0/2] ARM: OMAP4: Fix gpmc_fck clock
Date: Tue, 25 Feb 2014 18:05:29 -0600
Message-ID: <530D2FC9.2010800@ti.com>
References: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch> <5304DA2C.3030605@ti.com> <53050573.8090506@epfl.ch> <20140223212309.22529.75068@quantum> <530ADC39.1010300@epfl.ch> <20140225062615.22529.88499@quantum> <530C4FED.80403@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53554 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbaBZAF7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Feb 2014 19:05:59 -0500
In-Reply-To: <530C4FED.80403@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch, Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>

Florian,

On 02/25/2014 02:10 AM, Florian Vaussard wrote:
> On 02/25/2014 07:26 AM, Mike Turquette wrote:
>> Quoting Florian Vaussard (2014-02-23 21:44:25)
>>> On 02/23/2014 10:23 PM, Mike Turquette wrote:
>>>> Quoting Florian Vaussard (2014-02-19 11:26:43)
>>>>>
>>>>> On 02/19/2014 05:22 PM, Tero Kristo wrote:
>>>>>> On 02/19/2014 11:15 AM, Florian Vaussard wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> Trying to get my SMSC9221 working on OMAP4 with DT,
>>>>>>> I faced a misconfigured gpmc_fck (dummy clock set to 0)
>>>>>>> resulting in serveral division-by-zero, misconfigured
>>>>>>> timings and driver lost in the La La Land.
>>>>>>>
>>>>>>> To solve this, patch 1 removes gpmc_fck from the dummy
>>>>>>> clocks, and patch 2 adds the gpmc_fck DT node and
>>>>>>> reference it from the gpmc node.
>>>>>>>
>>>>>>> Tested on DuoVero/Parlor (OMAP4430) with SMSC9221.
>>>>>>
>>>>>> I can't test GPMC myself, but other than that, this set looks good to go.
>>>>>>
>>>>>
>>>>> Thank you. Would you like more test coverage by other people? I would
>>>>> like to see this in -rc if possible, as it is needed to boot my OMAP4
>>>>> system.
>>>>
>>>> What OMAP4 system is this? Is this a regression for board that already
>>>> has support merged into mainline?
>>>>
>>>
>>> No, it is not yet merged into mainline. I was planning to post the DTS
>>> this week, when most issues are cleared. Looking at the current mainline
>>> boards, no one seems to use the GPMC, so I am just the first one to hit
>>> this issue.
>>
>> OK, well typically the later -rc's are for fixing observed regressions.
>> Since your platform is not yet merged in then it's probably fine to push
>> this for 3.15.
>>
>
> Fair enough. 3.15 is fine.
>
>> This also gives time to test the fix for other OMAP-ish processors.
>>
>
> I can do the v3, including OMAP5 and DRA7. But for DRA7, I will need
> someone with the TRM telling me where is connected gpmc_fclk (Suman?).

For DRA7, GPMC is connected off L3MAIN1_L3_GICLK (compared to 
L3MAIN2_L3_GICLK on OMAP5), both of which are actually just L3_ICLK.
This is the l3_iclk_div in both the omap54xx-clocks.dtsi and 
dra7xx-clocks.dtsi files.

regards
Suman

