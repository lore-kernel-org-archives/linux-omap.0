From: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v3 04/11] otg-fsm: move usb_bus_start_enum into
 otg-fsm->ops
Date: Fri, 17 Jul 2015 08:28:38 +0800
Message-ID: <20150717002837.GA3609@shlinux2>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
 <1436350777-28056-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436350777-28056-5-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 08, 2015 at 01:19:30PM +0300, Roger Quadros wrote:
> This is to prevent missing symbol build error if OTG is
> enabled (built-in) and HCD core (CONFIG_USB) is module.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/common/usb-otg-fsm.c | 6 ++++--
>  drivers/usb/phy/phy-fsl-usb.c    | 2 ++
>  include/linux/usb/otg-fsm.h      | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
> index 1873eb3..156fd25 100644
> --- a/drivers/usb/common/usb-otg-fsm.c
> +++ b/drivers/usb/common/usb-otg-fsm.c
> @@ -166,8 +166,10 @@ static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>  		otg_loc_conn(fsm, 0);
>  		otg_loc_sof(fsm, 1);
>  		otg_set_protocol(fsm, PROTO_HOST);
> -		usb_bus_start_enum(fsm->otg->host,
> -				fsm->otg->host->otg_port);
> +		if (fsm->ops->start_enum) {
> +			fsm->ops->start_enum(fsm->otg->host,
> +					     fsm->otg->host->otg_port);
> +		}
>  		break;
>  	case OTG_STATE_A_IDLE:
>  		otg_drv_vbus(fsm, 0);
> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
> index ee3f2c2..19541ed 100644
> --- a/drivers/usb/phy/phy-fsl-usb.c
> +++ b/drivers/usb/phy/phy-fsl-usb.c
> @@ -783,6 +783,8 @@ static struct otg_fsm_ops fsl_otg_ops = {
>  
>  	.start_host = fsl_otg_start_host,
>  	.start_gadget = fsl_otg_start_gadget,
> +
> +	.start_enum = usb_bus_start_enum,
>  };
>  
>  /* Initialize the global variable fsl_otg_dev and request IRQ for OTG */
> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
> index c631dde..22d8baa 100644
> --- a/include/linux/usb/otg-fsm.h
> +++ b/include/linux/usb/otg-fsm.h
> @@ -198,6 +198,7 @@ struct otg_fsm_ops {
>  	void	(*del_timer)(struct otg_fsm *fsm, enum otg_fsm_timer timer);
>  	int	(*start_host)(struct otg_fsm *fsm, int on);
>  	int	(*start_gadget)(struct otg_fsm *fsm, int on);
> +	int	(*start_enum)(struct usb_bus *bus, unsigned port_num);
>  };
>  
>  
> -- 
> 2.1.4
> 

Acked-by: Peter Chen <peter.chen@freescale.com>

-- 

Best Regards,
Peter Chen
