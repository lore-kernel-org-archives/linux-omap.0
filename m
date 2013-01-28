From: Vivek Gautam <gautamvivek1987@gmail.com>
Subject: Re: [PATCH 4/4] usb: phy: samsung: Enable runtime power management on samsung-usb3
Date: Mon, 28 Jan 2013 18:54:42 +0530
Message-ID: <CAFp+6iHSvJdsT-Bdq2nPWo8L+LFigdrx9=2XEind9H8XC9BCFg@mail.gmail.com>
References: <1359373348-18320-1-git-send-email-gautam.vivek@samsung.com>
	<1359373348-18320-5-git-send-email-gautam.vivek@samsung.com>
	<20130128120909.GG28698@arwen.pp.htv.fi>
	<CAFp+6iHjzSKyya-t6dtsVQdOuhBTsCgWu+NFnDXFeRWwnBt-Jw@mail.gmail.com>
	<20130128130703.GO28698@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20130128130703.GO28698@arwen.pp.htv.fi>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: balbi@ti.com
Cc: Vivek Gautam <gautam.vivek@samsung.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, dianders@chromium.org, sylvester.nawrocki@gmail.com, tomasz.figa@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi Felipe,


On Mon, Jan 28, 2013 at 6:37 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Jan 28, 2013 at 06:34:15PM +0530, Vivek Gautam wrote:
>> >> @@ -65,7 +67,22 @@ static u32 samsung_usb3_phy_set_refclk(struct samsung_usbphy *sphy)
>> >>       return reg;
>> >>  }
>> >>
>> >> -static int samsung_exynos5_usb3_phy_enable(struct samsung_usbphy *sphy)
>> >> +/*
>> >> + * Sets the phy clk as ref_pad_clk (XusbXTI) which is clock from external PLL.
>> >> + */
>> >> +static u32 samsung_usb3_phy_set_refclk_ext(void)
>> >> +{
>> >> +     u32 reg;
>> >> +
>> >> +     reg = PHYCLKRST_REFCLKSEL_PAD_REFCLK |
>> >> +             PHYCLKRST_FSEL_PAD_100MHZ |
>> >> +             PHYCLKRST_MPLL_MULTIPLIER_100MHZ_REF;
>> >> +
>> >> +     return reg;
>> >> +}
>> >
>> > I wonder if you really need this small function (likewise for
>> > set_refclk_int()). They don't do much, so you could just inline them on
>> > the only caller.
>> >
>>
>> Created this just to keep symmetry, ;-)
>> will move this in the caller only.
>
> you can have a patch before this series moving the refclk_int() to the
> caller, then you will have symmetry ;-)
>

refclk_int() was rather slightly a big chunk :-(
as available in below patch as samsung_usb3_phy_set_refclk() :
[PATCH v4 2/2] usb: phy: samsung: Add PHY support for USB 3.0 controller
http://www.mail-archive.com/linux-usb@vger.kernel.org/msg13796.html

Will try to figure best possible way and amend.


-- 
Thanks & Regards
Vivek
