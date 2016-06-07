From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 64/67] phy-generic.c:undefined reference
 to `usb_gadget_vbus_connect'
Date: Tue, 7 Jun 2016 09:54:05 +0800
Message-ID: <20160607015405.GB17095@shlinux2>
References: <201606062026.EQTlXIDR%fengguang.wu@intel.com>
 <87bn3ecwbz.fsf@linux.intel.com>
 <878tyicva6.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <878tyicva6.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Chen <Peter.Chen-3arQi8VN3Tc@public.gmane.org>, John Youn <johnyoun-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 06, 2016 at 04:16:17PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
> > [ Unknown signature status ]
> >
> > Hi,
> >
> > kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next
> >> head:   89fe2b5ab11cdf6a67d4492d893e70e330aa7060
> >> commit: 231b31ca34485552fe27e67dc6d30d06079c7648 [64/67] usb: gadget: move gadget API functions to udc-core
> >> config: x86_64-randconfig-s1-06061834 (attached as .config)
> >> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> >> reproduce:
> >>         git checkout 231b31ca34485552fe27e67dc6d30d06079c7648
> >>         # save the attached .config to linux build tree
> >>         make ARCH=x86_64 
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>    drivers/built-in.o: In function `nop_set_peripheral':
> >>>> phy-generic.c:(.text+0x14423f): undefined reference to `usb_gadget_vbus_connect'
> >>    drivers/built-in.o: In function `nop_gpio_vbus_thread':
> >>>> phy-generic.c:(.text+0x144742): undefined reference to `usb_gadget_vbus_disconnect'
> >
> > oh yeah, I have to fix this. I'll do it now.
> 
> In order to fix this, I'll have to add something like below:
> 
> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
> index 3644a3500b70..bd67e4ac4b61 100644
> --- a/drivers/usb/chipidea/Kconfig
> +++ b/drivers/usb/chipidea/Kconfig
> @@ -19,6 +19,7 @@ config USB_CHIPIDEA_OF
>  config USB_CHIPIDEA_PCI
>  	tristate
>  	depends on PCI
> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
>  	depends on NOP_USB_XCEIV
>  	default USB_CHIPIDEA

Hi Felipe,

It causes any drivers which use symbols from gadget.h needs to build
USB_GADGET even it only wants to be host function. Any significant
benefits after moving it to udc-core.c?

Peter
>  
> diff --git a/drivers/usb/dwc2/Kconfig b/drivers/usb/dwc2/Kconfig
> index c1f29caa8990..26327aa2d2d8 100644
> --- a/drivers/usb/dwc2/Kconfig
> +++ b/drivers/usb/dwc2/Kconfig
> @@ -55,8 +55,9 @@ endchoice
>  config USB_DWC2_PCI
>  	tristate "DWC2 PCI"
>  	depends on PCI
> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
> +	depends on NOP_USB_XCEIV
>  	default n
> -	select NOP_USB_XCEIV
>  	help
>  	  The Designware USB2.0 PCI interface module for controllers
>  	  connected to a PCI bus.
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index d8f5674809e8..243c3d0cf1dc 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -180,7 +180,8 @@ config USB_EHCI_MXC
>  config USB_EHCI_HCD_OMAP
>  	tristate "EHCI support for OMAP3 and later chips"
>  	depends on ARCH_OMAP
> -	select NOP_USB_XCEIV
> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
> +	depends on NOP_USB_XCEIV
>  	default y
>  	---help---
>  	  Enables support for the on-chip EHCI controller on
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index 886526b5fcdd..c8588e5cec75 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -66,6 +66,7 @@ comment "Platform Glue Layer"
>  config USB_MUSB_SUNXI
>  	tristate "Allwinner (sunxi)"
>  	depends on ARCH_SUNXI
> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
>  	depends on NOP_USB_XCEIV
>  	depends on PHY_SUN4I_USB
>  	depends on EXTCON
> @@ -75,12 +76,14 @@ config USB_MUSB_SUNXI
>  config USB_MUSB_DAVINCI
>  	tristate "DaVinci"
>  	depends on ARCH_DAVINCI_DMx
> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
>  	depends on NOP_USB_XCEIV
>  	depends on BROKEN
>  
>  config USB_MUSB_DA8XX
>  	tristate "DA8xx/OMAP-L1x"
>  	depends on ARCH_DAVINCI_DA8XX
> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
>  	depends on NOP_USB_XCEIV
>  	depends on BROKEN
>  
> @@ -88,6 +91,7 @@ config USB_MUSB_TUSB6010
>  	tristate "TUSB6010"
>  	depends on HAS_IOMEM
>  	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
>  	depends on NOP_USB_XCEIV = USB_MUSB_HDRC # both built-in or both modules
>  
>  config USB_MUSB_OMAP2PLUS
> @@ -99,6 +103,7 @@ config USB_MUSB_OMAP2PLUS
>  config USB_MUSB_AM35X
>  	tristate "AM35x"
>  	depends on ARCH_OMAP
> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
>  	depends on NOP_USB_XCEIV
>  
>  config USB_MUSB_DSPS
> @@ -110,6 +115,7 @@ config USB_MUSB_DSPS
>  config USB_MUSB_BLACKFIN
>  	tristate "Blackfin"
>  	depends on (BF54x && !BF544) || (BF52x && ! BF522 && !BF523)
> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
>  	depends on NOP_USB_XCEIV
>  
>  config USB_MUSB_UX500
> @@ -118,6 +124,7 @@ config USB_MUSB_UX500
>  
>  config USB_MUSB_JZ4740
>  	tristate "JZ4740"
> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
>  	depends on NOP_USB_XCEIV
>  	depends on MACH_JZ4740 || COMPILE_TEST
>  	depends on USB_MUSB_GADGET
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index c6904742e2aa..53c0f2220ce3 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -43,7 +43,8 @@ config ISP1301_OMAP
>  config KEYSTONE_USB_PHY
>  	tristate "Keystone USB PHY Driver"
>  	depends on ARCH_KEYSTONE || COMPILE_TEST
> -	select NOP_USB_XCEIV
> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
> +	depends on NOP_USB_XCEIV
>  	help
>  	  Enable this to support Keystone USB phy. This driver provides
>  	  interface to interact with USB 2.0 and USB 3.0 PHY that is part
> @@ -63,9 +64,10 @@ config AM335X_CONTROL_USB
>  config AM335X_PHY_USB
>  	tristate "AM335x USB PHY Driver"
>  	depends on ARM || COMPILE_TEST
> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
> +	depends on NOP_USB_XCEIV
>  	select USB_PHY
>  	select AM335X_CONTROL_USB
> -	select NOP_USB_XCEIV
>  	select USB_COMMON
>  	help
>  	  This driver provides PHY support for that phy which part for the
> 
> 
> Anybody has any problems with this being amended to original patch? Note
> that NOP_USB_XCEIV should never have been selected with "select" to
> start with.
> 
> -- 
> balbi



-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
