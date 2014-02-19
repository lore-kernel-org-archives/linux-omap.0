From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v2 0/2] ARM: OMAP4: Fix gpmc_fck clock
Date: Wed, 19 Feb 2014 20:26:43 +0100
Message-ID: <53050573.8090506@epfl.ch>
References: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch> <5304DA2C.3030605@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:59824 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754692AbaBST04 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Feb 2014 14:26:56 -0500
In-Reply-To: <5304DA2C.3030605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 02/19/2014 05:22 PM, Tero Kristo wrote:
> On 02/19/2014 11:15 AM, Florian Vaussard wrote:
>> Hello,
>>
>> Trying to get my SMSC9221 working on OMAP4 with DT,
>> I faced a misconfigured gpmc_fck (dummy clock set to 0)
>> resulting in serveral division-by-zero, misconfigured
>> timings and driver lost in the La La Land.
>>
>> To solve this, patch 1 removes gpmc_fck from the dummy
>> clocks, and patch 2 adds the gpmc_fck DT node and
>> reference it from the gpmc node.
>>
>> Tested on DuoVero/Parlor (OMAP4430) with SMSC9221.
> 
> I can't test GPMC myself, but other than that, this set looks good to go.
> 

Thank you. Would you like more test coverage by other people? I would
like to see this in -rc if possible, as it is needed to boot my OMAP4
system.

Regards,
Florian
