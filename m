From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Thu, 21 Oct 2010 13:24:33 +0300
Message-ID: <20101021102433.GG3958@legolas.emea.dhcp.ti.com>
References: <4CBE9E69.6060803@nokia.com>
 <AANLkTinOYDBMVZ3ibG3Md7jdOuOC6NkGWaugvHwT6uqF@mail.gmail.com>
 <4CBEB312.7060400@nokia.com>
 <AANLkTikom=eRFqCJmYE+k1zn5K2MR9s8HhNXtjOvUqvr@mail.gmail.com>
 <20101020125407.GE2433@legolas.emea.dhcp.ti.com>
 <AANLkTi=+6bC=JALdCDKW_BS-jnNk3zFPuWuBT+aY=Utx@mail.gmail.com>
 <20101020151527.GF2883@legolas.emea.dhcp.ti.com>
 <AANLkTim-QeP0hfSVGUd-tHWso9HQv25TwapBBZ1KPD3=@mail.gmail.com>
 <20101020175420.GC3431@legolas.emea.dhcp.ti.com>
 <AANLkTin31dmD5OfR3-nvZSg82i3H=_xgH_isJc+Epttq@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTin31dmD5OfR3-nvZSg82i3H=_xgH_isJc+Epttq-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

hi,

On Thu, Oct 21, 2010 at 04:04:27AM -0500, Felipe Contreras wrote:
>> wouldn't a user expect USB to be enabled if the board _has_ a USB
>> connector ?
>
>Not if it's not going to be used.

and how would you know before hand if it's going to be used or not ?

>>> 1) Do you think all the OMAP3 boards should add that?
>>
>> why not ?
>
>You prefer a patch that adds one line per board rather than a patch
>that adds one line in total... That is exactly the opposite of Linus's
>complaint regarding big ARM changesets.

The thing is that what you are proposing will not scale when we have too
many boards with different transceivers. Then we will end up with things
like:

config USB_ARCH_HAS_OHCI
	boolean
	# ARM:
	default y if SA1111
	default y if ARCH_OMAP
	default y if ARCH_LH7A404
	default y if ARCH_S3C2410
	default y if PXA27x
	default y if PXA3xx
	default y if ARCH_EP93XX
	default y if ARCH_AT91
	default y if ARCH_PNX4008 && I2C
	default y if MFD_TC6393XB
	default y if ARCH_W90X900
	default y if ARCH_DAVINCI_DA8XX
	# PPC:
	default y if STB03xxx
	default y if PPC_MPC52xx
	# MIPS:
	default y if MIPS_ALCHEMY
	default y if MACH_JZ4740
	# SH:
	default y if CPU_SUBTYPE_SH7720
	default y if CPU_SUBTYPE_SH7721
	default y if CPU_SUBTYPE_SH7763
	default y if CPU_SUBTYPE_SH7786
	# more:
	default PCI

which to me would be much better that e.g. SA1111 does a select
USB_ARCH_HAS_OHCI like it's done for HAVE_CLK

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
