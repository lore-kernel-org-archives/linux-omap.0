From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
Date: Tue, 11 Aug 2009 23:43:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908112319520.8886@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0306050331@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50280 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbZHLFnk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 01:43:40 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0306050331@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: khilman@deeprootsystems.com, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>

Hi guys

On Wed, 12 Aug 2009, Nayak, Rajendra wrote:

> >From: Paul Walmsley [mailto:paul@pwsan.com] 
> >
> >On Wed, 12 Aug 2009, Shilimkar, Santosh wrote:
> >
> >> > I'd also like to see the full names of the PRCM submodules, e.g.,
> >> > 
> >> > OMAP4430_CM2_RESTORE_CM2_MOD
> >> > 
> >> > rather than just
> >> > 
> >> > OMAP4430_CM2_RESTORE_MOD
> >> 
> >> Not sure what you mean by __full__ name here. You are adding 
> >a redundant CM2 in the name here.
> >
> >Yes, for the above example, it looks pretty redundant, doesn't 
> >it.  But 
> >what about:
> >
> >OMAP4430_PRM_WKUP_CM_MOD 
> 
> There are only 2 such instances of these where in WKUP_CM and EMU_CM and 
> part of PRM module. There are no such instances in CM1 or CM2. To take 
> care of 2 of these we would have 60 odd which would look redundant and 
> module names as along as this OMAP4430_PRM_ALWAYS_ON_PRM_MOD.
>
> If its really confusing and hard to remember that these belong to PRM we 
> can always have exceptions in naming

So, you propose that we have a rule here to drop the _{PRM,CM1,CM2} from 
the end of the PRCM subdomain name, if it is in the same "type" of PRCM 
module, e.g., drop the _PRM if it is in the PRM, _CM* if in a CM?  

So the first example, for CM2.RESTORE_CM2 would be:

OMAP4430_CM2_RESTORE_MOD

and the second example, for PRM.WKUP_CM would be:

OMAP4430_PRM_WKUP_CM_MOD

That particular rule seems basically okay to me.  The redundancy does 
suck.  It can be encoded in the autogeneration scripts easily.

Any other comments/preferences on this from others in OMAP PM-land?

> and we have had exceptions in 3430 as well. There are modules common to 
> 2430/3430 which are named differently as well as modules only in ES2 
> which are named differently.

Are you referring to the platform prefixes, e.g., 
OMAP3430ES2_USBHOST_MOD, or something else here?  The platform prefixes 
strike me as a very different situation.  For example, if you see accesses 
to an ES2 module in a 3430-wide code path, you know there is a problem, it 
sticks out like a sore thumb.

Of course, even on OMAP2/3, looking back on it, we should have added some 
sort of PRCM notation in those defines, like OMAP3430ES2_PRCM_USBHOST_MOD, 
to mark that they are PRCM-specific defines ...


- Paul
