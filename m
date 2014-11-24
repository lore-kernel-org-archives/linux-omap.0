From: Vivek Gautam <gautamvivek1987@gmail.com>
Subject: Re: [PATCH 01/11] pinctrl: exynos: Add BUS1 pin controller for exynos7
Date: Mon, 24 Nov 2014 10:30:19 +0530
Message-ID: <CAFp+6iF-N63YSsdv2a6=MYp_mD=eQY_Oi8=9JVNU5dG0BA7YGQ@mail.gmail.com>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
	<1416576954-11997-2-git-send-email-gautam.vivek@samsung.com>
	<CAGOxZ53d_Vk1cF8Y2LNgMNeuCFeQJKmHQeN19pO5HfAdp4hx8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGOxZ53d_Vk1cF8Y2LNgMNeuCFeQJKmHQeN19pO5HfAdp4hx8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: Vivek Gautam <gautam.vivek@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, kishon <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, robh+dt <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hi Alim,


On Sat, Nov 22, 2014 at 7:07 PM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
> Hi Vivek,
>
> On Fri, Nov 21, 2014 at 7:05 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
>> USB and Power regulator on Exynos7 require gpios available
>> in BUS1 pin controller block.
>> So adding the BUS1 pinctrl support.
>>
>> Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  drivers/pinctrl/samsung/pinctrl-exynos.c |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
>> index d5d4cfc..caca5b5 100644
>> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
>> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
>> @@ -1300,6 +1300,13 @@ static const struct samsung_pin_bank_data exynos7_pin_banks7[] __initconst = {
>>         EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpr3", 0x0c),
>>  };
>>
>> +/* pin banks of exynos7 pin-controller - BUS1 */
>> +static const struct samsung_pin_bank_data exynos7_pin_banks8[] __initconst = {
>> +       EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpf0", 0x00),
>> +       EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpf4", 0x10),
>> +       EXYNOS_PIN_BANK_EINTG(6, 0x120, "gph1", 0x20),
>> +};
>> +
> Looks like you are just trying to touch pin banks only related to USB
> stuffs, but as this patch does not have any dependencies on other
> patches in this series, will you consider adding other pin banks of
> BUS1, just for completeness of BUS1 pin-controller.

True, this just touches the USB related pinctrl.
Will add the rest pin banks of BUS1 for completeness.
Thanks for pointing out. :-)

[snip]



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
