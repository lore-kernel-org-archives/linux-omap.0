From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 3/9] ARM: OMAP2+: omap-usb-host: Get rid of
 platform_data from struct usbhs_phy_data
Date: Fri, 20 Sep 2013 09:18:22 -0700
Message-ID: <20130920161822.GR9994@atomide.com>
References: <1376561909-4406-1-git-send-email-rogerq@ti.com>
 <1376561909-4406-4-git-send-email-rogerq@ti.com>
 <20130920154406.GV26101@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130920154406.GV26101@radagast>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [130920 08:52]:
> Hi,
> 
> On Thu, Aug 15, 2013 at 01:18:23PM +0300, Roger Quadros wrote:
> > The platform data bits can be inferred from the other members of
> > struct usbhs_phy_data. So get rid of the platform_data member.
> > 
> > Build the platform data for the PHY device in usbhs_init_phys() instead.
> > 
> > Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> 
> Tony, do I get your Acked-by here and all following arch/arm/mach-omap2*
> patches in this series ?

If you can merge just this series without the .dts changes
into an immutable topic branch against let's say v3.12-rc2
when it comes out, then yes I can ack them:

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

That way I can also pull in the topic branch as needed to
avoid self inflicted merge conflicts ;) And Benoit can
set up a separate .dts branch based on your branch to make
sure the dependencies are in place before merging that one
upstream.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
