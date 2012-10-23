From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 1/7] ARM: OMAP2xxx: hwmod: Convert SHAM crypto device
 data to hwmod
Date: Tue, 23 Oct 2012 15:02:37 -0700
Message-ID: <20121023220237.GA19671@animalcreek.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
 <1350683640-15044-2-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1210201934550.27264@utopia.booyaka.com>
 <20121022193336.GA1708@animalcreek.com>
 <alpine.DEB.2.00.1210221935320.13464@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:43053 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324Ab2JWWCj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 18:02:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210221935320.13464@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Oct 22, 2012 at 07:49:47PM +0000, Paul Walmsley wrote:
> On Mon, 22 Oct 2012, Mark A. Greer wrote:
> 
> > On Sat, Oct 20, 2012 at 07:40:19PM +0000, Paul Walmsley wrote:
> >
> > > >  static void omap_init_sham(void)
> > > >  {
> > > > -	if (cpu_is_omap24xx()) {
> > > > -		sham_device.resource = omap2_sham_resources;
> > > > -		sham_device.num_resources = omap2_sham_resources_sz;
> > > > +	if (cpu_is_omap24xx() &&
> > > > +	    (omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_IDLEST4) &
> > > > +						 OMAP24XX_ST_SHA_MASK)) {
> > > 
> > > Hmm.  Not sure I understand the purpose of this CM read.  Don't we want to 
> > > initialize this device unconditionally?
> > 
> > No, the device doesn't exist on all parts.
> 
> It should exist on all OMAP2xxx, AFAIK.  (Whether some bootloader 
> firewalled it off is another matter, of course.)
> 
> >  This is the only way to tell if its there (AFAIK).
> 
> Hmm.  I don't think the CM_IDLEST bits work that way, in the general case.  
> They just indicate whether the PRCM considers that IP block to be 
> currently accessible.  So for example if the clocks are disabled to an IP 
> block, the CM_IDLEST bit would indicate that it's not accessible.  The 
> software could then enable the clocks, and the CM_IDLEST bit would 
> indicate that it is accessible.  We use this in the clock framework and 
> hwmod code after enabling clocks to wait until the system considers the IP 
> block accessible.  See for example
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/clock.c;h=961ac8f7e13d8c84a1cbb4587255ea685520bd18;hb=HEAD#l80
> 
> ...
> 
> Now it's possible that on some TI chips, the CM_IDLEST bit is tied to the 
> SIdleAck signal originating from the IP block.  (I've been told that on 
> other OMAPs, CM_IDLEST is actually tied to the SIdleReq signal originating 
> from the PRCM, which is not terribly useful...)  So if it's tied to the 
> SIdleAck signal, and the PRCM clocks are enabled, then it might provide an 
> indication of whether the IP block exists on that chip.  But ultimately 
> the IP block might still be firewalled off even if it appears to exist to 
> the PRCM.  So for 3xxx, I'd suggest just adding it to the appropriate 
> GP-specific hwmod init lists, such as omap3xxx_gp_hwmod_ocp_ifs.

Paul, thank you for the clear explanation.

I've talked to some hardware guys and I have come to the following
conclusions:

a) What you say above about CM_IDLEST is correct.
b) There seems to be no good way, in general, to tell if the SHA
   (or AES or RNG or ...) module exists.
c) The best thing to do is what you suggest and add the SHA hwmod
   data for all omap2's and omap3 GP's.

I will respin my patches with everyone's comments addressed later today.

Thanks everyone.

Mark
--
