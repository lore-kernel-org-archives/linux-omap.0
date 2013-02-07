From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 14/14] USB: ehci-omap: Fix autoloading of module
Date: Thu, 7 Feb 2013 11:11:53 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1302071111401.1534-100000@iolanthe.rowland.org>
References: <1360252974-7912-15-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360252974-7912-15-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, balbi@ti.com, gregkh@linuxfoundation.org, linux@arm.linux.org.uk, kishon@ti.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 7 Feb 2013, Roger Quadros wrote:

> The module alias should be "ehci-omap" and not
> "omap-ehci" to match the platform device name.
> The omap-ehci module should now autoload correctly.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  drivers/usb/host/ehci-omap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index a8ce10d..a2d16c0 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -340,9 +340,10 @@ static void __exit ehci_omap_cleanup(void)
>  }
>  module_exit(ehci_omap_cleanup);
>  
> -MODULE_ALIAS("platform:omap-ehci");
> +MODULE_ALIAS("platform:ehci-omap");
>  MODULE_AUTHOR("Texas Instruments, Inc.");
>  MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
> +MODULE_AUTHOR("Roger Quadros <rogerq@ti.com");
>  
>  MODULE_DESCRIPTION(DRIVER_DESC);
>  MODULE_LICENSE("GPL");
> 
