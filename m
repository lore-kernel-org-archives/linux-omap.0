From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 64/67] phy-generic.c:undefined reference
 to `usb_gadget_vbus_connect'
Date: Tue, 7 Jun 2016 17:50:08 +0800
Message-ID: <20160607095008.GC17095@shlinux2>
References: <201606062026.EQTlXIDR%fengguang.wu@intel.com>
 <87bn3ecwbz.fsf@linux.intel.com>
 <878tyicva6.fsf@linux.intel.com>
 <20160607015405.GB17095@shlinux2>
 <87wpm1basy.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87wpm1basy.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Chen <Peter.Chen-3arQi8VN3Tc@public.gmane.org>, John Youn <johnyoun-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 07, 2016 at 12:36:13PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> > On Mon, Jun 06, 2016 at 04:16:17PM +0300, Felipe Balbi wrote:
> >> 
> >> Hi,
> >> 
> >> Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
> >> > [ Unknown signature status ]
> >> >
> >> > Hi,
> >> >
> >> > kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
> >> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next
> >> >> head:   89fe2b5ab11cdf6a67d4492d893e70e330aa7060
> >> >> commit: 231b31ca34485552fe27e67dc6d30d06079c7648 [64/67] usb: gadget: move gadget API functions to udc-core
> >> >> config: x86_64-randconfig-s1-06061834 (attached as .config)
> >> >> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> >> >> reproduce:
> >> >>         git checkout 231b31ca34485552fe27e67dc6d30d06079c7648
> >> >>         # save the attached .config to linux build tree
> >> >>         make ARCH=x86_64 
> >> >>
> >> >> All errors (new ones prefixed by >>):
> >> >>
> >> >>    drivers/built-in.o: In function `nop_set_peripheral':
> >> >>>> phy-generic.c:(.text+0x14423f): undefined reference to `usb_gadget_vbus_connect'
> >> >>    drivers/built-in.o: In function `nop_gpio_vbus_thread':
> >> >>>> phy-generic.c:(.text+0x144742): undefined reference to `usb_gadget_vbus_disconnect'
> >> >
> >> > oh yeah, I have to fix this. I'll do it now.
> >> 
> >> In order to fix this, I'll have to add something like below:
> >> 
> >> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
> >> index 3644a3500b70..bd67e4ac4b61 100644
> >> --- a/drivers/usb/chipidea/Kconfig
> >> +++ b/drivers/usb/chipidea/Kconfig
> >> @@ -19,6 +19,7 @@ config USB_CHIPIDEA_OF
> >>  config USB_CHIPIDEA_PCI
> >>  	tristate
> >>  	depends on PCI
> >> +	depends on USB_GADGET=y || USB_GADGET=NOP_USB_XCEIV
> >>  	depends on NOP_USB_XCEIV
> >>  	default USB_CHIPIDEA
> >
> > Hi Felipe,
> >
> > It causes any drivers which use symbols from gadget.h needs to build
> > USB_GADGET even it only wants to be host function. Any significant
> > benefits after moving it to udc-core.c?
> 
> why is a host-only function calling into the gadget API?
> 

Well, Just like this case, the chipidea driver can be configured host
mode only, but it still uses generic phy.

Besides, we have some common code which handles vbus status, this code
will be built even at host-only mode, but will not be called since the
runtime condition is not satisfied, eg, dr_mode, device role at
register.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
