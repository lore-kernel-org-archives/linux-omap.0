From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv3 10/10] CLK: TI: always enable DESHDCP clock
Date: Wed, 20 May 2015 12:34:23 -0700
Message-ID: <555CE1BF.4050506@codeaurora.org>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com> <1430906938-26128-11-git-send-email-tomi.valkeinen@ti.com> <555C744C.6070901@ti.com> <555C74E8.5010105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41612 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbbETTe0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2015 15:34:26 -0400
In-Reply-To: <555C74E8.5010105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Mike Turquette <mturquette@linaro.org>

On 05/20/15 04:50, Tero Kristo wrote:
>
>>>
>>> @@ -348,5 +348,10 @@ int __init dra7xx_dt_clk_init(void)
>>>       if (rc)
>>>           pr_err("%s: failed to set USB_DPLL M2 OUT\n", __func__);
>>>
>>> +    hdcp_ck = clk_get_sys(NULL, "dss_deshdcp_clk");
>>> +    rc = clk_prepare_enable(hdcp_ck);
>>> +    if (rc)
>>> +        pr_err("%s: failed to set dss_deshdcp_clk\n", __func__);
>>> +
>>>       return rc;
>>>   }
>>>
>>
>> You should rather use the assigned-clock properties in DT to accomplish
>> this, the manual clock tweaks under the drivers/clk/ti/clk-* files
>> should be converted to DT setup also.
>
> Now that I sent this, I realize we only have support to set_parent /
> set_rate through the assigned-clock props, no enable. Any plans to
> extend this support Mike/Stephen?
>
>

Enable falls under the "critical clocks" discussion that is ongoing. I
assume that this is some sort of critical clock that can't be turned off?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

