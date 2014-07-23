From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3
 HC
Date: Wed, 23 Jul 2014 16:50:16 +0100
Message-ID: <20140723155016.GM23210@lee--X1>
References: <1406126915-30601-1-git-send-email-peter.griffin@linaro.org>
 <1406126915-30601-2-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:41528 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757991AbaGWPuX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2014 11:50:23 -0400
Received: by mail-ie0-f178.google.com with SMTP id rd18so1118071iec.9
        for <linux-omap@vger.kernel.org>; Wed, 23 Jul 2014 08:50:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406126915-30601-2-git-send-email-peter.griffin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, devicetree@vger.kernel.org, balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, peppe.cavallaro@st.com

On Wed, 23 Jul 2014, Peter Griffin wrote:

> This patch adds the ST glue logic to manage the DWC3 HC
> on STiH407 SoC family. It manages the powerdown signal,
> and configures the internal glue logic and syscfg registers.
>=20
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/usb/dwc3/Kconfig   |   9 ++
>  drivers/usb/dwc3/Makefile  |   1 +
>  drivers/usb/dwc3/dwc3-st.c | 338 +++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 348 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-st.c

[...]

> +/*
> + * For all fields in USB2_VBUS_MNGMNT_SEL1
> + * 2=E2=80=99b00 : Override value from Reg 0x30 is selected
> + * 2=E2=80=99b01 : utmiotg_<signal_name> from usb3_top is selected
> + * 2=E2=80=99b10 : pipew_<signal_name> from PIPEW instance is select=
ed
> + * 2=E2=80=99b11 : value is 1'b0
> + */
> +#define REG30	0x0
> +#define UTMIOTG	0x1
> +#define PIPEW	0x2
> +#define ZERO	0x3

Possible register values are usually prefixed with something
descriptive which identifies them.

USB2_VBUS_ looks appropriate here.

[...]

> +/**
> + * struct st_dwc3 - st-dwc3 driver private structure
> + * @dwc3:		platform device pointer
> + * @dev:		device pointer
> + * @glue_base		ioaddr for the glue registers
> + * @regmap		regmap pointer for getting syscfg
> + * @syscfg_reg_off	usb syscfg control offset
> + * @dr_mode		drd static host/device config
> + * @rstc_pwrdn		rest controller for powerdown signal
> + * @rstc_rst		reset controller for softreset signal

Some of these have ':', some of them don't.  I suggest you standardise
to 'all do'.

> + *

Superflous line in comment.

> + */
> +

Superflous '\n'.

Take a look how you did the function headers below.

[...]

> +static int st_dwc3_drd_init(struct st_dwc3 *dwc3_data)
> +{
> +	u32 val;
> +	int err;
> +
> +	err =3D regmap_read(dwc3_data->regmap, dwc3_data->syscfg_reg_off, &=
val);
> +	if (err)
> +		return err;
> +
> +	switch (dwc3_data->dr_mode) {
> +	case USB_DR_MODE_PERIPHERAL:
> +		val |=3D USB_SET_PORT_DEVICE;
> +		dev_dbg(dwc3_data->dev, "Configuring as Device\n");
> +		break;
> +
> +	case USB_DR_MODE_HOST:
> +		val &=3D USB_HOST_DEFAULT_MASK;
> +		dev_dbg(dwc3_data->dev, "Configuring as Host\n");
> +		break;
> +
> +	default:
> +		dev_err(dwc3_data->dev, "Unsupported mode of operation %d\n"
> +			, dwc3_data->dr_mode);

',' should be on the line above.

> +		return -EINVAL;
> +	}
> +
> +	return regmap_write(dwc3_data->regmap, dwc3_data->syscfg_reg_off, v=
al);
> +}

All of this stuff is pretty minor.

Once fixed apply my Ack on the next revision:

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
