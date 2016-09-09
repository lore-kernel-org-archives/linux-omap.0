From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [v2] musb: omap2430: do not assume balanced enable()/disable()
Date: Fri, 09 Sep 2016 22:27:56 +0300
Message-ID: <1946895.vi37Pmm05X@avalon>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

Hi Andreas,

Thank you for the patch.

On Wednesday 03 Aug 2016 17:38:51 Andreas Kemnade wrote:
> The code assumes that omap2430_musb_enable() and
> omap2430_musb_disable() are called in a balanced way.
> That fact is broken by the fact that musb_init_controller() calls
> musb_platform_disable() to switch from unknown state to off state
> on initialisation.
> 
> That means that phy_power_off() is called first so that
> phy->power_count gets -1 and the phy is not enabled on phy_power_on().
> So when usb gadget is started the phy is not powered on.
> Depending on the phy used that caused various problems.
> Besides of causing usb problems, that can also have side effects.
> 
> In the case of using the phy_twl4030, that prevents also charging
> the battery via usb (using twl4030_charger) and so makes further
> kernel debugging hard.
> The problem was seen with 4.7 on an openphoenux gta04. It has a DM3730
> SoC and a TPS65950 companion.  phy->power never became 1
> and so the usb did get powered on.
> 
> The patch prevents phy_power_off() from being called when
> it is already off.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

This fixes USB gadget operation on the Panda board.

Fixes: a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling for 2430 
glue layer")
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> changes in v2:
> improved commit message
> 
>  drivers/usb/musb/omap2430.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 0b4cec9..c1a2b7b 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -413,9 +413,10 @@ static void omap2430_musb_disable(struct musb *musb)
>  	struct device *dev = musb->controller;
>  	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
> 
> -	if (!WARN_ON(!musb->phy))
> -		phy_power_off(musb->phy);
> -
> +	if (glue->enabled) {
> +		if (!WARN_ON(!musb->phy))
> +			phy_power_off(musb->phy);
> +	}
>  	if (glue->status != MUSB_UNKNOWN)
>  		omap_control_usb_set_mode(glue->control_otghs,
>  			USB_MODE_DISCONNECT);

-- 
Regards,

Laurent Pinchart
