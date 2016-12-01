From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] ARM: omap3: beagleboard-xm: dt: Add ethernet to the device tree
Date: Thu, 01 Dec 2016 23:37:53 +0200
Message-ID: <2270015.ToMLQLZcVX@avalon>
References: <1480528685-26259-1-git-send-email-laurent.pinchart@ideasonboard.com> <20161201211234.GA3703@atomide.com> <20161201213515.GB3703@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161201213515.GB3703-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 01 Dec 2016 13:35:16 Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161201 13:14]:
> > * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161130 09:58]:
> > > The Beagleboard-xM has a LAN9514 USB hub and ethernet controller,
> > > connected to port 2 of the OMAP EHCI controller. The board however has
> > > no EEPROM to store the ethernet MAC address, which is programmed by the
> > > boot loader.
> > > 
> > > To allow Linux to use the same MAC address as the boot loader (or for
> > > that matter any fixed MAC address), we need a node in the device tree
> > > for the ethernet controller that the boot loader can update at runtime
> > > with a local-mac-address property. Add it, along with an alias for the
> > > ethernet controller to let the boot loader locate it easily.
> > 
> > Does not seem to work here.. Do I need to set something in u-boot?
> > I'm using U-Boot 2016.09-00004-g26bb688.
> 
> Looks like my u-boot only has usbethaddr in the environment. After doing
> setenv ethaddr it's now working :)

Nice to know, thanks for the tip :-)

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
