From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
Date: Tue, 3 Jul 2018 00:07:43 -0700
Message-ID: <20180703070743.GG112168@atomide.com>
References: <20180606060826.14671-5-faiz_abbas@ti.com>
 <20180607073530.GH5738@atomide.com>
 <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
 <20180608062158.GI5738@atomide.com>
 <acdfef83-8778-e8f4-e423-ed04a9a8a649@ti.com>
 <20180611060957.GN5738@atomide.com>
 <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
 <20180611062904.GO5738@atomide.com>
 <89d55b0b-fe9e-793b-2694-25755ac2bc15@ti.com>
 <20180611070332.GP5738@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180611070332.GP5738@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, mark.rutland@arm.com, paul@pwsan.com, t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180611 07:06]:
> * Faiz Abbas <faiz_abbas@ti.com> [180611 06:48]:
> > Hi,
> > 
> > On Monday 11 June 2018 11:59 AM, Tony Lindgren wrote:
> > > * Faiz Abbas <faiz_abbas@ti.com> [180611 06:28]:
> > >> Great. I thought I completely misunderstood you. But I don't see what
> > >> adding another function will accomplish. A QUIRK flag used in the same
> > >> function would work well enough>
> > > Fine with me as long as the function stays simple for both
> > > syss and sysc reset.
> > >
> > 
> > 
> > In general a reset status bit being in sysstatus is the norm and it
> > being in sysconfig should be the "quirk" for which a flag needs to be
> > added. What do you think?
> 
> Sure makes sense to me.
> 
> > As an aside, naming bitshifts by the name of the platform they were
> > originally added in seems weird. There should be some generic mask
> > saying "soft reset is the 0th bit". Currently I am using
> > SYSC_OMAP4_SOFTRESET for a dra76x module. I guess it depends on how many
> > different sysconfig types we have.
> 
> Sure we could have a macro for that.

So what's the conclusion on this one? Are you going to do one
more version of the ti-sysc driver patch?

Regards,

Tony
