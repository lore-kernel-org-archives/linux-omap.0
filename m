From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: cpcap: Add minimal support
Date: Wed, 23 Nov 2016 07:03:01 -0800
Message-ID: <20161123150300.GA4082@atomide.com>
References: <20161119012748.17224-1-tony@atomide.com>
 <20161121114558.GJ32509@dell>
 <20161121163439.22ztjxnq535lo6dd@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161121163439.22ztjxnq535lo6dd@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Mark Rutland <mark.rutland@arm.com>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [161121 08:34]:
> On Mon, Nov 21, 2016 at 11:45:58AM +0000, Lee Jones wrote:
> > On Fri, 18 Nov 2016, Tony Lindgren wrote:
> > > +Example:
> > > +
> > > +&mcspi1 {
> > > +	#address-cells = <1>;
> > > +	#size-cells = <1>;
> > > +	ranges;
> > > +	cpcap: pmic@0 {
> > > +		compatible = "motorola,cpcap", "st,6556002";
> > > +		reg = <0 0>;	/* cs0, size 0 */
> > 
> > Is this really correct?
> 
> No, SPI devices are 1 cell and there shouldn't be a ranges prop.
> 
> > 
> > How can ranges have a size of 0x8000 and this 0?
> 
> reg here doesn't affect ranges and address translation.
> 
> Perhaps this is trying to make address translation work, but if that 
> does, it is by chance. Children of pmic addresses in the range of 
> 0-0x8000 would get translated to "cpu address" 0-0x8000 as long as the 
> DT has empty ranges up to the root. If the parent bus (i.e. SoC bus) has 
> any base address, then that is going to get added which would not be 
> good.

Yes I was thinking we can just get the register offset from the
cpcap base from dts for children. So a range from 0-0x8000.

Rob, do you have any better suggestions for doing that?

Anyways, the children can just rely on regmap too, so I'll just
drop the ranges here. If we ever come up with suitable ranges for
cases like this we can change it later.

Regards,

Tony
