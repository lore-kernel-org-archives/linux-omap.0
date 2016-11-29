From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: cpcap: Add minimal support
Date: Tue, 29 Nov 2016 07:48:04 -0800
Message-ID: <20161129154803.GA3430@atomide.com>
References: <20161119012748.17224-1-tony@atomide.com>
 <20161121114558.GJ32509@dell>
 <20161123152652.GB4082@atomide.com>
 <20161124085926.GV10134@dell.home>
 <CAL_Jsq+8_O483raD97B8-ssaFGeVOPJcadyY4x7m0T64EbVA3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+8_O483raD97B8-ssaFGeVOPJcadyY4x7m0T64EbVA3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Marcel Partap <mpartap@gmx.net>, Mark Rutland <mark.rutland@arm.com>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh+dt@kernel.org> [161129 07:20]:
> On Thu, Nov 24, 2016 at 2:59 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 23 Nov 2016, Tony Lindgren wrote:
> >
> >> * Lee Jones <lee.jones@linaro.org> [161121 03:43]:
> >> > On Fri, 18 Nov 2016, Tony Lindgren wrote:
> >> > > --- a/drivers/mfd/Makefile
> >> > > +++ b/drivers/mfd/Makefile
> >> > > @@ -97,6 +97,7 @@ obj-$(CONFIG_MFD_MC13XXX_I2C)   += mc13xxx-i2c.o
> >> > >  obj-$(CONFIG_MFD_CORE)           += mfd-core.o
> >> > >
> >> > >  obj-$(CONFIG_EZX_PCAP)           += ezx-pcap.o
> >> > > +obj-$(CONFIG_MFD_CPCAP)          += cpcap.o
> >> >
> >> > Who is the manufacturer?
> >>
> >> Hmm that I don't know. There seems to be both ST and TI versions
> >> of this chip manufactured for Motorola. So my guess is that it
> >> should be Motorola unless there's some similar catalog part
> >> available from ST used by others. If anybody has more info
> >> on this please let me know :)
> >
> > If this IP is shared amongst vendors, it usually means it was designed
> > by someone else?  Synopsis perhaps?
> 
> xCAP names originated from Motorola cellular group with parts (going
> back to analog/2G days) coming from Motorola Semi, TI, and ST it
> seems. All individually developed AFAIK.

OK thanks. Looking at the Motorola Linux kernel source, the child
device drivers do test for both revision and vendor and apply
different workarounds based on that. It also seems that CPCAP is
only used on Motorola devices.

So based on the above, we should call it motorola-cpcap with just
a secondary device tree compatible string for the STE part numbers.

Regards,

Tony
