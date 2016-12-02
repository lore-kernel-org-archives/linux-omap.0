From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: omap3: beagleboard-xm: dt: Add ethernet to the
 device tree
Date: Fri, 2 Dec 2016 10:50:17 -0800
Message-ID: <20161202185016.GG4705@atomide.com>
References: <1480528685-26259-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <4245212.aFfvVGINdT@avalon>
 <20161202165323.GC4705@atomide.com>
 <2173679.ibqUs8Vreg@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2173679.ibqUs8Vreg@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161202 10:39]:
> Hi Tony,
> 
> On Friday 02 Dec 2016 08:53:24 Tony Lindgren wrote:
> > * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161202 05:38]:
> > > On Thursday 01 Dec 2016 17:18:08 Tony Lindgren wrote:
> > >> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161130 09:58]:
> > >>>  &usbhsehci {
> > >>>  
> > >>>  	phys = <0 &hsusb2_phy>;
> > >>> 
> > >>> +
> > >>> +	#address-cells = <1>;
> > >>> +	#size-cells = <0>;
> > >>> +
> > >>> +	usb2@2 {
> > >> 
> > >> I think this should be usb1@2 instead of usb2@2? That's because it's
> > >> at /sys/bus/usb/devices/1-2 and not at /sys/bus/usb/devices/2-2?
> > >> 
> > >> Or what's the naming standard here?
> > > 
> > > Good question. As far as I know, the node name is irrelevant, only the reg
> > > value is important. Maybe we should call it hub@2 ?
> > 
> > Yeah hub sounds good to me, Rob?
> > 
> > Sohow does the kernel know which instance it is if there
> > are multiple devices? For example, below is a patch for
> > igepv5 (not yet using "hub" naming), note how it has things
> > at 3-2 and 3-2.3. So if it also had something at 1-2 and
> > 1-2.1, how would we name them?
> 
> Every time I have to deal with USB device names I need to look the naming 
> scheme up. The explanation here might not be 100% accurate.
> 
> The first number is the bus number, which more or less identifies a host 
> controller (and its root hub). That's a dynamically allocated ID that thus 
> can't be used by DT, but given that DT USB bindings create node as children of 
> a host controller, we don't need the bus number anyway.

Oh OK so that must be some deferred probe happening here giving
me the 3-2 numbering instead of 1-2 numbering.

> The numbers following the dash identify ports on hubs. 3-2 is thus the device 
> connected on port 2 of the root hub of bus 3 (which is a hub), and 3-2.3 is 
> the device connected on port 3 of the hub connected on port 2 of the root hub 
> of bus 3.
> 
> If you had 1-2 and 1-2.1 it would mean that device on port 2 of the root hub 
> of bus 1 (1-2) is a hub that has device connected on its first port (1-2.1).

OK so 1-2 and 3-2 are both at the root hub port 2 so no issue there.

BTW, considering the various versions of u-boot, just doing
udevadm info /sys/bus/usb/devices/1-2 can be used for debugging
as if configured properly in the dts it will show the three OF_*
related lines.

Seems like the "hub" naming would be good to use though.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
