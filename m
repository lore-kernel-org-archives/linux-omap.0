From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all omap_clk_get_by_name
 usage
Date: Thu, 30 Aug 2012 14:09:00 +0530
Message-ID: <503F26A4.3050902@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com> <1346230576-20004-3-git-send-email-rnayak@ti.com> <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57358 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752763Ab2H3IjG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 04:39:06 -0400
Received: by obbuo13 with SMTP id uo13so2755273obb.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Aug 2012 01:39:05 -0700 (PDT)
In-Reply-To: <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: paul@pwsan.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 30 August 2012 05:45 AM, Turquette, Mike wrote:
> On Wed, Aug 29, 2012 at 1:56 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
>> index d7f55e4..a3831a2 100644
>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>> @@ -3156,6 +3156,7 @@ static struct omap_clk omap44xx_clks[] = {
>>          CLK(NULL,       "dss_tv_clk",&dss_tv_clk,    CK_443X),
>>          CLK(NULL,       "dss_48mhz_clk",&dss_48mhz_clk, CK_443X),
>>          CLK(NULL,       "dss_dss_clk",&dss_dss_clk,   CK_443X),
>> +       CLK(NULL,       "dss_fck",&dss_fck,       CK_443X),
>>          CLK("omapdss_dss",      "ick",&dss_fck,       CK_443X),
>
> Is it right to re-use dss_fck for the "ick" here?  I think it is due
> to omap4 modulemode stuff but I don't have DM in front of me and
> wanted a double-check...

yes, its because of the wierdness of DSS clocks where a so-called
optional clock is actually a function clock.

>
> Regards,
> Mike

