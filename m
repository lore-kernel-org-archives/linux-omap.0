From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 0/9] phy: use syscon framework APIs to set ctrl mod reg
Date: Tue, 15 Dec 2015 07:26:59 -0800
Message-ID: <20151215152659.GQ23396@atomide.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
 <725110094.6UkMkcy8u7@wuerfel>
 <566FF621.2040307@ti.com>
 <11176831.mhgJlIuj0S@wuerfel>
 <56700BC0.7020007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56700BC0.7020007-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [151215 04:47]:
> On Tuesday 15 December 2015 05:25 PM, Arnd Bergmann wrote:
> >>>
> >>> Can you explain here what the conversion is good for? Why do you
> >>> prefer the syscon mapping over a high-level driver in this case?
> >>
> >> phy-omap-control driver was added when there was no proper
> >> infrastructure for doing control module initializations. The
> >> phy-omap-control driver is not an 'actual' PHY driver and it
> >> was just a hack to do PHY related control module initializations.
> >> phy-omap-control is also getting unmanageable with the number of
> >> platforms each having number of modules (like USB, SATA, PCIe),
> >> using the same driver for control module initializations.
> >>
> >> Now with SYSCON framework being added to the kernel, phy-omap-control
> >> shouldn't be needed and it also provides a uniform API across all the
> >> modules to program the control module.
> > 
> > Ok, so the "phy-control" devices were really just a few registers of
> > a system controller device that does a lot of other things as well, right?
> 
> right.
> > 
> > Can you put your description above into the cover-letter for the series,
> > and the merge commit?

Just to confirm.. Seems like this series keeps USB working and the dts
changes can be done later after the driver changes have been merged?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
