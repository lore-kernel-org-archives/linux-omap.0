From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
Date: Wed, 8 Jun 2016 17:05:58 +0800
Message-ID: <20160608090558.GB27133@shlinux2>
References: <573C719F.5010107@ti.com>
 <AM4PR04MB2130926F9AE8EBFC0D19447689490@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573D6C1C.4090600@ti.com>
 <20160521022940.GA15088@shlinux2>
 <20160523032149.GA20438@shlinux2>
 <5742D764.2010507@ti.com>
 <AM4PR04MB21305E8225B0DB669E13E0A2894E0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <5742DD43.6060703@ti.com>
 <20160524025356.GA6675@shlinux2>
 <5757CA03.5020409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5757CA03.5020409@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Jun Li <jun.li@nxp.com>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "balbi@kernel.org" <balbi@kernel.org>, "tony@atomide.com" <tony@atomide.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "robh@kernel.org" <robh@kernel.org>, "nsekhar@ti.com" <nsekhar@ti.com>, "b-liu@ti.com" <b-liu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.ke
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 08, 2016 at 10:32:19AM +0300, Roger Quadros wrote:
> Hi,
> 
> On 24/05/16 05:53, Peter Chen wrote:
> > On Mon, May 23, 2016 at 01:36:51PM +0300, Roger Quadros wrote:
> >> On 23/05/16 13:34, Jun Li wrote:
> >>> Hi
> >>>
> >>>> -----Original Message-----
> >>>> From: Roger Quadros [mailto:rogerq@ti.com]
> >>>> Sent: Monday, May 23, 2016 6:12 PM
> >>>> To: Peter Chen <hzpeterchen@gmail.com>
> >>>> Cc: Jun Li <jun.li@nxp.com>; peter.chen@freescale.com; balbi@kernel.org;
> >>>> tony@atomide.com; gregkh@linuxfoundation.org; dan.j.williams@intel.com;
> >>>> mathias.nyman@linux.intel.com; Joao.Pinto@synopsys.com;
> >>>> sergei.shtylyov@cogentembedded.com; jun.li@freescale.com;
> >>>> grygorii.strashko@ti.com; yoshihiro.shimoda.uh@renesas.com;
> >>>> robh@kernel.org; nsekhar@ti.com; b-liu@ti.com; linux-usb@vger.kernel.org;
> >>>> linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>>> devicetree@vger.kernel.org
> >>>> Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
> >>>>
> >>>> On 23/05/16 06:21, Peter Chen wrote:
> >>>>> On Sat, May 21, 2016 at 10:29:40AM +0800, Peter Chen wrote:
> >>>>>> On Thu, May 19, 2016 at 10:32:44AM +0300, Roger Quadros wrote:
> >>>>>>> On 18/05/16 17:46, Jun Li wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> I didn't want to have complex Kconfig so decided to have otg as
> >>>>>>>>>>> built-in only.
> >>>>>>>>>>> What do you want me to change in existing code? and why?
> >>>>>>>>>>
> >>>>>>>>>> Remove those stuff which only for pass diff driver config Like
> >>>>>>>>>> every controller driver need a duplicated
> >>>>>>>>>>
> >>>>>>>>>> static struct otg_hcd_ops ci_hcd_ops = {
> >>>>>>>>>>     ...
> >>>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>> This is an exception only. Every controller driver doesn't need to
> >>>>>>>>> implement hcd_ops. It is implemented in the hcd core.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> And here is another example, for gadget connect, otg driver can
> >>>>>>>>>> directly call to usb_udc_vbus_handler() in drd state machine, but
> >>>>>>>>>> you create another interface:
> >>>>>>>>>>
> >>>>>>>>>> .connect_control = usb_gadget_connect_control,
> >>>>>>>>>>
> >>>>>>>>>> If the symbol is defined in one driver which is 'm', another
> >>>>>>>>>> driver reference it should be 'm' as well, then there is no this
> >>>>>>>>>> kind of problem as my understanding.
> >>>>>>>>>
> >>>>>>>>> That is fine as long as all are 'm'. but how do you solve the case
> >>>>>>>>> when Gadget is built in and host is 'm'? OTG has to be built-in
> >>>>>>>>> and you will need an hcd to gadget interface.
> >>>>>>>>
> >>>>>>>> Hcd to gadget interface? Or you want to say otg to host interface?
> >>>>>>>
> >>>>>>> Sorry, I meant to say host to otg interface.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> I think hcd and gadget are independent each other, now
> >>>>>>>>
> >>>>>>>> Hcd --> otg; and gadget --> otg, (hcd and gadget use otg's symbol)
> >>>>>>>
> >>>>>>> It is actually a circular dependency for both.
> >>>>>>>  hcd <--> otg and gadget <--> otg
> >>>>>>>
> >>>>>>> hcd -> otg for usb_otg_register/unregister_hcd otg -> hcd for
> >>>>>>> usb_add/remove_hcd, usb_bus_start_enum, usb_control_msg,
> >>>>>>> usb_hub_find_child
> >>>>>>>
> >>>>>>> gadget -> otg for usb_otg_register/unregister_gadget
> >>>>>>> otg -> gadget for usb_gadget_start/stop, usb_udc_vbus_handler
> >>>>>>>
> >>>>>>> Now consider what will happen if I get rid of the otg_hcd and
> >>>> otg_gadget interfaces.
> >>>>>>> 'y' means built-in, 'm' means module.
> >>>>>>>
> >>>>>>> 1) hcd 'y', gadget 'y'
> >>>>>>> otg has to be 'y' for proper build.
> >>>>>>>
> >>>>>>> 2) hcd 'm', gadget 'm'
> >>>>>>> otg has to be 'm' for proper build.
> >>>>>>>
> >>>>>>> 3) hcd 'y', gadget 'm'
> >>>>>>> Build will fail always.
> >>>>>>> If otg is 'y', otg build will fail due to dependency on gadget.
> >>>>>>> If otg is 'm', hcd build will fail due to dependency on otg.
> >>>>>>>
> >>>>>>> 4) hcd 'm', gadget 'y'
> >>>>>>> Build will fail always.
> >>>>>>> If otg is 'y', otg build will fail due to dependency on hcd.
> >>>>>>> If otg is 'm', gadget build will fails due to dependency on otg.
> >>>>>>>
> >>>>>>> So I solve this problem by adding the otg_hcd_ops and otg_gadget_ops
> >>>>>>> to remove otg->hcd and otg->gadget dependency.
> >>>>>>>
> >>>>>>> Now we can address 3) and 4) like so
> >>>>>>>
> >>>>>>> 3) hcd 'y', gadget 'm'
> >>>>>>> otg has to be 'y' for proper build.
> >>>>>>>
> >>>>>>> 4) hcd 'm', gadget 'y'
> >>>>>>> otg has to be 'y' for proper build.
> >>>>>>>
> >>>>>>
> >>>>>> How about this:
> >>>>>> Moving usb_otg_register/unregister_hcd to host driver to remove
> >>>>>> dependency hcd->otg. And moving usb_otg_get_data to common.c.
> >>>>>>
> >>>>>> Delete the wait queue at usb-otg.c, and if calling usb_otg_get_data
> >>>>>> returns NULL, the host/device driver's probe return -EPROBE_DEFER.
> >>>>>> When the otg driver is probed successfully, the host/device will be
> >>>>>> re-probed again, and usb_otg_register_hcd will be called again.
> >>>>>>
> >>>>>> And let OTG depends on HCD && GADGET, and delete otg_hcd_ops and
> >>>>>> otg_gadget_ops. Below build dependency issues can be fixed.
> >>>>>> What do you think?
> >>>>>>
> >>>>>>> 1) hcd 'y', gadget 'y'
> >>>>>>> otg has to be 'y' for proper build.
> >>>>>>>
> >>>>>>> 2) hcd 'm', gadget 'm'
> >>>>>>> otg has to be 'm' for proper build.
> >>>>>>>
> >>>>>>> 3) hcd 'y', gadget 'm'
> >>>>>>> Build will fail always.
> >>>>>>> If otg is 'y', otg build will fail due to dependency on gadget.
> >>>>>>> If otg is 'm', hcd build will fail due to dependency on otg.
> >>>>>>>
> >>>>>>> 4) hcd 'm', gadget 'y'
> >>>>>>> Build will fail always.
> >>>>>>> If otg is 'y', otg build will fail due to dependency on hcd.
> >>>>>>> If otg is 'm', gadget build will fails due to dependency on otg.
> >>>>>> --
> >>>>>>
> >>>>>
> >>>>> After thinking more, my suggestion can't work. How about moving
> >>>>> CONFIG_USB_OTG out of CONFIG_USB, in that case, CONFIG_USB_OTG can
> >>>>> only be built in.
> >>>>>
> >>>> I tried this but it still doesn't resolve 3 and 4. I.e.
> >>>> it can't be automatically set to 'y' when either of hcd/gadget is 'y'
> >>>> and the other is 'm'.
> >>>
> >>> USB_OTG only can be selected by *user*, can't be automatically set to
> >>> 'y' like you said, no matter what's hcd/gadget config, USB_OTG can be
> >>> disabled in any cases.
> >>
> >> Yes. I am on the same page with that.
> >>>
> >>> I think Peter's intention is to make USB_OTG to be 'bool', either disabled;
> >>> or built-in(if enabled), something like your original idea?
> >>
> >> I'm fine with my original idea if you guys can confirm :).
> >>
> > 
> > Please do it.
> > 
> 
> OK. I managed to fix this and get usbotg to be as module when both USB and GADGET
> are modules with the following patch.
> 
> What we do is use USB_OTG_CORE as a hidden tristate symbol that is used to build usbotg.o
> only if USB_OTG is enabled.
> 
> USB_OTG is used to enable/disable OTG and it has to be bool since it is used at mutiple
> places in the code.
> 

