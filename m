From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v5 3/3] phy: Group vendor specific phy drivers
Date: Wed, 17 May 2017 09:13:33 +0530
Message-ID: <8c6d715f-6ccf-7894-9b2f-6897597c7f32@codeaurora.org>
References: <1494485262-18995-1-git-send-email-vivek.gautam@codeaurora.org>
 <1494485262-18995-3-git-send-email-vivek.gautam@codeaurora.org>
 <16fc3965-d250-6c3d-7a62-ab8da1f034fc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <16fc3965-d250-6c3d-7a62-ab8da1f034fc@ti.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Guenter Roeck <linux@roeck-us.net>, Heiko Stuebner <heiko@sntech.de>, Viresh Kumar <viresh.kumar@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Stephen Boyd <stephen.boyd@linaro.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.orglinu
List-Id: linux-omap@vger.kernel.org



On 05/16/2017 03:40 PM, Kishon Vijay Abraham I wrote:
> Hi Vivek,
>
> On Thursday 11 May 2017 12:17 PM, Vivek Gautam wrote:
>> Adding vendor specific directories in phy to group
>> phy drivers under their respective vendor umbrella.
>>
>> Also updated the MAINTAINERS file to reflect the correct
>> directory structure for phy drivers.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Cc: Chen-Yu Tsai <wens@csie.org>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Stephen Boyd <stephen.boyd@linaro.org>
>> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-omap@vger.kernel.org
>> Cc: linux-renesas-soc@vger.kernel.org
>> Cc: linux-rockchip@lists.infradead.org
>> Cc: linux-samsung-soc@vger.kernel.org
>> Cc: linux-usb@vger.kernel.org
>> ---
>>
>> Changes since v4:
>>   - Reprepared the patch based on latest torvalds/master.
>>   - Added new directory for amlogic, since there's a new patch [1]
>>     coming in for amlogic platforms.
>>
>> Changes since v3:
>>   - Added 'Acked-by' and 'Reviewed by' tags received for this patch.
>>   - No functional change.
>>
>> Changes since v2:
>>   - Rebased on linux-phy/next.
>>   - Took care of drivers added/removed for each vendors since v2.
>>   - Updated the 'Signed-off-by' tag with my current email id.
>>
>> Changes from v1:
>>   - Updated the MAINTAINERS file to reflect the same change
>>     in directory structure.
>>   - Removed PHY_PLAT config as pointed out by Kishon.
>>     So we don't require the second patch in the v1 of this series:
>>     [PATCH 2/2] arm: mach-spear: Enable PHY_PLAT to meet dependency
>>   - Renamed sunxi --> allwinner; rcar --> renesas.
>>   - Fixed error coming with qcom Makefile.
>>
>> * Build tested multi_v7_defconfig.
>> * Build tested arm64 defconfig with all the involved configs enabled.
>>
>> [1] https://patchwork.kernel.org/patch/9684303/
>>
> .
> .
> <snip>
> .
> .
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index afaf7b643eeb..b353ac603ea0 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -15,73 +15,6 @@ config GENERIC_PHY
>>   	  phy users can obtain reference to the PHY. All the users of this
> .
> .
> <snip>
> .
> .
>> -
>> +menu "Platform Phy drivers"
> I don't think creating a new menu is required. I removed it and merged into
> linux-phy.

Right. No need for a new menu. Thank you for fixing it and pushing out.

Best Regards
Vivek

>
> Thanks
> Kishon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
