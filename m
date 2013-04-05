From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP3+: use cpu0-cpufreq driver in device
 tree supported boot
Date: Fri, 5 Apr 2013 09:13:38 -0700
Message-ID: <20130405161338.GB10155@atomide.com>
References: <1364507576-19345-1-git-send-email-nm@ti.com>
 <1364507576-19345-2-git-send-email-nm@ti.com>
 <87ppybxxi0.fsf@linaro.org>
 <20130404025211.GA2456@snafu>
 <515D0BF1.7060802@ti.com>
 <20130404190053.GA4371@kahuna>
 <515E9E79.8010300@ti.com>
 <CAGo_u6r+JdNaCmVh+dHLppJ7eaYh4W5aL1aAg8xQfAju6PyZdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46931 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161930Ab3DEQNm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Apr 2013 12:13:42 -0400
Content-Disposition: inline
In-Reply-To: <CAGo_u6r+JdNaCmVh+dHLppJ7eaYh4W5aL1aAg8xQfAju6PyZdQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>

* Nishanth Menon <nm@ti.com> [130405 04:31]:
> On Fri, Apr 5, 2013 at 4:50 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> > On Friday 05 April 2013 12:30 AM, Nishanth Menon wrote:
> > - I am agree with Tony in his discussion in
> >> http://marc.info/?t=136370325600009&r=1&w=2
> >>
> >> *if* we are moving clock to DT, we should move the data to DT as well -
> >
> > I don't think Tony said 'move all clock data into DT'. He was suggesting
> > a combination of DT and /lib/firmware

Yes that also covers the case of 100% DT clocks and 0% /lib/firmware
clocks if somebody wants that. But most usable combination would be:

1. Parent clocks allocated by the driver

2. Timer, serial, MMC, Ethernet and whatever is needed for mounting root
   clocks defined in DT

3. The rest of the clocs loaded from /lib/firmware

> >> similar to what other platforms do - highbank as far as i can quickly
> >> see. (drivers/clk/clk-highbank.c and arch/arm/boot/dts/ecx-common.dtsi
> >
> > Well, you chose to look at highbank (which has 8 clock nodes in DT, as
> > opposed to OMAP5 which has around 250 in kernel) why don't you also look at imx?
> > drivers/clk/mxs/clk-imx28.c and Documentation/devicetree/bindings/clock/imx28-clock.txt
> > for examples.
> > They have around 65 nodes (still way lesser than OMAP) and see what
> > they do. Thats exactly what Roger does in his patch.
> >
> 
> Precisely - thanks for highlighting my view - all the more reason for
> us to move clock data out of kernel image :).
> $ c_count arch/arm/mach-omap2/cclock*_data.c|tail -1
> 8110
> $ wc -l arch/arm/mach-omap2/cclock*_data.c|tail -1
> 10310 total
> 
> that much code sitting in kernel makes it heavier for us(and others
> working on clock framework code) -
> we do also foresee that eventually dt data might move out to it's own
> repository.

Yes we want to get rid of the large amounts of static data in the
kernel. It's just a constant source for flames, and I'm getting pretty
tired of that. We already did that with pinctrl-single.c for the mux
data, so it's cleary doable even with more complex data such as the
clock data or hwmod data.

BTW, regarding the legacy mux data, although we have not yet been able
to remove the legacy mux data, we have am33xx already using it, and can
drop the omap4 legacy mux data probably for v3.11.
 
> Further, maintaining dts vs kernel code compatibility aside, consider
> adding new platforms - more code containing clock data that we have to
> carry on in kernel - If we have !
> 
> I love the idea that Roger's patch does, as a *step #1* of
> transitioning clock data out-of-kernel image and enabling drivers to
> entitle DT based boot.
> 
> if this is the only step we will ever take, then it will be a
> disappointing decision. whether the final data goes to /lib/firmware
> or arch/arm/boot/dts - even though, I prefer it in dts, I have no
> strong feelings about it.
> However, we need to be prepared (at the earliest possible time) to
> move that data out of kernel image as *step #2*.

Yes agreed, Roger's approach is a good first step. It just needs to
be a proper device driver under drivers/clock/omap. Also note that
the /lib/firmware part is an additional step to the DT defined clocks,
but might actually make it easier to implement various PM related bits
than trying to map them as DT properties.

Regards,

Tony
