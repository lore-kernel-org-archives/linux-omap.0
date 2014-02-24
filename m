From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v2 0/2] ARM: OMAP4: Fix gpmc_fck clock
Date: Mon, 24 Feb 2014 06:44:25 +0100
Message-ID: <530ADC39.1010300@epfl.ch>
References: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch> <5304DA2C.3030605@ti.com> <53050573.8090506@epfl.ch> <20140223212309.22529.75068@quantum>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:44225 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbaBXGsi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Feb 2014 01:48:38 -0500
In-Reply-To: <20140223212309.22529.75068@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, =?ISO-8859-1?Q?=22=5C=22_Beno=EEt_Cousson=22?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 02/23/2014 10:23 PM, Mike Turquette wrote:
> Quoting Florian Vaussard (2014-02-19 11:26:43)
>>
>> On 02/19/2014 05:22 PM, Tero Kristo wrote:
>>> On 02/19/2014 11:15 AM, Florian Vaussard wrote:
>>>> Hello,
>>>>
>>>> Trying to get my SMSC9221 working on OMAP4 with DT,
>>>> I faced a misconfigured gpmc_fck (dummy clock set to 0)
>>>> resulting in serveral division-by-zero, misconfigured
>>>> timings and driver lost in the La La Land.
>>>>
>>>> To solve this, patch 1 removes gpmc_fck from the dummy
>>>> clocks, and patch 2 adds the gpmc_fck DT node and
>>>> reference it from the gpmc node.
>>>>
>>>> Tested on DuoVero/Parlor (OMAP4430) with SMSC9221.
>>>
>>> I can't test GPMC myself, but other than that, this set looks good to go.
>>>
>>
>> Thank you. Would you like more test coverage by other people? I would
>> like to see this in -rc if possible, as it is needed to boot my OMAP4
>> system.
> 
> What OMAP4 system is this? Is this a regression for board that already
> has support merged into mainline?
> 

No, it is not yet merged into mainline. I was planning to post the DTS
this week, when most issues are cleared. Looking at the current mainline
boards, no one seems to use the GPMC, so I am just the first one to hit
this issue.

Regards,
Florian
