From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: DRA7xx: hwmod: set DSS submodule parent
 hwmods
Date: Thu, 8 Jan 2015 10:15:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501081000180.28771@utopia.booyaka.com>
References: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com> <1418985914-9027-3-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1501022250010.27058@utopia.booyaka.com> <54AA68CF.9050904@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55642 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbbAHKPN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2015 05:15:13 -0500
In-Reply-To: <54AA68CF.9050904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tomi,

your detailed description of the problem is really great; thanks for the 
summary.

On Mon, 5 Jan 2015, Tomi Valkeinen wrote:

> On 03/01/15 00:50, Paul Walmsley wrote:
> > On Fri, 19 Dec 2014, Tomi Valkeinen wrote:
> > 
> >> Set DSS core hwmod as the parent for all the DSS submodules. This fixes
> >> the boot time DSS reset, removing the following warnings:
> >>
> >> omap_hwmod: dss_dispc: cannot be enabled for reset (3)
> >> omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> > Thanks, queued for v3.19-rc.                         
> > 
> > Note that I cannot test this patch due to lack of a DRA7xx board here.
> 
> Thanks. Unfortunately, I made a mistake with the DRA7xx patch. Well, the
> patch itself is correct, but we have some insanity in the HW that I missed:
> 
> DRA7xx has a CTRL_CORE_CONTROL_IO_2 register in the control module,
> which contains bits for various subsystems, including DCAN, PCIe, QSPI
> and DSS. At the moment only DCAN driver uses the register via syscon +
> regmap.
> 
> For DSS, the bit 0, DSS_DESHDCP_CLKEN is critical. While the bit is
> rather undocumented, it presumably enables a clock for DSS's HDCP. Now,
> we don't support HDPC in the display driver, but unfortunately the clock
> is required for the DSS hardware to initialize.

Do you know where this DSS_DESHDCP clock appears in the clock tree?  Is it 
downstream of the main DSS functional clock, or does it come from 
somewhere else?
 
> Without this patch, we see only the few warnings about dss hwmods
> "cannot be enabled", but with the patch, we see those and some WARN()s
> from hwmod as the DSS HW module does not start. So it's a bit worse.
> 
> Why I didn't notice this is that I had an u-boot version that enables
> the DSS_DESHDCP_CLKEN bit and leaves it enabled.
> 
> So what to do about the issue? You could drop/revert this patch if we
> don't see a quick solution for the DSS_DESHDCP_CLKEN. It won't fix
> anything as such, but lessens the boot-up spam.

Sounds like the thing to do in the short term is to drop that patch from 
the fixes series.  Then we can add it back when DSS_DESHDCP_CLKEN is 
sorted.  Are you OK with that for the time being?

> I don't have a good idea how to manage the bit properly. As far as I
> see, the bit has to be managed via syscon, using remap_update_bits, so
> that we get proper locking. With a quick glance, I didn't see anything
> for that in the current clock code. And can we presume that syscon is
> probed before hwmods? I guess not.

Based on the description so far, it sounds like there should be a system 
control module driver that registers this clock, along with all of the 
other clocks in the CTRL_CORE_CONTROL_IO_2 register.  Just shooting from 
the hip here, I guess we'd probably list that DSS_DESHDCP_CLKEN clock as 
an optional clock for DSS in the hwmod data, and add some code to indicate 
that it should be enabled and disabled with the main_clk.

> For the time being, I think the easiest solution would be to just set
> the bit and leave it enabled. My understanding (based on commits in TI's
> product kernel) is that leaving the DSS_DESHDCP_CLKEN enabled doesn't
> really affect much, and any increased power consumption would be too
> small to measure.
> 
> If that's the route, the question is still where to enable it. As I
> said, I have an u-boot which enables it, but I'd rather do the enabling
> in the kernel. If in the kernel, where there? It has to happen before
> the hwmod init is ran.

Yeah, that's a tricky question to answer.  If DSS_DESHDCP_CLKEN is modeled 
as a clock, then it could be marked as ENABLE_ON_INIT, but that seems like 
kind of a hack.



- Paul
