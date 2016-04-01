From: Vivek Gautam <gautamvivek1987@gmail.com>
Subject: Re: [PATCH 1/2] phy: Group vendor specific phy drivers
Date: Fri, 1 Apr 2016 05:52:30 -0700
Message-ID: <CAFp+6iGwXJHAEgm3n1S4Dfp45egCPMdoMrOqsR6W9c865-7rwA@mail.gmail.com>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
	<20160401113919.GC2987@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160401113919.GC2987@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vivek Gautam <gautam.vivek@samsung.com>, vireshk@kernel.org, shiraz.linux.kernel@gmail.com, kishon <kishon@ti.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, wens@csie.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, spear-devel@list.st.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rockchip@lists.infradead.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, CPGS <cpgs@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 1, 2016 at 4:39 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 01-04-16, 16:59, Vivek Gautam wrote:
>> Adding vendor specific directories in phy to group
>> phy drivers under their respective vendor umbrella.
>>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>> ---
>>  drivers/phy/{ => st}/phy-spear1310-miphy.c        |   0
>>  drivers/phy/{ => st}/phy-spear1340-miphy.c        |   0
>>  rename drivers/phy/{ => st}/phy-spear1310-miphy.c (100%)
>>  rename drivers/phy/{ => st}/phy-spear1340-miphy.c (100%)
>>
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Thanks Viresh.

>
> --
> viresh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
