From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv10 00/41] ARM: TI SoC clock DT conversion
Date: Mon, 16 Dec 2013 10:12:16 +0200
Message-ID: <52AEB5E0.5070807@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <20131215043547.23538.63736@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41273 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab3LPIMp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 03:12:45 -0500
In-Reply-To: <20131215043547.23538.63736@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 12/15/2013 06:35 AM, Mike Turquette wrote:
> Quoting Tero Kristo (2013-11-26 00:05:41)
>> Hi,
>>
>
> Hi Tero,
>
> Thanks for your long suffering patience on this series. The clock
> patches look very good to me with exception of a few small comments. Let
> me know how I can help with the hierarchal DT stuff since I think that
> has been the gating factor for this series for the past few revisions.
>
>> Changes compared to v9:
>> - rebased on top of 3.13-rc1
>> - modified the low level clk register API to provide SoC specific clk_readl
>>    and clk_writel support which can be registered during boot, TI SoC variant
>>    uses regmap on low level
>
> Regarding regmap, will that be dropped for V11? I don't care whether it
> stays or goes but the approach you took is probably too top-level. Patch
> #1 sets clk_reg_ops system-wide which probably isn't right. Different
> clock drivers might compete to set those ops and the last one to write
> wins.

I will be dropping regmap for v11. However...

>
> A better approach is to support regmap ops on a per-clock basis (for
> clocks that use the generic implementations like clk-divider and
> clk-gate; obviously this is overkill for entirely hardware-specific
> clocks). Stephen Boyd's approach is a better solution[1][2] but
> unfortunately that approach dumps crap into struct clk_hw which is bad.
>
> Anyways if you decide against regmap for V11 then the whole issue is
> avoided.

Not avoided, some sort of solution is still needed to wrap the register 
reads/writes. Alternatives are basically top level clk_ops or some stuff 
like the patches you referred to, however it needs to be expanded to 
support also the basic clock types.

-Tero

>
> Regards,
> Mike
>
> [1] http://article.gmane.org/gmane.linux.ports.arm.kernel/273742
> [2] http://article.gmane.org/gmane.linux.ports.arm.kernel/273744
>
>> - dropped regmap parameter from clock init calls, instead a helper is used
>>    for getting regmap index along with the register offset from DT
>> - dropped regmap parameter from clock structs, instead platform specific
>>    clk_readl / clk_writel are used to parse reg parameter according to
>>    platform, for TI SoC:s, this is encoded as:
>>    struct clk_omap_reg {
>>      u16 offset; /* register offset */
>>      u16 index; /* regmap index */
>>    }
>> - Nishanth's comments to v9 mostly addressed, except for the CLK_OF_DECLARE
>>    tweak which I would actually want some feedback upon, basically the problem
>>    is I need to return status from the clk init functions so I can see if
>>    -EAGAIN is passed, in which case init will be retried later, maybe some of
>>    this can be made generic, like converting all the CLK_OF_DECLARE type
>>    functions to return status
>>
>> Testing done:
>> - omap3-beagle : boot + suspend/resume
>> - omap3-beagle-xm : boot (thanks to Nishanth)
>> - omap4-panda-es : boot + suspend/resume
>> - omap5-uevm : boot
>> - dra7-evm : boot
>> - am335x-bone : boot
>>
>> Separate branches available at https://github.com/t-kristo/linux-pm.git
>>
>> - full: 3.13-rc1-dt-clks-v10 (should be merged last, contains everything)
>> - clk driver only: 3.13-rc1-dt-clks-v10-for-mike
>> - DT data only: 3.13-rc1-dt-clks-v10-for-benoit
>>
>> -Tero
>>

