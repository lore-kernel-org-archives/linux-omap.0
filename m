From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 09/43] CLK: ti: add support for ti divider-clock
Date: Mon, 4 Nov 2013 12:54:43 +0200
Message-ID: <52777CF3.7000802@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-10-git-send-email-t-kristo@ti.com> <52729B50.5060503@ti.com> <527378FF.6020905@ti.com> <52737A73.5010700@ti.com> <52740283.8040201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43699 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789Ab3KDKzQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Nov 2013 05:55:16 -0500
In-Reply-To: <52740283.8040201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11/01/2013 09:35 PM, Nishanth Menon wrote:
> On 11/01/2013 04:54 AM, Tero Kristo wrote:
>> On 11/01/2013 11:48 AM, Tero Kristo wrote:
>>> On 10/31/2013 08:02 PM, Nishanth Menon wrote:
>>>> On 10/25/2013 10:57 AM, Tero Kristo wrote:
>
> [...]
>>>>> diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
>>>>> new file mode 100644
>>>>> index 0000000..787bc8f
>>>>> --- /dev/null
>>>>> +++ b/drivers/clk/ti/divider.c
>
> [...]
>>>>> +    if (!IS_ERR(clk)) {
>>>>> +        of_clk_add_provider(node, of_clk_src_simple_get, clk);
>>>>> +        ret = of_ti_autoidle_setup(node, regmap);
>>>>
>>>> if this fails, table will be freed though, we have added provider and
>>>> registerd table_regmap, no?
>>>
>>> Provider and regmap are shared for the whole IP block (CM/PRM whatever.)
>>> Those are only initialized once.
>>
>> Some minor confusion here in my comment, sorry about that.
>>
>> Regmap is shared for the whole IP block and initialized only once, we
>> can't remove it here as it is not owned by this clock. For
>> clock-provider / unregister part, I don't want to clean those up as 1)
>> unregister doesn't currently do anything 2) autoidle setup is not
>> critical failure, it just breaks PM. I can add error print for it though.
>
> Would IP blocks driven by clocks work with the autoidle configuration
> broken? I believe we will be writing to DPLL_XYZ_GATE_CTRL? the usage
> I believe is around
> of_ti_clk_deny_autoidle_all/of_ti_clk_allow_autoidle_all which gets
> invoked in omap2_clk_disable_autoidle_all part of xyz SoC init call.
> is'nt the reason we do that to ensure we have no potential race when
> clocks dissapear on their own without explicit control in critical
> configuration paths?

They will work, but they just don't transition to low-power mode ever.

-Tero

