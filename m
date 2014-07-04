From: Daniele Forsi <dforsi@gmail.com>
Subject: Re: [PATCH 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
Date: Fri, 4 Jul 2014 14:27:15 +0200
Message-ID: <CAN_we7O2AMpace_oxBoxBO_jT82MnL9B-mzchozncMzp4_kZ=w@mail.gmail.com>
References: <1404472432-24764-1-git-send-email-peter.griffin@linaro.org>
	<1404472432-24764-2-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404472432-24764-2-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>, USB list <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, lee.jones@linaro.org, Giuseppe Cavallaro <peppe.cavallaro@st.com>
List-Id: linux-omap@vger.kernel.org

2014-07-04 13:13 GMT+02:00 Peter Griffin:

> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 8eb996e..f7b0518 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -77,6 +77,15 @@ config USB_DWC3_KEYSTONE
>         default USB_DWC3
>         help
>           Support of USB2/3 functionality in TI Keystone2 platforms.
> +
> +config USB_DWC3_ST
> +       tristate "STMicroelectronics Platforms"
> +       depends on ARCH_STI && OF
> +       default USB_DWC3_HOST
> +       help
> +         STMicroelectronics SoCs chip with one DesignWare Core USB3 IP
> +         inside (i.e. STiH407).
> +
>           Say 'Y' or 'M' here if you have one such device
>
>  comment "Debugging features"

you are actually removing the line "Say 'Y' or 'M' here if you have
one such device" from the previous item

-- 
Daniele Forsi
