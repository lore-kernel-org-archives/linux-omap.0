From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] of/platform: Allow secondary compatible match in
 of_dev_lookup
Date: Tue, 12 Apr 2016 08:13:27 -0700
Message-ID: <20160412151326.GL5995@atomide.com>
References: <1459546504-32668-1-git-send-email-tony@atomide.com>
 <20160401214053.GQ9329@atomide.com>
 <CAL_Jsq+PcTD=duHmWgHyx_ywYbT10vEtcm=79x5o5wYSkgG63g@mail.gmail.com>
 <5706348C.1040709@ti.com>
 <87d1q1r7o3.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d1q1r7o3.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@linux.intel.com> [160407 04:19]:
> Grygorii Strashko <grygorii.strashko@ti.com> writes:
> > Most probably this is required to pass some data from parent device to
> > children when parent dev instantiate children from DT, at least I've experimented with
> > this in mostly similar way (I've not added second pass and did break in the first
> > if !phys_addr, but Tony's patch is more correct).

OK that's a different use case I have, but good to know it helps
with that too.

> > For example,
> > - USB dwc3 platform/integration layer dev creates DWC3-core device (of_platform_populate())
> > - DWC3-core device creates xhci device
> > - USB dwc3 platform/integration layer dev can dynamically get rev info
> >   from HW and identify limitation/erratas/quirks which need to be applied to 
> >   to its children.
> > - DWC3-core can dynamically get rev info ...
> >
> > I was not able to find any other proper way to pass this (platfrom)data to children, except
> > using Auxdata. And, as per Felipe Balbi, It was the major reason why now
> > DWC3-core device creates xhci device manually.
> 
> doesn't device_property() solve that ? I'm just waiting for some patches
> from Heikki (in Cc) before we rip pdata from dwc3 completely. At that
> point, we can look at building xhci from DT.
> 
> The only thing that comes to mind is how this will look for PCI-only
> systems if we rip manual xHCI device creation completely.

Sounds like this dwc3 thread is a bit separate from the $subject patch
except for the legacy usage.

Regards,

Tony
