From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: dra7xx: Add properties to
 enable x2 lane in dra7
Date: Tue, 26 Dec 2017 10:10:09 -0800
Message-ID: <20171226181009.GE3875@atomide.com>
References: <20171219085823.8695-1-kishon@ti.com>
 <20171219085823.8695-3-kishon@ti.com>
 <20171220185715.j5h7dlricom6kuiz@rob-hp-laptop>
 <94336bfb-221d-95f7-72b2-09219b08099b@ti.com>
 <20171222182448.GZ3875@atomide.com>
 <CAL_Jsq+f3u0yvftvESKDiDF76bUiwr9hZED3ZZ75=qMMr6RL1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+f3u0yvftvESKDiDF76bUiwr9hZED3ZZ75=qMMr6RL1g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [171226 17:49]:
> On Fri, Dec 22, 2017 at 12:24 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > * Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [171222 06:06]:
> >> Hi Rob,
> >>
> >> On Thursday 21 December 2017 12:27 AM, Rob Herring wrote:
> >> > On Tue, Dec 19, 2017 at 02:28:22PM +0530, Kishon Vijay Abraham I wrote:
> >> >> Add syscon properties required for configuring PCIe in x2 lane mode.
> >> >>
> >> >> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> >> >> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> >> >> ---
> >> >>  Documentation/devicetree/bindings/pci/ti-pci.txt | 6 ++++++
> >> >>  1 file changed, 6 insertions(+)
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> >> >> index 82cb875e4cec..bfbc77ac7355 100644
> >> >> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> >> >> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> >> >> @@ -13,6 +13,12 @@ PCIe DesignWare Controller
> >> >>   - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
> >> >>           where <X> is the instance number of the pcie from the HW spec.
> >> >>   - num-lanes as specified in ../designware-pcie.txt
> >> >> + - ti,syscon-lane-conf : phandle/offset pair. Phandle to the system control
> >> >> +                   module and the register offset to specify 1 lane or
> >> >> +                   2 lane.
> >> >> + - ti,syscon-lane-sel : phandle/offset pair. Phandle to the system control
> >> >> +                  module and the register offset to specify lane
> >> >> +                  selection.
> >> >
> >> > Adding a property for every syscon register doesn't really scale and
> >> > doesn't work if the register layout changes.
> >>
> >> The register layout doesn't really change between silicon revisions and for new
> >> SoCs, the phandle and the register offset for that SoC will have to be
> >> populated again.
> 
> And what about SoCs that don't exist yet?
> 
> >> Having said that, I'm not aware of any other alternative here.
> 
> What would you do if you had 20 different syscon registers to
> configure? Add 20 properties? No, you would have per SoC functions in
> the driver to handle the different cases.

Ideally these syscon registers would be managed by some Linux
generic framework such as clock/regulator/mux/phy.

But yeah, if that does not work, then setting a SoC specific
configuration function based on the compatible value makes sense
to me.

> > Sorry I did not realize this is still open. Sounds like I need to
> > revert commit 4ece93c020e3 ("ARM: dts: dra7: Add properties to
> > enable PCIe x2 lane mode"), let me know if that is not the case.
> 
> It's fine, I guess. Keep adding more syscon phandles and then I'll NAK
> it (if I remember :)).

Already reverted, thanks for the comments.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
