From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Add clock domain support for dm816x
Date: Fri, 23 Jan 2015 09:16:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501230836020.5450@utopia.booyaka.com>
References: <1421191355-12835-1-git-send-email-tony@atomide.com> <1421191355-12835-2-git-send-email-tony@atomide.com> <alpine.DEB.2.02.1501210128020.5450@utopia.booyaka.com> <20150121041145.GO7718@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33451 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbbAWJQV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2015 04:16:21 -0500
In-Reply-To: <20150121041145.GO7718@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aida Mynzhasova <aida.mynzhasova@skitlab.ru>, Brian Hutchinson <b.hutchman@gmail.com>

Hi Tony

On Tue, 20 Jan 2015, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [150120 18:08]:
> > On Tue, 13 Jan 2015, Tony Lindgren wrote:
>  
> > > +/* Common TI81XX */
> > 
> > I can't comment on how many of these are truly common; since I haven't 
> > cross-checked this file against the 814x TRM.  But if you haven't had the 
> > chance to cross-check it against the 814x TRM either, I'd suggest starting 
> > by making this file explicitly 816x-specific.
> 
> Seem to be common in the old TI PSP tree too at:
> http://arago-project.org/git/projects/?p=linux-omap3.git;a=summary
> 
> Except it seems that dm814x has CLKDM_CAN_SWSUP while dm816x
> has CLKDM_CAN_HWSUP_SWSUP. I've booted that tree only on dm816x
> but let's assume it also works for dm814x as that's the TI tree
> for it.

Just looked at SPRUGZ8E, the 814x TRM.  According to that, it's the 814x
that supports HW_AUTO on more of the clockdomains, compared to the 816x 
TRM which states that on that chip, HW_AUTO is only supported on 
ALWON_L3_FAST on 816x.

CLKDM_CAN_SWSUP should be safe to use on clockdomains that don't support 
HW_AUTO.  But using CLKDM_CAN_HWSUP_SWSUP on clockdomains that don't 
support HW_AUTO will wind up programming register values marked as 
"reserved" in the TRM.

Here's what I'd suggest.  This file is marked as common to all 81xx chips.  
So the safe thing to do is to mark all of the clockdomains as 
CLKDM_CAN_SWSUP except for ALWON_L3_FAST.  (ALWON_L3_FAST is documented as 
supporting HW_AUTO on both chips.)

Otherwise, if there's some reason why you'd want to keep 
CLKDM_CAN_HWSUP_SWSUP (I can't really think of any, BTW), please add a 
comment to the data stating that you're going with the CLKDM_CAN_* 
settings from the 816x tree, even though they don't match the TRM; and 
that those should be investigated if there's any problem with full chip 
idle.

> Looks like TI's tree has these ifdef else and 816x seems to
> have both CAN_HWSUP_SWSUP so probably the TRM is wrong.
> 
> My guess the TRM for 816x has tons of copy-paste errors from the
> dm814x TRM. So I've kept all them the same way as the TI tree has
> them.

I'd be pretty skeptical of the TI tree data.  If there were cut-and-paste 
errors for this data from the 814x TRM, then the 816x TRM would show more 
clockdomains supporting HW_AUTO.  But given the difference in these 
documented clockdomain bitfields, I'd say it's unlikely that there are 
cut-and-paste issues there.

> > > +static struct clockdomain default_ducati_816x_clkdm = {
> > 
> > I can't find any mention of the Ducati in the TRM.  Does this SoC have a 
> > Ducati?
> 
> So it seems for dm816x. Also clock816x_data.c references ducati_ick.

...

> > According to the TRM here, looks like this should just be 
> > "default_816x_clkdm" ?  The corresponding register is named 
> > CM_DEFAULT_CLKSTCTRL.  It references two clockdomains, GCLKINTR and 
> > GCLKIN200TR, but I can't find any other mention of those in the TRM, so, 
> > no idea what they're associated with.
> 
> No mention of CM_DEFAULT_CLKSTCTRL in the TI tree. It seems the
> TRM is wrong here too.

Am thinking they might have rebranded the Ducati as something else.  
Maybe they got sued ;-)  The dm814x TRM lists DUCATI in the names for 
these registers, so it's fine with me to keep using them here.

...

I tried applying a version of this patch, but looks like it has a 
dependency on some mach-omap2/io.c changes that I don't have a stable 
commit for.  How about this: if you can change the CLKDM_CAN_HWSUP_SWSUP 
to CLKDM_CAN_SWSUP in most cases, then feel free to add my Reviewed-by: 
and to merge it.  Otherwise if you'd prefer me to take it upstream, let me 
know what stable commit I should base the pull request on.


I appreciate the discussion,

- Paul
