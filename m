From: Vivek Gautam <gautamvivek1987@gmail.com>
Subject: Re: [PATCH 1/2] phy: Group vendor specific phy drivers
Date: Mon, 4 Apr 2016 21:52:04 -0700
Message-ID: <CAFp+6iF8AWF1f9tcRFWAkpvG=f7w2HXzXyR8dkP4Z3EbJQHNgg@mail.gmail.com>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
	<20160403060527.GA5034@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20160403060527.GA5034@kozik-lap>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Vivek Gautam <gautam.vivek@samsung.com>, vireshk@kernel.org, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, kishon <kishon@ti.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, spear-devel@list.st.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rockchip@lists.infradead.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, CPGS <cpgs@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi Krzysztof,


On Sat, Apr 2, 2016 at 11:05 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On Fri, Apr 01, 2016 at 04:59:15PM +0530, Vivek Gautam wrote:
>> Adding vendor specific directories in phy to group
>> phy drivers under their respective vendor umbrella.
>>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>> ---
>>
>> With growing number of phy drivers, it makes sense to
>> group these drivers under their respective vendor/platform
>> umbrella directory.
>>
>> Build-tested 'multi_v7_defconfig'.
>
> Please update also the MAINTAINERS file. For many entires the path won't
> match anymore.

Thanks for pointing out. I will update the MAINTAINERS file as well.

>
> Best regards,
> Krzysztof
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Vivek Gautam
Samsung, India
