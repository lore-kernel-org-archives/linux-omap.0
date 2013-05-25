From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 1/3] drivers: regulator: palmas: add an API to set/clear
 the switch bit on SMPS10
Date: Sat, 25 May 2013 22:30:25 +0530
Message-ID: <51A0EE29.6060708@nvidia.com>
References: <1369405896-30246-1-git-send-email-kishon@ti.com> <1369405896-30246-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1369405896-30246-2-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "balbi@ti.com" <balbi@ti.com>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rob@landley.net" <rob@landley.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "george.cherian@ti.com" <george.cherian@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi Kishon/Graeme,

On Friday 24 May 2013 08:01 PM, Kishon Vijay Abraham I wrote:
> From: Graeme Gregory <gg@slimlogic.co.uk>
>
> Added an API to set/clear the switch bit on SMPS10 which can be used by
> palmas usb. The switch bit should be set in order for palmas to
> supply VBUS and is needed when OMAP is acting as USB HOST.
>
> Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/regulator/palmas-regulator.c | 26 ++++++++++++++++++++++++++
>   include/linux/mfd/palmas.h           |  2 ++
>   2 files changed, 28 insertions(+)
>
> diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
> index 92ceed0..d57ab55 100644
> --- a/drivers/regulator/palmas-regulator.c
> +++ b/drivers/regulator/palmas-regulator.c
> @@ -465,6 +465,32 @@ static int palmas_smps_set_ramp_delay(struct regulator_dev *rdev,
>   	return ret;
>   }
>   
> +/**
> + * palmas_set_switch_smps10() - set or clear the switch bit on SMPS10
> + * @param palmas pointer to the palmas mfd structure
> + * @param sw boolean to indicate switch status
> + *
> + * There is not a way to represent this function within the regulator
> + * framework. This sets/clears the switch of SMPS10 so SMPS10_OUT1 and
> + * SMPS10_OUT2 are shorted together.
> + */
>

As per datasheet, SMPS10 has 2 outputs, OUT1 and OUT2.
OUT2 is always available either through parasitic diode or bypass switch 
or boost mode. It can not be off at all.
OUT2 can be enable/disable through the switch bit.

The smps10 regulator is implemented  enable/disable on which it just 
enable/disable boost mode.
I think this is not proper control, actually we should control OUT1 
switch on regulator enable/disable of the smps10.

And hence in this case, we will not need this API.

Otherwise it will difficult to use this api outside of palmas.

In tegra platform, we have connected the USB-VBUS supply from 
SMPS10-OUT1 and usb driver control the vbus enabled/disable and so it 
can not call this API. This functionality need to be exposed through the 
regulator only.


