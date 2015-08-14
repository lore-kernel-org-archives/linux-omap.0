From: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v3 07/11] usb: otg: add OTG core
Date: Fri, 14 Aug 2015 16:43:19 +0800
Message-ID: <20150814084318.GF11072@shlinux2>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
 <1436350777-28056-8-git-send-email-rogerq@ti.com>
 <20150713021456.GE27710@shlinux2>
 <55A390FB.5080406@ti.com>
 <55CDB80E.2030403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55CDB80E.2030403-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 14, 2015 at 12:42:38PM +0300, Roger Quadros wrote:
> Hi Peter,
> 
> On 13/07/15 13:20, Roger Quadros wrote:
> > On 13/07/15 05:14, Peter Chen wrote:
> >> On Wed, Jul 08, 2015 at 01:19:33PM +0300, Roger Quadros wrote:
> >>> The OTG core instantiates the OTG Finite State Machine
> >>> per OTG controller and manages starting/stopping the
> >>> host and gadget controllers based on the bus state.
> >>>
> >>> It provides APIs for the following tasks
> >>>
> >>> - Registering an OTG capable controller
> >>> - Registering Host and Gadget controllers to OTG core
> >>> - Providing inputs to and kicking the OTG state machine
> >>>
> >>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> >>> ---
> >>>  MAINTAINERS                  |   4 +-
> >>>  drivers/usb/Kconfig          |   2 +-
> >>>  drivers/usb/Makefile         |   1 +
> >>>  drivers/usb/common/Makefile  |   3 +-
> >>>  drivers/usb/common/usb-otg.c | 768 +++++++++++++++++++++++++++++++++++++++++++
> >>>  drivers/usb/common/usb-otg.h |  71 ++++
> >>>  drivers/usb/core/Kconfig     |  11 +-
> >>>  include/linux/usb/otg.h      |  91 ++++-
> >>>  8 files changed, 930 insertions(+), 21 deletions(-)
> >>>  create mode 100644 drivers/usb/common/usb-otg.c
> >>>  create mode 100644 drivers/usb/common/usb-otg.h
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 8133cef..b21278e 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -10640,12 +10640,14 @@ S:	Maintained
> >>>  F:	Documentation/usb/ohci.txt
> >>>  F:	drivers/usb/host/ohci*
> >>>  
> >>> -USB OTG FSM (Finite State Machine)
> >>> +USB OTG/DRD core and FSM (Finite State Machine)
> >>>  M:	Peter Chen <Peter.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >>> +M:	Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> >>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
> >>>  L:	linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>  S:	Maintained
> >>>  F:	drivers/usb/common/usb-otg-fsm.c
> >>> +F:	drivers/usb/common/usb-otg.c
> >>>  
> >>>  USB OVER IP DRIVER
> >>>  M:	Valentina Manea <valentina.manea.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> >>> index 8ed451d..5b625e2 100644
> >>> --- a/drivers/usb/Kconfig
> >>> +++ b/drivers/usb/Kconfig
> >>> @@ -32,7 +32,7 @@ if USB_SUPPORT
> >>>  config USB_COMMON
> >>>  	tristate
> >>>  	default y
> >>> -	depends on USB || USB_GADGET
> >>> +	depends on USB || USB_GADGET || USB_OTG
> >>>  
> >>
> >> USB_OTG can depends on USB || UB_GADGET?
> > 
> > I didn't understand. The above is for USB_COMMON.
> > 
> >>
> >>>  config USB_ARCH_HAS_HCD
> >>>  	def_bool y
> >>> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
> >>> index d8926c6..769d13b 100644
> >>> --- a/drivers/usb/Makefile
> >>> +++ b/drivers/usb/Makefile
> >>> @@ -60,5 +60,6 @@ obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
> >>>  obj-$(CONFIG_USB_GADGET)	+= gadget/
> >>>  
> >>>  obj-$(CONFIG_USB_COMMON)	+= common/
> >>> +obj-$(CONFIG_USB_OTG)		+= common/
> >>>  
> >>
> >> The comment like above.
> > 
> > What should it look like?
> > 
> 
> Can you please clarify what you meant at the above two
> comments? Thanks.
> 

Forget them, I had thought the USB_OTG could be module.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
