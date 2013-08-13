From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/2] extcon: palmas: Added a new compatible type
 *ti,palmas-usb-vid*
Date: Tue, 13 Aug 2013 18:54:31 +0900
Message-ID: <520A0257.1080903@samsung.com>
References: <1376302675-15795-1-git-send-email-kishon@ti.com>
 <1376372241-15573-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1376372241-15573-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: benoit.cousson@linaro.org, tony@atomide.com, swarren@wwwdotorg.org, myungjoo.ham@samsung.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob@landley.net, george.cherian@ti.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

On 08/13/2013 02:37 PM, Kishon Vijay Abraham I wrote:
> The Palmas device contains only a USB VID detector, so added a
> compatible type *ti,palmas-usb-vid*. Dint remove the existing compatible
> types for backward compatibility.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/extcon/extcon-twl.txt |    3 ++-
>  drivers/extcon/extcon-palmas.c                          |    1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-twl.txt b/Documentation/devicetree/bindings/extcon/extcon-twl.txt
> index 58f531a..5be4afc 100644
> --- a/Documentation/devicetree/bindings/extcon/extcon-twl.txt
> +++ b/Documentation/devicetree/bindings/extcon/extcon-twl.txt
> @@ -2,7 +2,8 @@ EXTCON FOR TWL CHIPS
>  
>  PALMAS USB COMPARATOR
>  Required Properties:
> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
> + - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb" or
> +   "ti,palmas-usb-vid".
>   - vbus-supply : phandle to the regulator device tree node.
>  
>  Optional Properties:
> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
> index b752a0a..4f83fae 100644
> --- a/drivers/extcon/extcon-palmas.c
> +++ b/drivers/extcon/extcon-palmas.c
> @@ -223,6 +223,7 @@ static int palmas_usb_remove(struct platform_device *pdev)
>  
>  static struct of_device_id of_palmas_match_tbl[] = {
>  	{ .compatible = "ti,palmas-usb", },
> +	{ .compatible = "ti,palmas-usb-vid", },
>  	{ .compatible = "ti,twl6035-usb", },
>  	{ /* end */ }
>  };
> 

This patch has a conflict. You have to always implement patch on extcon branch
including latest patch. You need to resend v2 patch based on extcon-next branch.

'extcon-twl.txt' is renamed as 'extcon-palmas.txt' on following patch:
http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/commit/?h=extcon-next&id=80d644b297dc26c5126858555044edef76f4ffe8

And, 'vbus-supply' phandle was removed on following patch:
http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/commit/?h=extcon-next&id=26ece4f0b7d2264282d9077d1843ff1e98189b6c

Thanks,
Chanwoo Choi
