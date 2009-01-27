From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: 2.6.29-rc: remaining regression: n770_defconfig, omap_apollon_2420_defconfig
Date: Tue, 27 Jan 2009 15:45:59 -0800
Message-ID: <200901271545.59632.david-b@pacbell.net>
References: <20090127225000.GC639@n2100.arm.linux.org.uk> <20090127234155.GI32148@atomide.com>
Reply-To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090127234155.GI32148-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 27 January 2009, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> [090127 14:50]:
> > Now that the usb_port_suspend() build error is fixed in 2.6.29-rc1-git6,
> > n770_defconfig and omap_apollon_2420_defconfig now suffers from:
> > 
> > drivers/built-in.o: In function `ohci_omap_init':
> > hid-quirks.c:(.text+0x6c620): undefined reference to `otg_get_transceiver'
> > drivers/built-in.o: In function `omap_udc_probe':
> > hid-quirks.c:(.init.text+0x34c0): undefined reference to `otg_get_transceiver'
> > hid-quirks.c:(.init.text+0x3d40): undefined reference to `otg_put_transceiver'
> 
> Adding linux-usb to the list hoping there's already a fix for this.

Scheduled for 2.6.29-soon:

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6
	/gregkh-02-usb.current/usb-omap1-ohci-buildfix.patch



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
