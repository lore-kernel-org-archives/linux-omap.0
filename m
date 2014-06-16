From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap: rework platform selection
Date: Mon, 16 Jun 2014 04:26:10 -0700
Message-ID: <20140616112610.GE17845@atomide.com>
References: <5701099.0P1SIXsHc1@wuerfel>
 <20140616110042.GD17845@atomide.com>
 <7892694.KrnV5uCBX6@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64824 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbaFPL0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2014 07:26:17 -0400
Content-Disposition: inline
In-Reply-To: <7892694.KrnV5uCBX6@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, rob.herring@linaro.org, linux-omap@vger.kernel.org, arm@kernel.org

* Arnd Bergmann <arnd@arndb.de> [140616 04:18]:
> On Monday 16 June 2014 04:00:42 Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [140616 03:06]:
> > > Commit 9851b662f659 ("ARM: use menuconfig for sub-arch menus") did more
> > > than expected, which led to two OMAP specific bugs:
> > 
> > It seems the commit above is not -rc cycle material at least not without
> > proper testing. There's a good chance of breaking a lot of the existing
> > .config files which can create a big mess as we've seen before. 
> 
> Well, Kconfig is a big mess without it at the moment. The OMAP change
> was definitely wrong there, but for all other platforms I don't see any
> risk in applying it, because there is no semantic change, only cosmetic.
> 
> > > * Turning CONFIG_ARCH_OMAP into a user-selectable option makes it possible
> > >   to have a configuration with ARCH_OMAP enabled but none of the specific
> > >   OMAP SoCs enabled, which triggers a couple of link errors due to the
> > >   layout of the Makefile
> > 
> > And so we have a regression to this old problem again :(
> 
> Yes, I didn't actually see this happen but from looking at the patch, I
> concluded that it would likely be the case.
> 
> > > * The plat-omap menu still appears mixed into the normal menuconfig list,
> > >   which is confusing and inconsistent.
> > 
> > That we should be able to remove completely soon but that's a
> > separate patch..
> 
> Ok.
> 
> > > To make matters worse, the change did not enable CONFIG_ARCH_OMAP in the
> > > defconfig files, which through some ripple effects disabled options that
> > > were implicitly enabled from OMAP2, and that caused all machines to
> > > fail booting with the unchanged config files.
> > > 
> > > This reorders the OMAP Kconfig files some more, to be consistent with
> > > the others, and also changes the defconfig files.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > Tony, can you have a look at this please? I'd like to send out the
> > > fixes for 3.16, but this is needed on top of Rob's Kconfig changes.
> > 
> > Hmm why is this patch already in linux next before getting posted
> > to the mailing lists?
> 
> I had applied Rob's patch to the fixes series but that broke all
> multi_v7_defconfig runs on the boot test machines. I didn't want to
> spend too much work on it over the weekend, but applied it so at least
> today's linux-next wouldn't regress over last week's.

Ah OK I see. Some quality time with duct tape in the basement
with the leaking pipes :)
 
> > > --- a/arch/arm/plat-omap/Kconfig
> > > +++ b/arch/arm/plat-omap/Kconfig
> > > @@ -1,6 +1,11 @@
> > > -if ARCH_OMAP
> > > +menuconfig ARCH_OMAP_ENABLE
> > > +	bool "TI OMAP platforms" if ARCH_MULTI_V6 || ARCH_MULTI_V7
> > > +	default ARCH_OMAP1
> > >  
> > > -menu "TI OMAP Common Features"
> > > +if ARCH_OMAP_ENABLE
> > > +
> > > +source "arch/arm/mach-omap1/Kconfig"
> > > +source "arch/arm/mach-omap2/Kconfig"
> > 
> > It seems to me this kind of change is going to break all the
> > existing .config files unless they are manually updated. This
> > includes all the distros and automated build systems. I'll look
> > more at it, but my initial take is that we should be able to do
> > this all with CONFIG_ARCH_OMAP + the selected OMAP SoC and should
> > not introduce any new Kconfig options.
> > 
> > For now I'd just leave out Rob's changed and this patch from fixes
> > until they have been properly tested.
> 
> Let's see if others have similar opinions Rob's patch as a whole.
> I'd still like to keep all the parts aside from the OMAP change
> and just back out the change that caused the problems.
> 
> Does that seem reasonable to you?

Yes makes sense to me if others don't have similar issues. I guess
it should be possible to verify that by diffing the generated
.config files compared to the old ones.

Regards,

Tony
