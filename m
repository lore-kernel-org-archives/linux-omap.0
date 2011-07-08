From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
Date: Fri, 8 Jul 2011 01:11:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107080053100.24181@utopia.booyaka.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com> <4E14B820.6070202@ti.com> <20110707055549.GC15815@atomide.com> <E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE32@staex7mb2.telecom.sna.samsung.com>,<20110707121040.GF15815@atomide.com>
 <E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE34@staex7mb2.telecom.sna.samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57297 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab1GHHLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 03:11:44 -0400
In-Reply-To: <E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE34@staex7mb2.telecom.sna.samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Martin Fouts <mfouts@sta.samsung.com>
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 7 Jul 2011, Martin Fouts wrote:

> From: Tony Lindgren [tony@atomide.com]
> 
> > The second problem we have here is "why does adding 4460 support depend
> > on a cosmetic clean-up patch". That dependency should not exist at all
> > as it seems the 4460 patches should work even without this patch.
> 
> I agree. Had the original submitter had the foresight to realize that 
> the code should work for all 44xx family processors, we would have no 
> issue at all. 

Uhhh...

The original 4430 data, which is mostly what we're talking about here, was 
added in 2009.  Maybe a few people inside TI knew what was going to change 
and what was going to be the same for future OMAP4 parts.  But even if 
someone did know, the decision of what to call a chip often isn't up to 
engineers, it's up to marketing, which picks whatever name they like.  
You know, like Linux 2.6.40^H^H^H^H^H^H3.0.

So back in 2009, the submitter and maintainers were faced with a choice:

Option 1. Submit patches with facts.  "OMAP4430".  Don't speculate what 
future, as-yet-nonexistent products will be numbered, and what their 
feature set will be.  Plan to generalize later once it is known exactly 
what needs to be generalized.

Option 2. Try to predict what marketing will call the next chip, and what 
features will still be present, then put that into the codebase.  
"OMAP44XX".  Hope you guess right so you don't have to change them all if 
marketing or engineering comes up with something different. 

So, what's the right answer?

I probably can't tell you that, but I can tell you that in 2009, option 1 
seemed more technically conservative.  So that's what we did.  Maybe that 
isn't the right answer, though.


- Paul
