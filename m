From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 6/6] usb: musb: Add support for ti81xx platform
Date: Mon, 29 Aug 2011 15:16:55 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC4CBB7B@dbde02.ent.ti.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
 <1314357108-2279-7-git-send-email-ajay.gupta@ti.com>
 <20110826235226.GD4829@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404EC4CBA8E@dbde02.ent.ti.com>
 <20110829083757.GD13925@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110829083757.GD13925-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> > > we really need to find a better way to handle this :-(
> >
> > How about passing the mode info from musb_config (musb->config-
> >fifo_mode),
> > same way as musb->config->fifo_cfg
> 
> not sure... Ideally we wouldn't really need those fifo tables,

Yes, if all the board files provide their own fifo_cfg.

> but I'm still thinking how to properly do that.
> 
> > Infact I think, we can kill musb->config->fifo_cfg and have only
> > musb->config->mode as in this way all the fifo tables will be at one
> > place and should help in maintenance.
> 
> The idea of musb->config->fifo_cfg was to allow boards to pass their
> optimal fifo table. If a certain product, knows it will only support
> mass storage, why not letting them enable only those needed endpoints
> in an optimized way (with double buffering, bulk combine/split, etc).

Ok fine, understood.

> > Wrapper registers are different but I will see on this and provide
> you details
> > On how the merged file would look like. I am afraid that we may have
> to use
> > Either #ifdef or cpu_is_xxx().
> 
> we can use platform_device_id to cope with the differences :-) See how
> I'm using it on dwc3 driver (Greg's usb-next branch).

Please refer the usb section in below TRMs.
da8x (aka. am1x) at http://www.ti.com/lit/ug/sprufw6b/sprufw6b.pdf
am35x at http://www.ti.com/lit/ug/sprugr0b/sprugr0b.pdf
ti81x at http://www.ti.com/lit/ug/sprugx8/sprugx8.pdf

I have compiled the differences in the register map between am35x and
ti81xx and they are listed below.

===========================================================================
Register			am35x [has one musb]	ti81xx [two musb interface]
===========================================================================
REVISION			0x00				0x0000 -> for USBSS
								0x1000 -> for musb0
								0x1800 -> for musb1

ALL USBSS registers	Not present			Available from offset
								0x0000-0x0FFC

USB_CTRL_REG		0x04				0x1014  -> for musb0
								0x1814  -> for musb1

USB_STAT_REG		0x08				0x1018  -> for musb0
								0x1818  -> for musb1

USB_EMULATION_REG		0x0c				Not present
USB_AUTOREQ_REG		0x14				Not present
USB_SRP_FIX_TIME_REG	0x18				Not present
USB_TEARDOWN_REG		0x1c				Not present

USB_IRQ_MERGED_STATUS	Present as part of		0x1020 -> for musb0
				EP_INTR_x or CORE_INTR_x	0x1820 -> for musb1
				register in am35x but	
				at different offsets			
							
USB_IRQ_EOI			Same as above		0x1024 -> for musb0
								0x1824 -> for musb1
USB_IRQ_STATUS_RAW_0	Same as above		0x1028 -> for musb0
								0x1828 -> for musb1
USB_IRQ_STATUS_RAW_1	Same as above		0x102c -> for musb0
								0x182c -> for musb1
USB_IRQ_STATUS_0		Same as above		0x1030 -> for musb0
								0x1830 -> for musb1
USB_IRQ_STATUS_1		Same as above		0x1034 -> for musb0
								0x1834 -> for musb1
USB_IRQ_ENABLE_SET_0	Same as above		0x1038 -> for musb0
								0x1838 -> for musb1
USB_IRQ_ENABLE_SET_1	Same as above		0x103c -> for musb0
								0x183c -> for musb1
USB_IRQ_ENABLE_CLR_0	Same as above		0x1040 -> for musb0
								0x1840 -> for musb1
USB_IRQ_ENABLE_CLR_1	Same as above		0x1044 -> for musb0
								0x1844 -> for musb1

EP_INTR_SRC_REG			0x20			Present as part of 
								USB_IRQ_x register in
								ti81xx but at different
								offsets
EP_INTR_SRC_SET_REG		0x24				Same as above
EP_INTR_SRC_CLEAR_REG		0x28				Same as above
EP_INTR_MASK_REG			0x2c				Same as above
EP_INTR_MASK_SET_REG		0x30				Same as above
EP_INTR_MASK_CLEAR_REG		0x34				Same as above
EP_INTR_SRC_MASKED_REG		0x38				Same as above
CORE_INTR_SRC_REG			0x40				Same as above
CORE _INTR_SRC_SET_REG		0x44				Same as above
CORE _INTR_SRC_CLEAR_REG	0x48				Same as above
CORE _INTR_MASK_REG		0x4c				Same as above
CORE _INTR_MASK_SET_REG		0x50				Same as above
CORE _INTR_MASK_CLEAR_REG	0x54				Same as above
CORE _INTR_SRC_MASKED_REG	0x58				Same as above
USB_END_OF_INTR_REG		0x60				Same as above

CPPI4.1 DMA		
REVISION 				Not present			0x2000
TEARDOWN FREE DESCRIPTOR	Not present			0x2004
EMULATION CONTROL			Not present			0x2008

TxCh0 GLOBAL_CONFIG		0x1800			0x2800
RxCh0 GLOBAL_CONFIG 		0x1808			0x2808
RxCh0 HOST_PKT_CFG_A		0x180c			0x280c
RxCh0 HOST_PKT_CFG_B		0x1810			0x2810
Similarly for all Ch till Ch #29		

INTD REVISION			0x3000			Not present
INTD EOI				0x3010			Not present
INTD EOI Interrupt vector	0x3014			Not present
INTD STATUS REG			0x3200-0x32FC		Not present
QMGR REV				0x4000			0x4000

Rest of CPPI4.1 DMA register offset are same		
============================================================================

If you compare am35x and da8x then you would find that they are mostly same
and so should be merged. They both have one musb instances.

Ti81xx has two musb interface and huge differences in register map as listed
Above so ti81xx should be in a separate file.

Apart from this, am35 and da8x is not yet runtime pm compatible but the current
patches supporting ti81x is runtime pm compliant.

I think da8x and am35x files should be merged in a separate patch once they
are tested after the merge.

Ajay
> 
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
