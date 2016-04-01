From: Vivek Gautam <gautamvivek1987@gmail.com>
Subject: Re: [PATCH 1/2] phy: Group vendor specific phy drivers
Date: Fri, 1 Apr 2016 05:51:53 -0700
Message-ID: <CAFp+6iEt+RwoBVft_ve9s5On1rnpKmfg1p+i2Herhqz61d3DPg@mail.gmail.com>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
	<20160401114219.GG4227@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20160401114219.GG4227@lukather>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Vivek Gautam <gautam.vivek@samsung.com>, vireshk@kernel.org, shiraz.linux.kernel@gmail.com, kishon <kishon@ti.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, wens@csie.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, spear-devel@list.st.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rockchip@lists.infradead.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, CPGS <cpgs@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi,


On Fri, Apr 1, 2016 at 4:42 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Apr 01, 2016 at 04:59:15PM +0530, Vivek Gautam wrote:
>>  create mode 100644 drivers/phy/sunxi/Kconfig
>>  create mode 100644 drivers/phy/sunxi/Makefile
>>  rename drivers/phy/{ => sunxi}/phy-sun4i-usb.c (100%)
>>  rename drivers/phy/{ => sunxi}/phy-sun9i-usb.c (100%)
>
> That would be allwinner in this case, sunxi is the SoC family
> Allwinner produces.

Sure, will change this.
I will change rcar --> renesas too. That should make the directory
names homogeneous (vendor-name).
Thanks for reviewing.

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
