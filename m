From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Add dm816x hwmod support
Date: Fri, 23 Jan 2015 18:21:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501231757400.5450@utopia.booyaka.com>
References: <1421191355-12835-1-git-send-email-tony@atomide.com> <1421191355-12835-3-git-send-email-tony@atomide.com> <20150114194301.GR2419@atomide.com> <20150117163144.GQ18552@atomide.com> <20150121043436.GP7718@atomide.com>
 <alpine.DEB.2.02.1501230918390.5450@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38880 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbbAWSVt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2015 13:21:49 -0500
In-Reply-To: <alpine.DEB.2.02.1501230918390.5450@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aida Mynzhasova <aida.mynzhasova@skitlab.ru>, Brian Hutchinson <b.hutchman@gmail.com>

Hi Tony 

thought about this some more overnight...

On Fri, 23 Jan 2015, Paul Walmsley wrote:

> On Tue, 20 Jan 2015, Tony Lindgren wrote:

> > +/* L3 Interconnect entries */
> > +static struct omap_hwmod dm816x_l3_s_hwmod = {
> > +	.name		= "l3_s",
> 
> Would suggest naming this l3_slow
> 
> > +	.clkdm_name	= "alwon_l3s_clkdm",
> > +	.class		= &l3_hwmod_class,
> > +	.flags		= HWMOD_NO_IDLEST,
> > +};
> > +
> > +static struct omap_hwmod __used dm816x_l3_med_hwmod = {
> 
> Hmm, why __used for this -- maybe just add it to the hwmod list at the 
> bottom?
> 
> > +	.name		= "l3_med",
> > +	.clkdm_name	= "alwon_l3_med_clkdm",
> > +	.class		= &l3_hwmod_class,
> > +	.flags		= HWMOD_NO_IDLEST,
> > +};
> > +
> > +static struct omap_hwmod __used dm816x_l3_fast_hwmod = {
> 
> Same __used comment as above.

Looking at the TRM CLKSTCTRL registers for the various L3 buses, it 
occurred to me that if we wanted to portray this accurately, we'd 
probably need separate hwmods for the ALWON and DEFAULT branches of the L3 
as well.  So there would be six in total: 
{alwon,default}_l3_{slow,med,fast}.  

It looks like it's possible to roughly figure out which targets are 
associated with which variant of the L3 by looking at the CLKACTIVITY 
bits.  So for example, it looks like most of the L3 Slow targets are on 
ALWON_L3_SLOW according to Table 18-136 "CM_ALWON_L3_SLOW_CLKSTCTRL 
Register Field descriptions", with the exception of USB, which appears to 
be on DEFAULT_L3_SLOW according to Table 18-80 
"CM_DEFAULT_L3_SLOW_CLKSTCTRL Register Field Descriptions".

Anyway, I'm sorry to put you through this, reverse-engineering this stuff 
isn't very pleasant :-(  After reflecting on the matter, I would be OK to 
ack the merge of the original L3-related hwmod data that you proposed, 
with two changes:

- dropping the __used and adding the two hwmods to the list at the bottom, 
assuming that the system still boots in that configuration (i.e., if it 
doesn't cause problems with the clockdomain programming, since it might 
appear that there are no devices/clocks active in those clockdomains)

- adding a comment noting that there probably should be six L3 hwmods as 
described above, but that this is left for future work

It would still be cool if you could doublecheck the SYSC/SYSS data for the 
other IP blocks that are listed below.

> > +	.name		= "l3_fast",
> > +	.clkdm_name	= "alwon_l3_fast_clkdm",
> > +	.class		= &l3_hwmod_class,
> > +	.flags		= HWMOD_NO_IDLEST,
> > +};

See below, I screwed up the review comment ordering here...

