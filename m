From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 0/8] drm/tilcdc: Address LCDC rev 2 color errata +
 other fixes
Date: Wed, 31 Aug 2016 12:44:49 -0700
Message-ID: <20160831194449.6zca45xs3eyngpme@atomide.com>
References: <cover.1472634657.git.jsarha@ti.com>
 <20160831180418.rte4sf5s4llyuuvn@atomide.com>
 <c049825a-0802-0637-3b1e-5290032e6d10@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c049825a-0802-0637-3b1e-5290032e6d10-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, kbeldan-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> [160831 11:49]:
> On 08/31/16 21:04, Tony Lindgren wrote:
> > * Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> [160831 06:19]:
> >>   ARM: dts: am335x-boneblack: Add blue-and-red-wiring -property to LCDC
> >>     node
> >>   ARM: dts: am335x-evm: Add blue-and-red-wiring -property to lcdc node
> >>   ARM: dts: am335x-evmsk: Whitespace cleanup of lcdc related nodes
> >>   ARM: dts: am335x-evmsk: Add blue-and-red-wiring -property to lcdc node
> > 
> > If some of these dts changes are OK for me to apply separately already,
> > please let me know.
> > 
> > Otherwise I'll tag this thread as read and assume you'll send the dts
> > changes separately when ready :)
> > 
> 
> According to my plan the drm side changes should go into 4.9.
> 
> The commit messages and the comments may look confusing without the
> implementation, but otherwise there should be no harm in applying these
> already. The new properties in dts simply wont have any effect. On the
> other hand, not having the dts changes won't have any dramatic effect
> either. The supported colour formats will just remain in the same
> incorrect state as they have always been until the dts changes are
> there. So what ever is more convenient for you.

OK well please ping me or resend just the dts changes once the driver
changes are queued. Probably safer to wait a bit in case things still
change.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
