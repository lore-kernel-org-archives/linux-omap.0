From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v6 00/13] OMAP: GPIO: Implement GPIO in hwmod way
Date: Wed, 22 Sep 2010 19:57:44 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD3C1E71@dbde02.ent.ti.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
	<87r5goq7ro.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD3C16FE@dbde02.ent.ti.com>
	<87zkvbj7yc.fsf@deeprootsystems.com>	<87k4mefz70.fsf@deeprootsystems.com>
 <87bp7qfx6g.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54231 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456Ab0IVO14 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 10:27:56 -0400
In-Reply-To: <87bp7qfx6g.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Wednesday, September 22, 2010 5:48 AM
> To: Varadarajan, Charulatha
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; paul@pwsan.com; Cousson,
> Benoit; Nayak, Rajendra; Basak, Partha
> Subject: Re: [PATCH v6 00/13] OMAP: GPIO: Implement GPIO in hwmod way
> 
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> > Kevin Hilman <khilman@deeprootsystems.com> writes:
> >
> >> "Varadarajan, Charulatha" <charu@ti.com> writes:
> >>
> >>>>
> >>>> "Varadarajan, Charulatha" <charu@ti.com> writes:
> >>>>
> >>>> > This patch series makes OMAP2PLUS specific GPIO implemented in
> hwmod
> >>>> > FW way. This is done by implementing GPIO module in platform device
> >>>> model.
> >>>> >
> >>>> > This patch series is generated on "origin/pm-wip/pm-core" which
> >>>> > has Kevin's pm-next series, the runtime PM core patch series,
> >>>> > and a collection of hwmod fixes that Paul/Benoit have lined up
> >>>> > for 2.6.37.
> >>>> >
> >>>> > Tested on OMAP2430, OMAP44430, OMAP3430 SDP and zoom3 boards.
> >>>> > Also verified that this patch series does not break the OMAP1 build.
> >>>> >
> >>>> > This patch series is created on top of the following patches:
> >>>> > 1. OMAP: HWMOD: Handle opt clocks using clk_add_alias
> >>>> > [https://patchwork.kernel.org/patch/124531/]
> >>>> > 2. OMAP2+: GPIO: move late PM out of interrupts-disabled idle path
> >>>> > [https://patchwork.kernel.org/patch/176172/]
> >>>> > 3. OMAP: CPUIDLE: Enable IRQs during device activity check and idle
> >>>> management
> >>>> > by Kevin
> >>>> >
> >>>> > This series is tested on OMAP4430 ES2 using the below series
> >>>> > http://www.spinics.net/lists/linux-omap/msg36023.html
> >>>>
> >>>> Hi Charu,
> >>>>
> >>>> I haven't been fully through the series, but here's some quick
> feedback
> >>>> based on what I tried today.
> >>>>
> >>>> Basically, I got stuck because the first board I tried it on was the
> >>>> 35xx-based OMAP3EVM platform, which uses a GPIO-based interrupt for
> the
> >>>> network.  My setup uses DHCP + nfsroot, so the GPIO IRQ must be
> working
> >>>> during boot.
> >>>>
> >>>> The first thing I noticed, is that GPIO interrupts are not firing
> during
> >>>> boot, so neither the DHCP or the nfsroot works during boot.  I
> haven't
> >>>> been able to fully debug this, but the 3430SDP should have the same
> >>>> issue for its smc91x if you set it up for DHCP + nfsroot.  This is
> >>>> working fine on my pm-wip/idle-reorg branch which has the
> prerequisites
> >>>> you mentioned, but didn't work when I applied the clk_alias patch
> plus
> >>>> this series.
> >>>
> >>> I tested this GPIO series in pm-wip/idle-reorg branch with clock
> >>> add alias patch and I did not see any issues. I tested with DHCP +
> nfsroot
> >>> on SDP3430. Please provide me some more info on this.
> >>
> >> Hmm, I don't have many more details yet.  All I can see is that the
> GPIO
> >> bank that has the smc91x interrupt (GPIO6) is loosing interrupts, and
> >> thus preventing DHCP and nfsroot from working.
> >>
> >> Can you test using omap3_defconfig plus
> >>
> >> # CONFIG_CPU_FREQ is not set
> >> CONFIG_CPU_IDLE=y
> >
> > Some more details.  I tried on two different 35xx platforms and it works
> > on one (es3.1) and not on the other (es2.1):
> >
> > [    0.000000] Machine: Gumstix Overo
> > [    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
> >
> > but not on omap3evm:
> >
> > [    0.000000] Machine: OMAP3 EVM
> > [    0.000000] OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
> >
> >
> > Is there any chance you could get your hands on an es2.1 EVM and try
> > there?
> >
> > Please contact Sanjeev Premi in TII and I think he should be able to
> > find one for you to use temporarily.

I could reproduce this issue on 35xxEVM board (ES3.1). I am debugging
the issue. Will get back to you soon in this regard.

Machine: OMAP3 EVM
Memory policy: ECC disabled, Data cache writeback
<6>OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp)

> 
> I also just tested on n900 which has lots of GPIOs configured.  On this
> platform, suspend doesn't hit RET because both GPIO3 and GPIO4 are still
> enabled.
> 
> Kevin
