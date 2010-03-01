From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH 2/4] USB: MUSB: Enable MUSB for OMAP4 in Kconfig
Date: Mon, 1 Mar 2010 09:43:29 -0600
Message-ID: <20100301154329.GA4154@lixom.net>
References: <1267079758-14480-1-git-send-email-x0082077@ti.com> <20100225184833.GG28173@atomide.com> <20100226004233.GA3241@lixom.net> <000001cab6bf$5df75720$808918ac@apr.dhcp.ti.com> <20100226185414.GA10835@lixom.net> <001b01cab901$dadec9a0$808918ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <001b01cab901$dadec9a0$808918ac-wD+IZp/g4/2mHdYHvhjUOg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maulik <x0082077-l0cyMroinI0@public.gmane.org>
Cc: 'Tony Lindgren' <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Felipe Balbi' <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, 'Greg Kroah-Hartman' <gregkh-l3A5Bk7waGM@public.gmane.org>, 'David Brownell' <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 01, 2010 at 11:11:29AM +0530, Maulik wrote:
> > Olof,
> > 
> > We have such an option "USB_MUSB_SOC" that takes care of all platforms
> where
> > MUSB is present. But the Inventra DMA case is typical. Not all
> architectures
> > that have MUSB use Inventra DMA for e.g Davinci uses CPPI DMA.
> 
> >>Yeah, sorry. I didn't mean the INVENTRA_DMA config option as much as the
> >>top
> >>MUSB one. So you should be able to switch to that instead of adding a
> >>check for
> >>OMAP4 there then?
> 
> Olof,
> So you suggest adding something like below for OMAP4 and all others as well
> right?
> 
> comment "OMAP 44xx high speed USB support"
>         depends on USB_MUSB_HDRC && USB_MUSB_SOC


Hmm. I must be missing something, but it looks odd to have both the
USB_MUSB_HDRC and USB_MUSB_SOC high-level config options, especially since
the depends are duplicated across them.

In general, options like these tend to scale badly:

config USB_MUSB_SOC
        boolean
        depends on USB_MUSB_HDRC
        default y if ARCH_DAVINCI
        default y if ARCH_OMAP2430
        default y if ARCH_OMAP34XX
        default y if (BF54x && !BF544)
        default y if (BF52x && !BF522 && !BF523)

I.e. every single platform needs to add a new line. It's better
to have a config option that is selected from the platform code
(arch/arm/mach-omap2/Kconfig for the specific SOC in this case), that
for example does a :

config ARCH_OMAP34XX
        bool "OMAP34xx Based System"
        depends on ARCH_OMAP3
        select USB_ARCH_HAS_EHCI
	select USB_ARCH_HAS_MUSB

and then just do the USB_MUSB_HDRC or USB_MUSB_SOC config option based on:

config USB_MUSB_SOC
	boolena
	depends on USB_ARCH_HAS_MUSB
	default y

That way a new platform doesn't need to change the common files.

I also don't see the direct need to provide a specific comment saying
"44xx high speed USB support" when you configure for 44xx. With the
work Tony is doing you can build one kernel that boots across OMAP2/3/4,
which comment should then be displayed? It's better to just do a generic
comment such as "OMAP on-chip OTG USB support"

The DMA config is also a bit confusing. I scratched my head over that one
a few times, the fact that one is described with OMAP in the name, and
the other one (INVENTRA) is the one actually used on newer OMAP platforms.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
