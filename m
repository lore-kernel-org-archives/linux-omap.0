From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 1/4] arm: omap: Add phy binding info for musb in
 plat data
Date: Fri, 14 Jun 2013 00:33:14 -0700
Message-ID: <20130614073314.GA20992@atomide.com>
References: <1368796954-3499-1-git-send-email-kishon@ti.com>
 <51A43E0A.8090201@ti.com>
 <51B9C3B6.1080707@ti.com>
 <51BAABB0.5060107@ti.com>
 <20130614054720.GL8164@atomide.com>
 <51BAB9EA.5090805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51BAB9EA.5090805@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux@arm.linux.org.uk, eballetbo@gmail.com, javier@dowhile0.org, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130613 23:42]:
> On 14/06/13 08:47, Tony Lindgren wrote:
> > * Kishon Vijay Abraham I <kishon@ti.com> [130613 22:41]:
> >> Hi,
> >>
> >> On Thursday 13 June 2013 06:35 PM, Tomi Valkeinen wrote:
> >>> Hi,
> >>>
> >>> On 28/05/13 08:18, Kishon Vijay Abraham I wrote:
> >>>> Hi Tony,
> >>>>
> >>>> On Friday 17 May 2013 06:52 PM, Kishon Vijay Abraham I wrote:
> >>>>> In order for controllers to get PHY in case of non dt boot, the phy
> >>>>> binding information (phy label) should be added in the platform
> >>>>> data of the controller.
> >>>>
> >>>> This series would be needed to get MUSB working in OMAP3 boards for
> >>>> non-dt boot case. Do you think this is good enough to go in this rc cycle?
> >>>
> >>> Did this or some other solution go forward? I'm still unable to boot
> >>> with usb-gadget-ethernet with v3.10-rc5.
> >>
> >> No. I think Tony is ok to take this only during next merge window.
> > 
> > Yes I'll apply them to omap-for-v3.11/fixes-non-critical. We really
> > should have basic functionaly tested and working always before the
> > merge window so we only need to do minimal fixes during the -rc cycle.
> 
> I'm mostly interested in the USB gadget ethernet for the boards I have,
> but if I'm not mistaken, all USB gadget support for many OMAP boards is
> broken in v3.10. Shouldn't that be fixed, no matter if it's a minimal
> fix or not? Or is there some other, more minimal, way to fix this?

Yes it's unfortunate it's broken. But frankly I'm pretty tired of this
constant fixing up of basic things for omaps after every merge window.

If some patches are not tested properly, then everybody,
_do_not_try_to_merge_broken_patches_upstream_. Let them float on the
mailing lists until they get fixed or forgotten. Simple as that.

If we want to fix something this late in the merge window, the patches
must have a clear description what caused the regression and what happens
without the patches. These patches don't have that. And they are marked
RFC also. So actually I'm not applying any of them before the regression
descriptions are there and the patches have been reposted without RFC
and have sufficient acks from people.

Regards,

Tony
