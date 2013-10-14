From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Mon, 14 Oct 2013 18:27:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310141824380.22465@utopia.booyaka.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com> <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com> <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com> <20131007190322.GY8949@atomide.com> <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
 <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com> <525654AE.7060009@ti.com> <alpine.DEB.2.02.1310111749180.27397@utopia.booyaka.com> <52584785.2020504@ti.com> <alpine.DEB.2.02.1310112226130.27397@utopia.booyaka.com> <525923AB.4030807@ti.com>
 <alpine.DEB.2.02.1310132023240.27397@utopia.booyaka.com> <525C063C.9080908@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43122 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab3JNS2A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Oct 2013 14:28:00 -0400
In-Reply-To: <525C063C.9080908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, mturquette@linaro.org, linux-omap@vger.kernel.org, nm@ti.com, khilman@linaro.org, pdeschrijver@nvidia.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, swarren@nvidia.com, mark.rutland@arm.com

On Mon, 14 Oct 2013, Tero Kristo wrote:

> On 10/14/2013 02:45 AM, Paul Walmsley wrote:
>
> > 8. A few random comments about the individual clock binding data formats
> > themselves, based on a quick look:
> > 
> > A. It seems pretty odd and unnecessarily obscure to do something like
> > this:
> > 
> > dpll_usb_ck: dpll_usb_ck@... {
> >         ...
> >         reg = <0x4a008180 0x4>, <0x4a008184 0x4>, <0x4a008188 0x4>,
> > <0x4a00818c 0x4>;
> >         ...
> > };
> >
> > It's at least self-documenting to do something like this:
> > 
> > dpll_usb_ck: dpll_usb_ck@... {
> >         ...
> >         control-reg = < ... >;
> >         idlest-reg = < ... >;
> >         .. etc. ..
> > };
> 
> Some earlier version had something along these lines, but it was turned down.
> I had also reg-names as documentation purposes along, but this was unnecessary
> and was dropped also.
> 
> > Which itself might not even be needed, depending on how the DPLL control
> > code is implemented.  For example, if the relative offsets are always the
> > same for all OMAP4-family devices, maybe there's not even a need to
> > explicitly encode that into the DT data.
> 
> If I want to get rid of these, I need to add extra compatible strings for the
> dpll types. There are several weird register offsets for omap3/am3 devices.
> omap4/5/dra7/am4 behave more sanely.
> 
> > B. Seems like you can remove the "ti," prefix on the properties, since
> > they have no pretentions at genericity: they are specific to the
> > PRCM/CM/PRM IP block data, and registered by those drivers.
> 
> Can or should? It seems existing bindings use "ti," prefix even on non-generic
> bindings, meaning if I look at any other data in DT.

My comments in #8 are just regarding minor issues that don't seem
right.  I don't have a significant objection to staying with the
existing property names here if you think that they are important.

> > C. Looks like the patches use the property "autoidle-low" to indicate that
> > the autoidle bit should be inverted.  "Low" seems like the wrong
> > expression here - it invokes the actual voltage logic level of a hardware
> > signal, and we have no idea whether the hardware signal is using a low
> > voltage or a high voltage to express this condition.  Would suggest
> > something like 'invert-autoidle-bit' instead.
> >
> > D. Regarding "ti,index-starts-at-one", it seems best to explicitly state
> > which index starts at one.  The code mentions a "mux index" so please
> > consider renaming this something like "mux-index-starts-at-one" or
> > "one-based-mux-index"
> 
> The index is explicitly defined by the clock node where this is present. If it
> is a mux-clock, then it is for mux-index. If for divider clock, it is index
> for the divider.



- Paul
