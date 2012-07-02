From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod data: Fix wrong McBSP clock alias
 on OMAP4
Date: Mon, 2 Jul 2012 17:45:52 +0200
Message-ID: <4FF1C230.8030102@ti.com>
References: <4FDEF7FE.9040202@ti.com> <alpine.DEB.2.00.1206180957250.9031@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48987 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753972Ab2GBPqB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 11:46:01 -0400
In-Reply-To: <alpine.DEB.2.00.1206180957250.9031@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>

Hi Paul,

On 06/18/2012 05:57 PM, Paul Walmsley wrote:
> On Mon, 18 Jun 2012, Cousson, Benoit wrote:
>
>> The commit 503d0ea24d1d3dd3db95e5e0edd693da7a2a23eb
>>    ARM: OMAP4: hwmod data: Add aliases for McBSP fclk clocks
>>
>> added a wrong "prcm_clk" alias for PRCM clock whereas the McBSP
>> driver and previous OMAPs are using "prcm_fck".
>>
>> It thus lead to the following warning.
>>
>> [   47.409729] omap-mcbsp: clks: could not clk_get() prcm_fck
>>
>> Fix that by changing the opt_clk role to prcm_fck.
>>
>> Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Tested-by: Sebastien Guiriec <s-guiriec@ti.com>
>
> Thanks, will queue this as part of the next 3.5-rc series.

I might be wrong but it seems that this one is not yet in 3.5-rc5.

Thanks,
Benoit
