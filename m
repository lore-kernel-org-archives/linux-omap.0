From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCHv2 2/9] hwspinlock/omap: add support for dt nodes
Date: Tue, 1 Oct 2013 09:40:16 +0100
Message-ID: <20131001084015.GH22259@e106331-lin.cambridge.arm.com>
References: <cover.1379445653.git.s-anna@ti.com>
 <0fd6a11880894260d627a50b1e35f363625e9b1d.1379445653.git.s-anna@ti.com>
 <AE597DCC-83D7-4BCD-8990-3D63540F32EA@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AE597DCC-83D7-4BCD-8990-3D63540F32EA-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Fri, Sep 27, 2013 at 05:06:38PM +0100, Kumar Gala wrote:
> 
> On Sep 17, 2013, at 2:30 PM, Suman Anna wrote:
> 
> > HwSpinlock IP is present only on OMAP4 and other newer SoCs,
> > which are all device-tree boot only. This patch adds the
> > base support for parsing the DT nodes, and removes the code
> > dealing with the traditional platform device instantiation.
> > 
> > Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> > ---
> > .../devicetree/bindings/hwlock/omap-hwspinlock.txt | 31 +++++++++++
> > arch/arm/mach-omap2/Makefile                       |  3 --
> > arch/arm/mach-omap2/hwspinlock.c                   | 60 ----------------------
> > drivers/hwspinlock/omap_hwspinlock.c               | 23 +++++++--
> > 4 files changed, 50 insertions(+), 67 deletions(-)
> > create mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
> > delete mode 100644 arch/arm/mach-omap2/hwspinlock.c
> > 
> > diff --git a/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
> > new file mode 100644
> > index 0000000..235b7c5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
> > @@ -0,0 +1,31 @@
> > +OMAP4+ HwSpinlock Driver
> > +========================
> > +
> > +Required properties:
> > +- compatible:		Currently supports only "ti,omap4-hwspinlock" for
> > +				OMAP44xx, OMAP54xx, AM33xx, AM43xx, DRA7xx SoCs

"Currently supports" is not something I expect to see in a binding
document. That sounds like a description of the driver rather than the
binding.

How similar are these hardware modules? What are the differences?

> > +- reg:			Contains the hwspinlock register address range (base
> > +			address and length)

Is there only one register bank for the hwlock module?

> > +- ti,hwmods:		Name of the hwmod associated with the hwspinlock device
> > +
> > +Common hwlock properties:
> > +The following describes the usage of the common hwlock properties (defined in
> > +Documentation/devicetree/bindings/hwlock/hwlock.txt) on OMAP.
> > +
> > +- hwlock-base-id:	There are currently no OMAP SoCs with multiple
> > +			hwspinlock devices. The OMAP driver uses a default
> > +			base id value of 0 for the locks present within the
> > +			single hwspinlock device on all SoCs.


Driver details should not leak into bindngs...

As mentioned in the other patch, I don't think this is the way to handle
this. I think we need a phandle + args representation.

> > +- hwlock-num-locks:	This property is not required on OMAP SoCs, since the
> > +			number of locks present within a device can be deduced
> > +			from the SPINLOCK_SYSSTATUS device register.

Huh? Why define this property at all here if we don't need it and don't
use it?

The common document should state that specific bindings may use it and
should explicitly state if they do, rather than stating they don't...

Cheers,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
