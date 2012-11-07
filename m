From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] omap gpmc : add support of setting
 CYCLE2CYCLEDELAY and BUSTURNAROUND
Date: Wed, 7 Nov 2012 13:40:14 -0800
Message-ID: <20121107214014.GM6801@atomide.com>
References: <1352220277-4251-1-git-send-email-matthieu.castet@parrot.com>
 <5099478A.50901@ti.com>
 <5099504A.5060505@parrot.com>
 <5099743B.3040804@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA0E2D6@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:10972 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753187Ab2KGVkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 16:40:21 -0500
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA0E2D6@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, Matthieu CASTET <matthieu.castet@parrot.com>, Daniel Mack <zonque@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dedekind1@gmail.com" <dedekind1@gmail.com>

* Mohammed, Afzal <afzal@ti.com> [121107 01:00]:
> + Tony, Daniel
> 
> Hi,
> 
> On Wed, Nov 07, 2012 at 02:04:03, Hunter, Jon wrote:
> > On 11/06/2012 12:00 PM, Matthieu CASTET wrote:
> 
> > > I will post another patch, unless this is already done in  Afzal patch (Is there
> > > a tree where I can get Afzal pending patches ?)
> 
> > Afzal keeps his kernel tree on gitorious [1]. However, I am not sure
> > what Afzal's plans are for the remaining patches not yet merged and
> > which branch you should look at (I have a lot of problems viewing
> > anything on gitorious these days).
> > 
> > Afzal, let us know how you prefer to handle this.
> 
> My initial plan was to do timing related changes first and then dt
> conversion. But at the present moment, it seems higher priority has
> to be given for dt conversion over timing changes (it involves
> using generic timing routine for all required gpmc peripherals,
> handling additional timings inclusive of $subject) and hence timing
> related changes were put in suspended animation for now.
> 
> And Daniel has started working on gpmc dt. Let us take Tony's
> opinion on how to deal with this, Tony ?

Up to you to figure out the ordering.
 
> Following are the pending changes w.r.t timing available @[1]
> (please note that these would have to be rebased over branch/tag
> specified by Tony in reply to Matthieu's patch 3/3)
> a. d42eafa ARM: OMAP2+: nand: remove redundant rounding
> b. f229aba ARM: OMAP2+: gpmc: handle additional timings
> c. 14cbb87 ARM: OMAP2+: gpmc: generic timing calculation
> d. 9830264 ARM: OMAP2+: onenand: generic timing calculation
> e. 5f33ea5 ARM: OMAP2+: smc91x: generic timing calculation
> f. 9876020 ARM: OMAP2+: tusb6010: generic timing calculation (HEAD)
> 
> 'b' is a superset of $subject
> 
> Originally 'a' and 'b' was part of gpmc cleanup series for common
> zImage, then Tony requested for minimal changes for it, hence
> 'a' & 'b' was left out in the pull request (picked up by Tony),
> so that gpmc common zImage cleanup series would not create any
> timing related issues.

Maybe send pull requests for the ones that are ready to go?

They should be done against what we have in clean-up probably, so
omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3 or against
omap-for-v3.8/cleanup-headers-gpmc it that merges easily with
the cleanup branch.
 
> One thing to note is that cycle2cycledelay and busturnaround field's
> would get zeroed out with $subject patch for those peripheral's that
> call gpmc_cs_set_timings(). If there are any boards silently
> depending on bootloader setting these values, it may be affected, so
> this change would need to be verified for existing boards in mainline.
> 
> Perhaps 'b' (for $subject patch) can be taken ahead if Tony is
> happy with it.
> 
> And regarding patches 2 & 3 of Matthieu's series that calculate
> timings, I was wondering whether generic timing routine (c) can
> learn from it as well as vice-versa. Also with gpmc common zImage
> series, omap-nand driver does not have access to timing related
> gpmc functions, a new gpmc function would have to be exported
> that translates onfi timings to gpmc (or educate generic timing
> routine with onfi translation too ?)

Right, once we enable CONFIG_ARCH_MULTIPLATFORM, drivers trying
to include <mach/*.h> or <plat/*.h> files will fail to build.

Regards,

Tony
 
> [a] git://gitorious.org/x0148406-public/linux-kernel.git gpmc-timing
