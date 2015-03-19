From: Peter Chen <peter.chen@freescale.com>
Subject: Re: [RFC][PATCH 8/9] usb: otg-fsm: Remove unused members in struct
 otg_fsm
Date: Thu, 19 Mar 2015 11:46:21 +0800
Message-ID: <20150319034620.GB7779@shlinux2>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com>
 <1426686963-11613-9-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426686963-11613-9-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 18, 2015 at 03:56:02PM +0200, Roger Quadros wrote:
> These members are not used anywhere so remove them.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  include/linux/usb/otg-fsm.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
> index b6ba1bf..176c4fc 100644
> --- a/include/linux/usb/otg-fsm.h
> +++ b/include/linux/usb/otg-fsm.h
> @@ -95,11 +95,6 @@ struct otg_fsm {
>  	int b_hnp_enable;
>  	int a_clr_err;
>  
> -	/* Informative variables */
> -	int a_bus_drop_inf;
> -	int a_bus_req_inf;
> -	int a_clr_err_inf;
> -	int b_bus_req_inf;
>  	/* Auxilary informative variables */
>  	int a_suspend_req_inf;
>  

But the above are defined at: ch 7.4.4, On-The-Go and Embedded Host
Supplement to the USB Revision 2.0 Specification

> -- 
> 2.1.0
> 

-- 

Best Regards,
Peter Chen
