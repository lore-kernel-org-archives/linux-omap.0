From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: EHCI: Fix the hub disconnect after resume
Date: Wed, 27 Jun 2012 10:24:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206271020590.1665-100000@iolanthe.rowland.org>
References: <1340795719-28386-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340795719-28386-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 27 Jun 2012, Keshava Munegowda wrote:

> Its observed that in Beagle XM , during suspend/resume the OMAP
> EHCI controller losing the register contents. this is causing the
> hub disconnect after the resume, this is causing failure of
> device detection after the resume.
> to avoid the hub disconnect , The ehci config flag register is
> configured again , reset the phy and issue the port powers during
> resume.

The idea is good, but the implementation is wrong.

> +static int omap_ehci_bus_resume(struct usb_hcd *hcd)
> +{
> +
> +	struct device				*dev = hcd->self.controller;
> +	struct ehci_hcd_omap_platform_data	*pdata = dev->platform_data;
> +	struct resource				*regs = hcd->regs;
> +
> +	/* In case , ports are not powered and config flag not set */
> +	if (~(ehci_read(regs, EHCI_CONFIGFLAG) & 0x01)) {
> +		ehci_write(regs, EHCI_CONFIGFLAG, 0x1);
> +
> +		/*
> +		 * An undocumented "feature" in the OMAP3 EHCI controller,
> +		 * causes suspended ports to be taken out of suspend when
> +		 * the USBCMD.Run/Stop bit is cleared (for example when
> +		 * we do ehci_bus_suspend).
> +		 * This breaks suspend-resume if the root-hub is allowed
> +		 * to suspend. Writing 1 to this undocumented register bit
> +		 * disables this feature and restores normal behavior.
> +		 */
> +		ehci_write(regs, EHCI_INSNREG04,
> +			   EHCI_INSNREG04_DISABLE_UNSUSPEND);
> +
> +		/* Soft reset the PHY using PHY reset command over ULPI */
> +		if (pdata->port_mode[0] == OMAP_EHCI_PORT_MODE_PHY)
> +			omap_ehci_soft_phy_reset(dev, 0);
> +		if (pdata->port_mode[1] == OMAP_EHCI_PORT_MODE_PHY)
> +			omap_ehci_soft_phy_reset(dev, 1);
> +
> +		/* root ports should always stay powered */
> +		ehci_port_power(hcd_to_ehci(hcd), 1);
> +	}

This needs to be done in the resume routine, not the bus_resume 
routine.  Since ehci-omap doesn't have any suspend or resume routines, 
it's not surprising that the controller doesn't work correctly after 
the system is resumed.

In a couple of days I will submit a patch that will make it a lot
easier to add suspend and resume routines for EHCI platform drivers.  
Maybe you'd prefer to wait until then to fix this issue.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
