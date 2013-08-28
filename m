From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH v2 10/13] ARM: OMAP2+: hwmod: AM43x operations
Date: Wed, 28 Aug 2013 17:59:48 +0530
Message-ID: <521DED3C.2040407@ti.com>
References: <cover.1375443858.git.afzal@ti.com> <838ab5ad788f64cef1e8859409490aa2b495d1ee.1375443858.git.afzal@ti.com> <5214A4D5.4000700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59511 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753718Ab3H1MaR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Aug 2013 08:30:17 -0400
In-Reply-To: <5214A4D5.4000700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, Paul Walmsley <paul@pwsan.com>, Ambresh K <ambresh@ti.com>, benoit.cousson@gmail.com

Hi Rajendra,

On Wednesday 21 August 2013 05:00 PM, Rajendra Nayak wrote:
> On Friday 02 August 2013 07:08 PM, Afzal Mohammed wrote:

>> Reuse OMAP4 operations on AM43x.
>>
>> Signed-off-by: Ambresh K <ambresh@ti.com>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod.c |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index 7f4db12..a1b7e20 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -4123,6 +4123,14 @@ void __init omap_hwmod_init(void)
>>  		soc_ops.init_clkdm = _init_clkdm;
>>  		soc_ops.update_context_lost = _omap4_update_context_lost;
>>  		soc_ops.get_context_lost = _omap4_get_context_lost;
>> +	} else if (soc_is_am43xx()) {
>> +		soc_ops.enable_module = _omap4_enable_module;
>> +		soc_ops.disable_module = _omap4_disable_module;
>> +		soc_ops.wait_target_ready = _omap4_wait_target_ready;
>> +		soc_ops.assert_hardreset = _omap4_assert_hardreset;
>> +		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
>> +		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
>> +		soc_ops.init_clkdm = _init_clkdm;
> 
> Did you leave out soc_ops.update_context_lost and soc_ops.get_context_lost on
> purpose?

As far as I understand, primarily driver make use of this with the help
of function pointers passed through platform data. And as am43x is a DT
only platform, it was left out.

Regards
Afzal

