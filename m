From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 1/3] arm: omap: hwmod: add a new addr space in otg for
 writing to control module
Date: Thu, 6 Sep 2012 21:04:58 +0530
Message-ID: <5048C2A2.2020104@ti.com>
References: <1346943331-18120-1-git-send-email-kishon@ti.com> <1346943331-18120-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1346943331-18120-2-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, balbi@ti.com, gregkh@linuxfoundation.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 9/6/2012 8:25 PM, Kishon Vijay Abraham I wrote:
> The mailbox register for usb otg in omap is present in control module.
> On detection of any events VBUS or ID, this register should be written
> to send the notification to musb core.
> 
> Till we have a separate control module driver to write to control module,
> omap2430 will handle the register writes to control module by itself. So
> a new address space to represent this control module register is added
> to usb_otg_hs.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 242aee4..02341bc 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -5890,6 +5890,11 @@ static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
>  		.pa_end		= 0x4a0ab003,
>  		.flags		= ADDR_TYPE_RT
>  	},
> +	{
> +		.pa_start	= 0x4a00233c,
> +		.pa_end		= 0x4a00233f,
> +		.flags		= ADDR_TYPE_RT
> +	},

I do not have any objection/comment here, but I believe this is control
module address space required for USB module, right?
I am not sure this is right way of accessing control module space.
Actually Control Module Access required for drivers is one of the
blocking issue we have currently.

Also there was some effort put up by 'Konstantine' to convert Control
module to MFD driver, I haven't seen any further update on it. But it
would be good to check with him.

Thanks,
Vaibhav
>  	{ }
>  };
>  
> 
