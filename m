From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all omap_clk_get_by_name
 usage
Date: Thu, 30 Aug 2012 13:57:11 +0200
Message-ID: <503F5517.4010100@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com> <1346230576-20004-3-git-send-email-rnayak@ti.com> <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com> <503F26A4.3050902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41583 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab2H3L5V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:57:21 -0400
In-Reply-To: <503F26A4.3050902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Turquette, Mike" <mturquette@ti.com>, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 08/30/2012 10:39 AM, Rajendra Nayak wrote:
> On Thursday 30 August 2012 05:45 AM, Turquette, Mike wrote:
>> On Wed, Aug 29, 2012 at 1:56 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
>>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c
>>> b/arch/arm/mach-omap2/clock44xx_data.c
>>> index d7f55e4..a3831a2 100644
>>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>>> @@ -3156,6 +3156,7 @@ static struct omap_clk omap44xx_clks[] = {
>>>          CLK(NULL,       "dss_tv_clk",&dss_tv_clk,    CK_443X),
>>>          CLK(NULL,       "dss_48mhz_clk",&dss_48mhz_clk, CK_443X),
>>>          CLK(NULL,       "dss_dss_clk",&dss_dss_clk,   CK_443X),
>>> +       CLK(NULL,       "dss_fck",&dss_fck,       CK_443X),
>>>          CLK("omapdss_dss",      "ick",&dss_fck,       CK_443X),
>>
>> Is it right to re-use dss_fck for the "ick" here?  I think it is due
>> to omap4 modulemode stuff but I don't have DM in front of me and
>> wanted a double-check...
> 
> yes, its because of the wierdness of DSS clocks where a so-called
> optional clock is actually a function clock.

Not only, it is a hack to allow the DSS to be enabled whenever a DSS
submodule has to be enabled. Since they are sharing the ick, it will
enable the modulemode when the DISPC will be enabled.

That hack should disappear as soon as the DSS will be able to handle the
PM dependency between DSS submodules and the DSS itself using pm_runtime
parent/child link.
And then we will have to remove this fake ick modulemode clock node and
let hwmod handle that properly.

Tomi already cleaned the DSS part, I guess it should be upstreamed soon,
if this is not already the case.

Regards,
Benoit

