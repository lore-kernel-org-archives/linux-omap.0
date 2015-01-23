From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Fri, 23 Jan 2015 08:47:56 -0800
Message-ID: <20150123164756.GB7718@atomide.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com>
 <20150117164709.GS18552@atomide.com>
 <CAALWOA-v=-KZ5W+Giwq9Z7rdA8JM2Q+zgqZPz-5sDrHD_b-_7A@mail.gmail.com>
 <20150117181404.GW18552@atomide.com>
 <CAALWOA-cdqPbLo4JvykGFODy2xUOozWg6OjzoGPLasJA022kJg@mail.gmail.com>
 <20150119172914.GY18552@atomide.com>
 <CAALWOA_54qoQgyCkGy10v+7-eQ87ddeCTG-dbP-P6x493HAswA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.ore.mailhop.org ([54.149.240.58]:42610 "EHLO
	smtp4.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbbAWQvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2015 11:51:15 -0500
Content-Disposition: inline
In-Reply-To: <CAALWOA_54qoQgyCkGy10v+7-eQ87ddeCTG-dbP-P6x493HAswA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150121 19:20]:
> On 19 January 2015 at 18:29, Tony Lindgren <tony@atomide.com> wrote:
> > Hmm I sort of got the idea that dm814x and dm816x were done about
> > the same time. Are you saying dm814x was actually done after dm816x?
> 
> Well, it's hard to come up with an alternate explanation of netra's
> FAPLLs showing up in the terminology of centaurus' clock tree (though
> the amount of references to them in the TRM decreased over time)
> without the FAPLLs being there themselves.
> 
> Of course a radical new design will have much more distance between
> initial development and public release than a derivative design. An
> interesting timeline is given by looking at JTAG partcodes, since
> those obviously have to be assigned somewhere during development,
> before the first silicon is produced (omap3/4/5 and centauroids
> listed):
> 
> b6d6 - omap34xx 1.0
> b7ae - omap34xx/35xx 2.x/3.x
> b81e - netra
> b852 - omap4430 1.0
> b868 - am35xx
> b891 - omap36xx / dm/am37xx
> b8f2 - centaurus
> b942 - omap5430
> b944 - subarctic
> b94e - omap4460
> b95c - omap4430 2.x
> b96b - centaurus eve (dmva3/4 / dm38x)
> b975 - omap4470
> b98c - aegis
> b990 - vayu
> b998 - omap5432
> 
> (The distance between the two omap543x variants suggests to me the ID
> is assigned early in the development, with the 5432-variant added late
> in the design, but that's just a guess.)

That's interesting info thanks :) Yeah it seems dm814x was done after
dm816x and that clears at least some of the clockdomain confusion
that I though was TRM copy-paste issue. 
 
> > Yeah this davinci_emac vs cpsw stuff is messy and I noticed too that
> > the registers are different.
> 
> BTW, if you spot any piece of the documentation making it sound like
> port 2 is special somehow, it means port 0 instead. (The host port was
> port 2 in CPSW in some earlier devices, and iirc a reference to this
> was still somewhere in the current docs)
> 
> 
> >> There's also an interesting Security Subsystem, which houses the
> >> crypto accelerators (2x AES, 2x Hash, DES, PKA, RNG), an SDMA engine,
> >> 128 KB + 16 KB of local RAM, a cortex-M3, some timers for its benefit,
> >> irq routing, and an elaborate L3 firewall instance covering both
> >> external and internal access.
> >
> > Hmm that's a lot of accelerators..
> 
> And there are gaps in the memory map suggesting maybe there were more
> submodules in earlier versions.  I know it differs from Netra's
> security subsystem since one module offset is different... hmm, now
> I'm curious. I'll see if I can find a moment to brush the dust off the
> evm816x here and make a quick inventory.

Should be usable for NFSroot with all the patches I've sent using the
ti u-boot and and appended DTB uImage. Sorry not all of it is yet in
Linux next though, I'll push a current testing branch at some point
today. The mainline u-boot was at least missing the davinci_emac
support the last time I tried.
 
> The DES module and second AES module in subarctic's memory map (and
> PRCM) appear to be ghost modules, but I'd suspect this means they are
> present on Aegis. Makes sense in combo with its magstripe card reader.
> 
> BTW, someone found genuine documentation of the AES/DES/Hash accelerators:
> http://e2e.ti.com/support/arm/sitara_arm/f/791/p/291816/1399868#1399868

Oh OK. 
 
> [random thought]  There's another interesting application of the SecSS
> cortex-M3: on GP devices it is (afaict) the only processor with
> MReqDomain=1, while this is zero for all others. This 3-bit identifier
> is used for security partitioning, and is something you can test on in
> all firewalls. It is also the "connID" for EDMA's integrated memory
> protection and proxied by EDMA transfers. The processor is also
> located in the ALWON power domain.
> 
> This puts the secM3 in a unique position to act as "device hypervisor"
> and prevent processors and DMA engines from meddling with hardware
> resources they aren't supposed to meddle with. Even if security isn't
> a concern, this would be a good idea for the same reason memory
> protection is useful to separate processes. With so many initiators
> around, if one accidently does a bogus write and clobbers someone
> else's state, the resulting failure is obviously rather hard to debug.

Yeah could be handy :)

Regards,

Tony
