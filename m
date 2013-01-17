From: Vivek Gautam <gautamvivek1987@gmail.com>
Subject: Re: [RFC PATCH 2/6] ARM: OMAP: USB: Add phy binding information
Date: Thu, 17 Jan 2013 17:41:53 +0530
Message-ID: <CAFp+6iGEC9KgfuQz6nqnAY5JrmtPG=HkGw5yjKw7-1=8AG_=dg@mail.gmail.com>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
	<1358348462-27693-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1358348462-27693-3-git-send-email-kishon@ti.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, balbi@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, horms@verge.net.au, magnus.damm@gmail.com, cbou@mail.ru, dwmw2@infradead.org, alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, leoli@freescale.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, stern@rowland.harvard.edu
List-Id: linux-omap@vger.kernel.org

Hi Kishon,


On Wed, Jan 16, 2013 at 8:30 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> This is in preparation for the changes in PHY library to support adding
> and getting multiple PHYs of the same type. In the new design, the
> binding information between the PHY and the USB controller should be
> specified in the platform specific initialization code. So it's been
> done for OMAP platforms here.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> This kind-of binding should be done in all the platforms (I've done only
> for OMAP platform).
>  arch/arm/mach-omap2/usb-musb.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index 9d27e3f..bbe2fa5 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -24,6 +24,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
>  #include <linux/usb/musb.h>
> +#include <linux/usb/phy.h>
>
>  #include "omap_device.h"
>  #include "soc.h"
> @@ -85,8 +86,12 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
>         musb_plat.mode = board_data->mode;
>         musb_plat.extvbus = board_data->extvbus;
>
> -       if (cpu_is_omap44xx())
> +       if (cpu_is_omap44xx()) {
>                 musb_plat.has_mailbox = true;
> +               usb_bind_phy("musb-hdrc.0.auto", 0, "omap-usb2.1.auto");
> +       } else if (cpu_is_omap34xx()) {
> +               usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
> +       }

Just trying to understand things here.
Is the device name we are using here the platform device name (pdev->name) ?
If i am not wrong then for devices added through device tree
the device name would actually include the device address in the string,
wouldn't that make things somewhat weird, since we will have to add
such bindings
using this address string.

one more doubt please :)
is it possible to bind phy in the controllers' driver somehow ?

>
>         if (soc_is_am35xx()) {
>                 oh_name = "am35x_otg_hs";
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks & Regards
Vivek