I am ok with that, but better you can write down above at your commit
log, then the reader can know your design purpose.

Peter
> cheers,
> -roger
> 
> ---
> 
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 8689dcb..ed596ec 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -32,6 +32,23 @@ if USB_SUPPORT
>  config USB_COMMON
>  	tristate
>  
> +config USB_OTG_CORE
> +	tristate
> +
> +config USB_OTG
> +	bool "OTG/Dual-role support"
> +	depends on PM && USB && USB_GADGET
> +	default n
> +	---help---
> +	  The most notable feature of USB OTG is support for a
> +	  "Dual-Role" device, which can act as either a device
> +	  or a host. The initial role is decided by the type of
> +	  plug inserted and can be changed later when two dual
> +	  role devices talk to each other.
> +
> +	  Select this only if your board has Mini-AB/Micro-AB
> +	  connector.
> +
>  config USB_ARCH_HAS_HCD
>  	def_bool y
>  
> @@ -40,6 +57,7 @@ config USB
>  	tristate "Support for Host-side USB"
>  	depends on USB_ARCH_HAS_HCD
>  	select USB_COMMON
> +	select USB_OTG_CORE
>  	select NLS  # for UTF-8 strings
>  	---help---
>  	  Universal Serial Bus (USB) is a specification for a serial bus
> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
> index 16a5b55..03f7204 100644
> --- a/drivers/usb/Makefile
> +++ b/drivers/usb/Makefile
> @@ -59,6 +59,6 @@ obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
>  obj-$(CONFIG_USB_GADGET)	+= gadget/
>  
>  obj-$(CONFIG_USB_COMMON)	+= common/
> -obj-$(CONFIG_USB_OTG)		+= common/
> +obj-$(CONFIG_USB_OTG_CORE)	+= common/
>  
>  obj-$(CONFIG_USBIP_CORE)	+= usbip/
> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
> index 730d928..5122b3f 100644
> --- a/drivers/usb/common/Makefile
> +++ b/drivers/usb/common/Makefile
> @@ -7,5 +7,7 @@ usb-common-y			  += common.o
>  usb-common-$(CONFIG_USB_LED_TRIG) += led.o
>  
>  obj-$(CONFIG_USB_ULPI_BUS)	+= ulpi.o
> +ifeq ($(CONFIG_USB_OTG),y)
>  usbotg-y		:= usb-otg.o usb-otg-fsm.o
> -obj-$(CONFIG_USB_OTG)	+= usbotg.o
> +obj-$(CONFIG_USB_OTG_CORE)	+= usbotg.o
> +endif
> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
> index f5eb7f5..98fcfa2 100644
> --- a/drivers/usb/common/usb-otg.c
> +++ b/drivers/usb/common/usb-otg.c
> @@ -16,6 +16,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/usb/of.h>
> @@ -841,3 +842,5 @@ int usb_otg_gadget_ready(struct usb_gadget *gadget, bool ready)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(usb_otg_gadget_ready);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
> index de371e6..37f8c54 100644
> --- a/drivers/usb/core/Kconfig
> +++ b/drivers/usb/core/Kconfig
> @@ -41,20 +41,6 @@ config USB_DYNAMIC_MINORS
>  
>  	  If you are unsure about this, say N here.
>  
> -config USB_OTG
> -	bool "OTG/Dual-role support"
> -	depends on PM && USB_GADGET
> -	default n
> -	help
> -	  The most notable feature of USB OTG is support for a
> -	  "Dual-Role" device, which can act as either a device
> -	  or a host. The initial role is decided by the type of
> -	  plug inserted and can be changed later when two dual
> -	  role devices talk to each other.
> -
> -	  Select this only if your board has Mini-AB/Micro-AB
> -	  connector.
> -
>  config USB_OTG_WHITELIST
>  	bool "Rely on OTG and EH Targeted Peripherals List"
>  	depends on USB
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 2057add..9d55384 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -16,6 +16,7 @@
>  menuconfig USB_GADGET
>  	tristate "USB Gadget Support"
>  	select USB_COMMON
> +	select USB_OTG_CORE
>  	select NLS
>  	help
>  	   USB is a master/slave protocol, organized with one master
> -- 
> 2.7.4
> 
> 
> 

-- 

Best Regards,
Peter Chen
