From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] ARM: omap3: beagleboard-xm: dt: Add ethernet to the
 device tree
Date: Thu, 5 Jan 2017 08:19:02 -0800
Message-ID: <20170105161902.GC4310@atomide.com>
References: <1480713097-5931-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1480713097-5931-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161202 13:11]:
> The Beagleboard-xM has a LAN9514 USB hub and ethernet controller,
> connected to port 2 of the OMAP EHCI controller. The board however has
> no EEPROM to store the ethernet MAC address, which is programmed by the
> boot loader.
> 
> To allow Linux to use the same MAC address as the boot loader (or for
> that matter any fixed MAC address), we need a node in the device tree
> for the ethernet controller that the boot loader can update at runtime
> with a local-mac-address property. Add it, along with an alias for the
> ethernet controller to let the boot loader locate it easily.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
> Changes since v1:
> 
> - Renamed usb2 DT node to hub

Applying this finally into omap-for-v4.11/dt. Will post my related
patches using the hub naming shortly.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
