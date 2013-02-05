From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 02/13] USB: phy: nop: Defer probe if device needs VCC/RESET
Date: Tue, 5 Feb 2013 11:24:29 +0530
Message-ID: <51109E95.3000307@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1359993540-20780-3-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 04 February 2013 09:28 PM, Roger Quadros wrote:
> Add 2 flags, needs_vcc and needs_reset to platform data.
> If the flag is set and the regulator couldn't be found
> then we bail out with -EPROBE_DEFER.
>
> For device tree boot we depend on presensce of vcc-supply/
> reset-supply properties to decide if we should bail out
> with -EPROBE_DEFER or just continue in case the regulator
> can't be found.
>
> This is required for proper functionality in cases where the
> regulator is needed but is probed later than the PHY device.
>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/usb/otg/nop-usb-xceiv.c   |    8 ++++++++
>   include/linux/usb/nop-usb-xceiv.h |    4 ++++
>   2 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
> index adbb7ab..7860e7569 100644
> --- a/drivers/usb/otg/nop-usb-xceiv.c
> +++ b/drivers/usb/otg/nop-usb-xceiv.c
> @@ -147,6 +147,10 @@ static void nop_xeiv_get_dt_pdata(struct device *dev,
>
>   	if (!of_property_read_u32(node, "clock-frequency", &clk_rate))
>   		pdata->clk_rate = clk_rate;
> +	if (of_property_read_bool(node, "vcc-supply"))
> +		pdata->needs_vcc = true;
This can be written as..
pdata->needs_vcc = of_property_read_bool(node, "vcc-supply");

> +	if (of_property_read_bool(node, "reset-supply"))
> +		pdata->needs_reset = true;
same here..
>   }
>
>   static int nop_usb_xceiv_probe(struct platform_device *pdev)
> @@ -205,12 +209,16 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
>   	if (IS_ERR(nop->vcc)) {
>   		dev_dbg(&pdev->dev, "Error getting vcc regulator: %ld\n",
>   					PTR_ERR(nop->vcc));
> +		if (pdata->needs_vcc)
> +			return -EPROBE_DEFER;
>   	}
>
>   	nop->reset = devm_regulator_get(&pdev->dev, "reset");
>   	if (IS_ERR(nop->reset)) {
>   		dev_dbg(&pdev->dev, "Error getting reset regulator: %ld\n",
>   					PTR_ERR(nop->reset));
> +		if (pdata->needs_reset)
> +			return -EPROBE_DEFER;
>   	}
>
>   	nop->dev		= &pdev->dev;
> diff --git a/include/linux/usb/nop-usb-xceiv.h b/include/linux/usb/nop-usb-xceiv.h
> index 3265b61..148d351 100644
> --- a/include/linux/usb/nop-usb-xceiv.h
> +++ b/include/linux/usb/nop-usb-xceiv.h
> @@ -6,6 +6,10 @@
>   struct nop_usb_xceiv_platform_data {
>   	enum usb_phy_type type;
>   	unsigned long clk_rate;
> +
> +	/* if set fails with -EPROBE_DEFER if can't get regulator */
> +	unsigned int needs_vcc:1;
> +	unsigned int needs_reset:1;

how about u8 here?

Thanks
Kishon
