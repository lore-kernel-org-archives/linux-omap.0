From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: 2.6.29-rc: remaining regression: n770_defconfig,
	omap_apollon_2420_defconfig
Date: Tue, 27 Jan 2009 15:41:56 -0800
Message-ID: <20090127234155.GI32148@atomide.com>
References: <20090127225000.GC639@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090127225000.GC639-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> [090127 14:50]:
> Now that the usb_port_suspend() build error is fixed in 2.6.29-rc1-git6,
> n770_defconfig and omap_apollon_2420_defconfig now suffers from:
> 
> drivers/built-in.o: In function `ohci_omap_init':
> hid-quirks.c:(.text+0x6c620): undefined reference to `otg_get_transceiver'
> drivers/built-in.o: In function `omap_udc_probe':
> hid-quirks.c:(.init.text+0x34c0): undefined reference to `otg_get_transceiver'
> hid-quirks.c:(.init.text+0x3d40): undefined reference to `otg_put_transceiver'

Adding linux-usb to the list hoping there's already a fix for this.

To me it looks like there should be ifdef CONFIG_USB_OTG_UTILS instead
of CONFIG_USB_OTG in the drivers to keep them compiling when no
transceiver is selected.

Or otg.h should have inlined dummy functions for otg_get_transceiver
and otg_put_transceiver.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
