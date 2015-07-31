From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 1/2] extcon: palmas: Support GPIO based USB ID detection
Date: Fri, 31 Jul 2015 16:46:27 +0900
Message-ID: <55BB27D3.8040209@samsung.com>
References: <1438002617-15152-1-git-send-email-rogerq@ti.com>
 <1438002617-15152-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438002617-15152-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: myungjoo.ham@samsung.com, tony@atomide.com, nm@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

When I apply it for build test, merge conflict happen.
So, I recommend that you rebase this patchset on extcon-next branch.

On 07/27/2015 10:10 PM, Roger Quadros wrote:
> Some palmas based chip variants do not have OTG based ID logic.
> For these variants we rely on GPIO based USB ID detection.
> 
> These chips do have VBUS comparator for VBUS detection so we
> continue to use the old way of detecting VBUS.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../devicetree/bindings/extcon/extcon-palmas.txt   |   5 +-
>  drivers/extcon/extcon-palmas.c                     | 114 ++++++++++++++++++---
>  include/linux/mfd/palmas.h                         |   6 ++
>  3 files changed, 109 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
> index 45414bb..f61d5af 100644
> --- a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
> +++ b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
> @@ -10,8 +10,11 @@ Required Properties:
>  
>  Optional Properties:
>   - ti,wakeup : To enable the wakeup comparator in probe
> - - ti,enable-id-detection: Perform ID detection.
> + - ti,enable-id-detection: Perform ID detection. If id-gpio is specified
> +		it performs id-detection using GPIO else using OTG core.
>   - ti,enable-vbus-detection: Perform VBUS detection.
> + - id-gpio: gpio for GPIO ID detection. See gpio binding.
> + - debounce-delay-ms: debounce delay for GPIO ID pin in milliseconds.
>  
>  palmas-usb {
>         compatible = "ti,twl6035-usb", "ti,palmas-usb";
> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
> index 080d5cc..d0ed764 100644
> --- a/drivers/extcon/extcon-palmas.c
> +++ b/drivers/extcon/extcon-palmas.c
> @@ -28,6 +28,9 @@
>  #include <linux/mfd/palmas.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/of_gpio.h>
> +
> +#define USB_GPIO_DEBOUNCE_MS	20	/* ms */
>  
>  static const unsigned int palmas_extcon_cable[] = {
>  	EXTCON_USB,
> @@ -120,19 +123,52 @@ static irqreturn_t palmas_id_irq_handler(int irq, void *_palmas_usb)
>  	return IRQ_HANDLED;
>  }
>  
> +static void palmas_gpio_id_detect(struct palmas_usb *palmas_usb)
> +{
> +	int id;
> +
> +	if (!palmas_usb->id_gpiod)
> +		return;
> +
> +	id = gpiod_get_value_cansleep(palmas_usb->id_gpiod);
> +
> +	if (id) {
> +		extcon_set_cable_state(palmas_usb->edev, "USB-HOST", false);

Use the extcon_set_cable_state_() because extcon_set_cable_state() with cable name
is deprecated.

> +		dev_info(palmas_usb->dev, "USB-HOST cable is detached\n");
> +	} else {
> +		extcon_set_cable_state(palmas_usb->edev, "USB-HOST", true);

ditto. Use the extcon_set_cable_state_() with extcon id.

[snip]

Thanks,
Chanwoo Choi
