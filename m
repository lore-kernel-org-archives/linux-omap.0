From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Removes FIXME message in usb.c
Date: Tue, 8 Jul 2014 22:30:42 -0700
Message-ID: <20140709053042.GB8051@kroah.com>
References: <1404871119-4324-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404871119-4324-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: balbi@ti.com, tony@atomide.com, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 08, 2014 at 09:58:39PM -0400, Nicholas Krause wrote:
> This patch removes a fixme message in this file:wq for setting the usb 2

I don't think you did this correctly :)

> speed on the board to the correct level. We need to depend on the
> bootloader for doing this as the wires may be shared for the other
> things on the board with the usb chipset.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/arm/mach-omap1/usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
> index 4118db5..172245a 100644
> --- a/arch/arm/mach-omap1/usb.c
> +++ b/arch/arm/mach-omap1/usb.c
> @@ -505,7 +505,7 @@ static u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
>  		omap_cfg_reg(W5_USB2_SE0);
>  		if (nwires != 3)
>  			omap_cfg_reg(Y5_USB2_RCV);
> -		// FIXME omap_cfg_reg(USB2_SPEED);
> +		/* Depend on boatloader for USB speed to be stated for board */

Really?  Is that correct?  WHy?
