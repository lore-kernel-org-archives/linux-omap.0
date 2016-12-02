From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH 05/12] usb: chipdata: Replace the extcon API
Date: Fri, 2 Dec 2016 14:59:58 +0800
Message-ID: <20161202065958.GB23234@b29397-desktop>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
 <1480485460-2663-6-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480485460-2663-6-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com, sre@kernel.org, Peter.Chen@nxp.com, wens@csie.org, yoshihiro.shimoda.uh@renesas.com, maxime.ripard@free-electrons.com, b-liu@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 30, 2016 at 02:57:33PM +0900, Chanwoo Choi wrote:
> This patch uses the resource-managed extcon API for extcon_register_notifier()
> and replaces the deprecated extcon API as following:
> - extcon_get_cable_state_() -> extcon_get_state()
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/usb/chipidea/core.c | 30 ++++++------------------------
>  1 file changed, 6 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 69426e644d17..a5b44963eaea 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -742,7 +742,7 @@ static int ci_get_platdata(struct device *dev,
>  	cable->edev = ext_vbus;
>  
>  	if (!IS_ERR(ext_vbus)) {
> -		ret = extcon_get_cable_state_(cable->edev, EXTCON_USB);
> +		ret = extcon_get_state(cable->edev, EXTCON_USB);
>  		if (ret)
>  			cable->state = true;
>  		else
> @@ -754,7 +754,7 @@ static int ci_get_platdata(struct device *dev,
>  	cable->edev = ext_id;
>  
>  	if (!IS_ERR(ext_id)) {
> -		ret = extcon_get_cable_state_(cable->edev, EXTCON_USB_HOST);
> +		ret = extcon_get_state(cable->edev, EXTCON_USB_HOST);
>  		if (ret)
>  			cable->state = false;
>  		else
> @@ -771,8 +771,8 @@ static int ci_extcon_register(struct ci_hdrc *ci)
>  	id = &ci->platdata->id_extcon;
>  	id->ci = ci;
>  	if (!IS_ERR(id->edev)) {
> -		ret = extcon_register_notifier(id->edev, EXTCON_USB_HOST,
> -					       &id->nb);
> +		ret = devm_extcon_register_notifier(ci->dev, id->edev,
> +						EXTCON_USB_HOST, &id->nb);
>  		if (ret < 0) {
>  			dev_err(ci->dev, "register ID failed\n");
>  			return ret;
> @@ -782,11 +782,9 @@ static int ci_extcon_register(struct ci_hdrc *ci)
>  	vbus = &ci->platdata->vbus_extcon;
>  	vbus->ci = ci;
>  	if (!IS_ERR(vbus->edev)) {
> -		ret = extcon_register_notifier(vbus->edev, EXTCON_USB,
> -					       &vbus->nb);
> +		ret = devm_extcon_register_notifier(ci->dev, vbus->edev,
> +						EXTCON_USB, &vbus->nb);
>  		if (ret < 0) {
> -			extcon_unregister_notifier(id->edev, EXTCON_USB_HOST,
> -						   &id->nb);
>  			dev_err(ci->dev, "register VBUS failed\n");
>  			return ret;
>  		}
> @@ -795,20 +793,6 @@ static int ci_extcon_register(struct ci_hdrc *ci)
>  	return 0;
>  }
>  
> -static void ci_extcon_unregister(struct ci_hdrc *ci)
> -{
> -	struct ci_hdrc_cable *cable;
> -
> -	cable = &ci->platdata->id_extcon;
> -	if (!IS_ERR(cable->edev))
> -		extcon_unregister_notifier(cable->edev, EXTCON_USB_HOST,
> -					   &cable->nb);
> -
> -	cable = &ci->platdata->vbus_extcon;
> -	if (!IS_ERR(cable->edev))
> -		extcon_unregister_notifier(cable->edev, EXTCON_USB, &cable->nb);
> -}
> -
>  static DEFINE_IDA(ci_ida);
>  
>  struct platform_device *ci_hdrc_add_device(struct device *dev,
> @@ -1053,7 +1037,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  	if (!ret)
>  		return 0;
>  
> -	ci_extcon_unregister(ci);
>  stop:
>  	ci_role_destroy(ci);
>  deinit_phy:
> @@ -1073,7 +1056,6 @@ static int ci_hdrc_remove(struct platform_device *pdev)
>  	}
>  
>  	dbg_remove_files(ci);
> -	ci_extcon_unregister(ci);
>  	ci_role_destroy(ci);
>  	ci_hdrc_enter_lpm(ci, true);
>  	ci_usb_phy_exit(ci);
> -- 

Acked-by: Peter Chen <peter.chen@nxp.com>

-- 

Best Regards,
Peter Chen
