From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv9 08/43] clk: ti: add composite clock support
Date: Fri, 1 Nov 2013 14:24:08 -0500
Message-ID: <5273FFD8.1030003@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-9-git-send-email-t-kristo@ti.com> <527284DC.2070701@ti.com> <527375FB.2000905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58839 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab3KATYf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Nov 2013 15:24:35 -0400
In-Reply-To: <527375FB.2000905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11/01/2013 04:35 AM, Tero Kristo wrote:
> On 10/31/2013 06:27 PM, Nishanth Menon wrote:
>> On 10/25/2013 10:57 AM, Tero Kristo wrote:

[..]
>>> diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
>>> new file mode 100644
>>> index 0000000..9ce7e54
>>> --- /dev/null
>>> +++ b/drivers/clk/ti/composite.c
[...]
>>
>>> +	}
>>> +
>>> +	clk = clk_register_composite(NULL, name, parent_names, num_parents,
>>> +				     _get_hw(clks[CLK_COMPONENT_TYPE_MUX]),
>>> +				     &clk_mux_ops,
>>> +				     _get_hw(clks[CLK_COMPONENT_TYPE_DIVIDER]),
>>> +				     &ti_composite_divider_ops,
>>> +				     _get_hw(clks[CLK_COMPONENT_TYPE_GATE]),
>>> +				     &ti_composite_gate_ops, 0);
>>> +
>>> +	if (!IS_ERR(clk)) {
>>> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>>> +		goto cleanup;
>>> +	}
>>> +
>>> +	ret = PTR_ERR(clk);
>>> +cleanup:
>>> +	/* Free component clock list entries */
>>> +	for (i = 0; i < 3; i++) {
>>> +		if (!clks[i])
>>> +			continue;
>>> +		list_del(&clks[i]->link);
>>> +		kfree(clks[i]);
>>> +	}
>>
>> could you not just do a kfree(clks[i]) and set the component_clks to NULL?
>>
>> Further, if there are only 3 clocks that can ever be present and we do
>> not allow for duplicates types, could we not do those checks in
>> ti_clk_add_component instead of having a harder recovery in setup of
>> composite clk?
> 
> The list is shared between all composite clocks, as we don't have 
> knowledge into which clock each component will go to at the time of the 
> component registration. Consider this setup (comp = component):
> 
> comp-a1
> comp-a2
> composite-a : comp-a1 + comp-a2
> comp-b1
> comp-b2
> comp-b3
> composite-b : comp-b1 + comp-b2 + comp-b3
> 
> Depending on clock init order, we will potentially have 5 components in 
> the list at max, which of 2 + 2 are of same type.

makes sense. Thanks for clarifying.


-- 
Regards,
Nishanth Menon
