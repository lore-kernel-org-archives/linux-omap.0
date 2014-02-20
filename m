From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 0/2] ARM: OMAP4: Fix gpmc_fck clock
Date: Thu, 20 Feb 2014 11:51:41 +0200
Message-ID: <5305D02D.5020702@ti.com>
References: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch> <5304DA2C.3030605@ti.com> <53050573.8090506@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49657 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbaBTJwM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Feb 2014 04:52:12 -0500
In-Reply-To: <53050573.8090506@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 02/19/2014 09:26 PM, Florian Vaussard wrote:
>
> On 02/19/2014 05:22 PM, Tero Kristo wrote:
>> On 02/19/2014 11:15 AM, Florian Vaussard wrote:
>>> Hello,
>>>
>>> Trying to get my SMSC9221 working on OMAP4 with DT,
>>> I faced a misconfigured gpmc_fck (dummy clock set to 0)
>>> resulting in serveral division-by-zero, misconfigured
>>> timings and driver lost in the La La Land.
>>>
>>> To solve this, patch 1 removes gpmc_fck from the dummy
>>> clocks, and patch 2 adds the gpmc_fck DT node and
>>> reference it from the gpmc node.
>>>
>>> Tested on DuoVero/Parlor (OMAP4430) with SMSC9221.
>>
>> I can't test GPMC myself, but other than that, this set looks good to go.
>>
>
> Thank you. Would you like more test coverage by other people? I would
> like to see this in -rc if possible, as it is needed to boot my OMAP4
> system.

Well, I just think the driver clock change should be acked by someone 
who knows gpmc better than me.

-Tero

