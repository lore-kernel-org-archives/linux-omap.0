From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP5: clockdomain data: add init file for omap54xx
Date: Thu, 27 Jun 2013 12:24:25 +0300
Message-ID: <51CC04C9.3050801@ti.com>
References: <1372322299-25046-1-git-send-email-t-kristo@ti.com> <1372322299-25046-3-git-send-email-t-kristo@ti.com> <20130627084434.GT15455@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38232 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533Ab3F0JYz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jun 2013 05:24:55 -0400
In-Reply-To: <20130627084434.GT15455@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 06/27/2013 11:44 AM, Felipe Balbi wrote:
> Hi,
>
> On Thu, Jun 27, 2013 at 11:38:17AM +0300, Tero Kristo wrote:
>> +	rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
>> +	abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
>
> should these two lines be swaped ?

No, its a different clock. clk_set_parent is done for a clock that is a 
parent of dpll_abe_ck.

>
>> +	if (!rc)
>> +		rc = clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ);
>> +	if (rc)
>> +		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
>> +
>> +	return 0;
>
> so even if (rc) you still return 0 ? Shouldn't you return rc instead ?

Hmm yea, this could be improved. :) Same should be done for O4 / DRA7 
also. Seems like a long lasting feature actually.

-Tero
