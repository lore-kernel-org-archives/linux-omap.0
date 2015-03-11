From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am33xx: Move wkup_m3 node to soc node
 and add ranges
Date: Wed, 11 Mar 2015 10:32:13 -0700
Message-ID: <20150311173212.GC5264@atomide.com>
References: <1425528742-3087-1-git-send-email-d-gerlach@ti.com>
 <1425528742-3087-3-git-send-email-d-gerlach@ti.com>
 <20150305154039.GD13520@atomide.com>
 <54F88849.1090708@ti.com>
 <20150305165727.GE13520@atomide.com>
 <54FE33CA.4090709@ti.com>
 <20150310160919.GQ5264@atomide.com>
 <54FF4C32.5070106@ti.com>
 <20150311162635.GZ5264@atomide.com>
 <550078D5.7080700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <550078D5.7080700@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [150311 10:18]:
> On 03/11/2015 11:26 AM, Tony Lindgren wrote:
> > * Dave Gerlach <d-gerlach@ti.com> [150310 12:55]:
> >> Suman and I have been looking at this together, so I can comment here. An
> >> implementation like this is what Suman is referring to:
> >>
> >> +               l4_wkup: l4_wkup@44c00000 {
> >> +                       compatible = "am335-l4-wkup", "simple-bus";
> >> +                       #address-cells = <2>;
> >> +                       #size-cells = <1>;
> >> +                       ranges = <0 0           0x44c00000 0x100000>,
> >> +                                <1 0x0         0x44d00000 0x4000>,
> >> +                                <2 0x80000     0x44d80000 0x2000>;
> 
> Actually, this would be slightly different, something like
>  +                       ranges = <0 0    0x44c00000 0x100000>,
>  +                                <1 0    0x44d00000 0x100000>,
>  +                                <2 0    0x44e00000 0x4000>,
>  +				  <3 0    0x44e10000 0x2000>;
> 
> and the M3 DMEM entry below will be adjusted as <1 0x80000 0x2000>.
> 
> >> +
> >> +                       wkup_m3: wkup_m3@1,0 {
> >> +                               compatible = "ti,am3353-wkup-m3";
> >> +                               reg = <1 0x0     0x4000>,       /* M3 UMEM */
> >> +                                     <2 0x80000 0x2000>;       /* M3 DMEM */
> >> +
> >> +                               ti,hwmods = "wkup_m3";
> >> +                               ti,pm-firmware = "am335x-pm-firmware.elf";
> >> +                       };
> >> +               };
> >> +
> >>
> >> The of_* layer automatically translates everything so the pdata-quirks can still
> >> match based on wkup_m3@44d00000. The existing wkup_m3_rproc driver works almost
> >> entirely as is with this, all cpu addresses are read and mapped correctly but
> >> the driver no longer will read the actual device addresses correctly which we
> >> need for understanding where to load the firmware sections.
> > 
> > OK. I still don't quite understand how these additional ranges make sense
> > for other drivers connected to the l4_wkup. For wkup_m3, it makes sense if
> > it allows you to translate directly to the m3 address space, but is that
> > really the case here? Maybe you should have the ranges in wkup_m3 instead
> > if you want addresses for the m3?
> 
> The idea is to introduce an additional address element (first cell in
> ranges) so that the immediate child nodes bus address is referenced as 0
> (second cell) for translation for their child nodes. This is the
> approach used by the current scm node in Tero's series for OMAP4+. This
> will work tomorrow if we move the prcm, scrm node under l4_wkup with
> changes only in those nodes, and have their child nodes reg properties
> unchanged. I guess you can see the difference between the following two
> patches from Tero's PRCM series,
> https://patchwork.kernel.org/patch/5882831/ &
> https://patchwork.kernel.org/patch/5882841/

Well I just commented on Tero on that regarding the dra7 patch. I think
we need to have separate scm instances for scm_device, scm_core and
scm_wkup instead of doing multiple ranges. This based on looking at for
example 5432 TRM "Figure 18-1. Control Module Overview".

But here I think it's a different issue. You want to use ranges for getting
the m3 address space for the firmware? I'm not convinced we should
complicate the ranges for all l4_wkup drivers because of that.

Regards,

Tony
