From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] ARM: omap3: beagleboard-xm: dt: Add ethernet to the device tree
Date: Fri, 02 Dec 2016 15:38:21 +0200
Message-ID: <4245212.aFfvVGINdT@avalon>
References: <1480528685-26259-1-git-send-email-laurent.pinchart@ideasonboard.com> <20161202011807.GF3703@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161202011807.GF3703-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Thursday 01 Dec 2016 17:18:08 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161130 09:58]:
> >  &usbhsehci {
> >  
> >  	phys = <0 &hsusb2_phy>;
> > 
> > +
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +
> > +	usb2@2 {
> 
> I think this should be usb1@2 instead of usb2@2? That's because it's
> at /sys/bus/usb/devices/1-2 and not at /sys/bus/usb/devices/2-2?
> 
> Or what's the naming standard here?

Good question. As far as I know, the node name is irrelevant, only the reg 
value is important. Maybe we should call it hub@2 ?

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
