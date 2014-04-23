From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 3/3] usb: dwc3-exynos: Make provision for vdd regulators
Date: Wed, 23 Apr 2014 21:31:47 +0900
Message-ID: <000901cf5eef$fe79e5f0$fb6db1d0$%han@samsung.com>
References: <1398082604-3013-1-git-send-email-gautam.vivek@samsung.com>
 <1398082604-3013-3-git-send-email-gautam.vivek@samsung.com>
 <00bf01cf5ed6$28de18d0$7a9a4a70$%tikhomirov@samsung.com>
 <CAFp+6iE2eWJPMmxSF9gbfwMmeO7k0bo=geo5SKmdgBRjiFq7mA@mail.gmail.com>
 <00d201cf5ee2$d55c4e90$8014ebb0$%tikhomirov@samsung.com>
 <CAFp+6iGBz-0LjkUU8A4var5frEqaumF85scZfHPEVwk62mTe8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAFp+6iGBz-0LjkUU8A4var5frEqaumF85scZfHPEVwk62mTe8g@mail.gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Vivek Gautam' <gautam.vivek@samsung.com>
Cc: 'Anton Tikhomirov' <av.tikhomirov@samsung.com>, 'Linux USB Mailing List' <linux-usb@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 'Greg KH' <gregkh@linuxfoundation.org>, 'Alan Stern' <stern@rowland.harvard.edu>, 'Felipe Balbi' <balbi@ti.com>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday, April 23, 2014 8:06 PM, Vivek Gautam wrote:
> On Wednesday, April 23, 2014 7:58 PM, Anton Tikhomirov wrote:
> > On Wednesday, April 23, 2014 6:52 PM, Vivek Gautam wrote:
> >> On Wednesday, April 23, 2014 6:27 PM, Anton Tikhomirov wrote:
> >> > On Monday, April 21, 2014 9:17 PM, Vivek Gautam wrote:
> >> >>
> >> >> Facilitate getting required 3.3V and 1.0V VDD supply for
> >> >> DWC3 controller on Exynos.
> >> >>
> >> >> With patches for regulators' nodes merged in 3.15:
> >> >> c8c253f ARM: dts: Add regulator entries to smdk5420
> >> >> 275dcd2 ARM: dts: add max77686 pmic node for smdk5250,
> >> >>
> >> >> certain perripherals will now need to ensure that,
> >> >> they request VDD regulators in their drivers, and enable
> >> >> them so as to make them working.
> >> >>
> >> >> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> >> >> Cc: Anton Tikhomirov <av.tikhomirov@samsung.com>
> >> >> ---
> >> >>
> >> >> Based on 'usb-next' branch of Greg's USB tree.
> >> >> Also cleanly applies on 'next' branch of Balbi's USB tree.
> >> >>
> >> >>  drivers/usb/dwc3/dwc3-exynos.c |   51
> >> >> ++++++++++++++++++++++++++++++++++++++--
> >> >>  1 file changed, 49 insertions(+), 2 deletions(-)
> >> >>
> >> >> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-
> >> >> exynos.c
> >> >> index 28c8ad7..c9d9102 100644
> >> >> --- a/drivers/usb/dwc3/dwc3-exynos.c
> >> >> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> >> >> @@ -27,6 +27,7 @@
> >> >>  #include <linux/usb/usb_phy_gen_xceiv.h>
> >> >>  #include <linux/of.h>
> >> >>  #include <linux/of_platform.h>
> >> >> +#include <linux/regulator/consumer.h>
> >> >>
> >> >>  struct dwc3_exynos {
> >> >>       struct platform_device  *usb2_phy;
> >> >> @@ -34,6 +35,8 @@ struct dwc3_exynos {
> >> >>       struct device           *dev;
> >> >>
> >> >>       struct clk              *clk;
> >> >> +     struct regulator        *vdd33;
> >> >> +     struct regulator        *vdd10;
> >> >>  };
> >> >>
> >> >>  static int dwc3_exynos_register_phys(struct dwc3_exynos *exynos)
> >> >> @@ -144,20 +147,46 @@ static int dwc3_exynos_probe(struct
> >> >> platform_device *pdev)
> >> >>
> >> >>       clk_prepare_enable(exynos->clk);
> >> >>
> >> >> +     exynos->vdd33 = devm_regulator_get(dev, "vdd33");
> >> >> +     if (IS_ERR(exynos->vdd33)) {
> >> >> +             ret = PTR_ERR(exynos->vdd33);
> >> >> +             goto err2;
> >> >
> >> > Is regulator property mandatory for dwc3-exynos? If it is not
> >> > and device tree doesn't provide it, dwc3-exynos driver probe
> >> shouldn't
> >> > fail here.
> >>
> >> These are the VDD regulators (from PMIC ldo supplies), in absence of
> >> which the controller will not be powered up.
> >> So doesn't it make sense to stop the probe when these are not supplied
> >> by device tree ?
> >
> > Agree. Just curious, is there special reason for this change except making
> > things right?
> 
> Yea, actually after the patch (which got merged in 3.15 rc1)
> 275dcd2 ARM: dts: add max77686 pmic node for smdk5250,
> 
> the USB stops working, and that's because the regulators related to
> usb are not turned on by default (ldo12 and ldo15 to be specific).
> So we need to enable those regulators, which ofcourse the driver
> should be doing, if i am not wrong.
> Similar is the reason for EHCI, and OHCI exynos patches in this series.

Oh, I see. Thank you for your explanation.

> 
> I shall be sending the dt patch for this soon.

OK, I will wait for your patch.

Best regards,
Jingoo Han

> 
> 
> --
> Best Regards
> Vivek Gautam
> Samsung R&D Institute, Bangalore
> India