> > +
> > +/*
> > + * L4 standard peripherals, see TRM table 1-12 for devices using this.
> > + * Devices using this have 125MHz SYSCLK5 clock.
> > + */
> > +static struct omap_hwmod dm816x_l4_ls_hwmod = {
> > +	.name		= "l4_ls",
> > +	.clkdm_name	= "alwon_l3s_clkdm",
> > +	.class		= &l4_hwmod_class,
> > +	.flags		= HWMOD_NO_IDLEST,
> 
> Section 18.7.17.46 "CM_ALWON_L3_CLKCTRL Register" lists an IDLEST bitfield 
> for this.

Well I meant for this comment to be attached to the l3_fast hwmod.  But 
thinking about it further, I think this IDLEST is actually associated with 
the L3 configuration *register target*, rather than the L3 itself.  This 
appears to be located at 0x44000000, according to the memory map in 
Section 1.5.1.  Register targets are usually what the IDLEST bits are 
intended to protect.  So I think it's OK to keep HWMOD_NO_IDLEST for the 
l3_fast hwmod, and then later to add a separate hwmod for the L3 config 
space.

What I meant to write was:

Section 18.7.17.48 "CM_ALWON_L4LS_CLKCTRL Register" lists an IDLEST   
bitfield for this.

> > +};
> > +
> > +/*
> > + * L4 high-speed peripherals. For devices using this, please see the TRM
> > + * "Table 1-13. L4 High-Speed Peripheral Memory Map". On dm816x, only
> > + * EMAC, MDIO and SATA use this.
> > + */
> > +static struct omap_hwmod dm816x_l4_hs_hwmod = {
> > +	.name		= "l4_hs",
> > +	.clkdm_name	= "alwon_l3_med_clkdm",
> > +	.class		= &l4_hwmod_class,
> > +	.flags		= HWMOD_NO_IDLEST,
> 
> Section 18.7.17.47 "CM_ALWON_L4HS_CLKCTRL Register" lists an IDLEST 
> bitfield for this.
> 

[ ... ]

> The 816x TRM is pretty crappy when it comes to integration documentation, 
> so it's not so easy to figure out what IP blocks are connected to which 
> initiators.  (Maybe it doesn't even matter that much in the long run; I 
> doubt anyone is going to spend much time on PM or DMA path hacking for 
> these DM816x chips.)  Anyway, I think it's pretty safe to assume that any 
> IP block with a 128-bit or 64-bit initiator port onto the interconnect 
> probably isn't connected to the L3 Slow interconnect.  So looking at 
> Figure 1-75 "L3 Interconnect Block Diagram" and Section 1.11.2.2 "L3 Port 
> Mapping" this includes the MPU L3 port, HDVICP2-{0,1,2} initiator ports, 
> IOMMU, DSP, TPTC, TPCC, VPSS M0/M1 ports, SGX, Media Controller, expansion 
> slot 0 initiator, EMIF0/1, and PCIe.    Similarly I'd assume that anything 
> with a 128-bit target port off of the interconnect is on the L3 Fast: DMM 
> T0/T1, HDVICP-{0,1,2} target ports, DSP SDMA, expansion slot 0 target.
>  
> One should be able to cross-check these in two ways: first, by clocking, 
> by looking at Table 1-73 "System Clock Domains" and Figure 1-68 "Detailed 
> Clock Architecture".  The L3 Fast is driven by SYSCLK4, so anything with 
> an interface clock of SYSCLK4 is probably hanging off the L3 Fast.  A 
> SYSCLK5 interface clock probably means either L3 Medium or L4 HS.  
> SYSCLK6 interface clocks likely mean either L3 Slow or L4 LS.
> 
> The other way to cross-check these is by the address ranges in Section 1.5 
> "Memory Map".   This looks primarily useful for L4 HS/L4 LS...

Well also as I mentioned above, one can doublecheck with the CLKSTCTRL 
registers too, at least for some of the IP blocks...

> Glancing at Table 1-73, it looks to me like a reasonable rule of thumb 
> would be that anything with a 128-bit interconnect port is probably on L3 
> Fast, anything with a 64-bit interconnect port is probably on L3 Medium, 
> and anything with a 32-bit port on the L3 is probably on L3 Slow.

... but if you agree with my earlier comments about postponing the 
accurate encoding of the details of the interconnect structure until 
later, and getting something basic that boots into mainline so we have a 
platform to regression-test against, I'm OK with putting this step off 
until later, as long as we have a comment noting that in our docs.

> > +
> > +/* UART common */
> > +static struct omap_hwmod_class_sysconfig uart_sysc = {
> > +	.rev_offs	= 0x50,
> > +	.sysc_offs	= 0x54,
> > +	.syss_offs	= 0x58,
> > +	.sysc_flags	= SYSC_HAS_SIDLEMODE |
> > +				SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> > +				 SYSC_HAS_AUTOIDLE,
> 
> Also SYSS_HAS_RESET_STATUS should be set, according to Table 23-44 "System 
> Status Register (SYSS) Field Descriptions"
> 
> > +	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,
> 
> Also SIDLE_SMART_WKUP is supported, according to Table 23-43 "System 
> Configuration Register (SYSC) Field Descriptions"

Anyway, if you can doublecheck the SYSC/SYSS data for accuracy, then the 
rest is

Acked-by: Paul Walmsley <paul@pwsan.com>

and we'll try to proceed incrementally with the rest of it.



- Paul
