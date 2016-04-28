From: Vivek Gautam <gautamvivek1987@gmail.com>
Subject: Re: [PATCH v2 2/2] phy: Group vendor specific phy drivers
Date: Thu, 28 Apr 2016 10:55:33 +0530
Message-ID: <CAFp+6iHphrtt5wQi5jdVXF_e=EOHgqCUXMmKRfh23u9-awT4nA@mail.gmail.com>
References: <1459951665-28708-1-git-send-email-gautam.vivek@samsung.com>
	<1459951665-28708-2-git-send-email-gautam.vivek@samsung.com>
	<CAFp+6iHGSuTGbyWv4dV3GCNr=7VDRnBpcodwnoeB1i0zocUg5g@mail.gmail.com>
	<5721988E.7000105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5721988E.7000105@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: vireshk@kernel.org, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rockchip@lists.infradead.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, CPGS <cpgs@samsung.com>, Vivek Gautam <gautam.vivek@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi Kishon,


On Thu, Apr 28, 2016 at 10:28 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Tuesday 26 April 2016 11:36 AM, Vivek Gautam wrote:
>> Hi Kishon,
>>
>>
>> On Wed, Apr 6, 2016 at 7:37 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
>>> Adding vendor specific directories in phy to group
>>> phy drivers under their respective vendor umbrella.
>>>
>>> Also updated the MAINTAINERS file to reflect the correct
>>> directory structure for phy drivers.
>>>
>>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>
>>> Changes from v1:
>>>  - Updated the MAINTAINERS file to reflect the same change
>>>    in directory structure.
>>>  - Removed PHY_PLAT config as pointed out by Kishon.
>>>    So we don't require the second patch in the v1 of this series:
>>>    [PATCH 2/2] arm: mach-spear: Enable PHY_PLAT to meet dependency
>>>  - Renamed sunxi --> allwinner; rcar --> renesas.
>>>  - Fixed error coming with qcom Makefile.
>>
>> Does this change looks okay now ?
>> I think you must be planning to take this in after 4.7 rc1 is out, isn't it ?
>
> I'm not sure. I'm thinking which should be the right way to group the phy
> drivers, by vendors or by type (usb, pcie, etc..). I'm more inclined to group
> it by type.

I guess there are atleast couple of phy drivers (PIPE and ST's MiPHY) that
have multiple roles - USB or PCIe or SATA.

So grouping such drivers in one of the phy-types will be tricky, WDUT

>
> Thanks
> Kishon



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
