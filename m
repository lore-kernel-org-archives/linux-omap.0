From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Wed, 26 Feb 2014 12:03:59 +0000
Message-ID: <20140226120359.GA27282@n2100.arm.linux.org.uk>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch> <20140225123921.GY27282@n2100.arm.linux.org.uk> <20140225134139.GA23898@earth.universe> <2364124.7r818M0xAj@avalon> <20140225205634.GZ27282@n2100.arm.linux.org.uk> <530DCC8A.6060708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <530DCC8A.6060708-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ash Charles <ash-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 26, 2014 at 01:14:18PM +0200, Tomi Valkeinen wrote:
> We have a bunch of panels and encoders used on OMAP boards, and we have
> separate, omapdss specific, drivers for those. My plan is to continue
> improving those drivers until they can be platform independent. This
> would be the Common Display Framework that's been discussed (or a
> precursor to it).

I believe CDF has been knocked on the head.

Also - DRM is not going to ever support hotplugging components - this
was discussed at kernel summit last year and David Airlie was quite
adamant about that.  So, any "framework" which forces hotplugging of
components on subsystems isn't going to fly.

This is why we now have the component helpers in the driver model -
to allow devices to be collected together into one logical subsystem
group, and bound/unbound as a group.

Remember that "hotplugging" in this context does not mean that the
user can physically do something with the hardware.  It means that
they're separate devices which can be probed/removed at will.  Every
device in Linux can be bound and unbound from its driver at any time
by userspace, and that is something which is expected to be handled
gracefully.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
