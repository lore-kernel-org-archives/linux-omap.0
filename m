From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] DSPBRIDGE: patches.
Date: Thu, 5 Mar 2009 08:01:36 -0800
Message-ID: <20090305160135.GW6784@atomide.com>
References: <496565EC904933469F292DDA3F1663E60287B84DB4@dlee06.ent.ti.com> <269694c00903050226q5c9328b6t94545fc8897f0c8f@mail.gmail.com> <8F7AF80515AF0D4D93307E594F3CB40E22FE718B@dlee03.ent.ti.com> <94a0d4530903050542r39af0220l1b7a4117089e37df@mail.gmail.com> <7A436F7769CA33409C6B44B358BFFF0CFF3500FA@dlee02.ent.ti.com> <8F7AF80515AF0D4D93307E594F3CB40E22FE71DF@dlee03.ent.ti.com> <94a0d4530903050605j2cdf2228g4a8c869c05ce9d84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50636 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZCEQBn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 11:01:43 -0500
Content-Disposition: inline
In-Reply-To: <94a0d4530903050605j2cdf2228g4a8c869c05ce9d84@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Menon, Nishanth" <nm@ti.com>, Ameya Palande <2ameya@gmail.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Contreras <felipe.contreras@gmail.com> [090305 06:06]:
> On Thu, Mar 5, 2009 at 3:56 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> > Nishant,
> >
> >> Yeah it gets real confusing. How about following the same
> >> rules for the OMAPZOOM kernel here too: any patch w.r.t
> >> OMAPZOOM comes:
> >> Subj: RE: [OMAPZOOM PATCH 0/5] DSPBRIDGE: blah blah blah.
> >>
> >
> > -- I agree with your suggestion. The subject should have OMAPZOOM to differentiate.
> 
> Nishanth has kindly explained me that this patch, sent to the l-o
> mailing list, is not meant for the l-o tree.
> 
> A better way to differentiate patches specific for o-z is to send them
> to the o-z mailing list, instead of l-o, right?
> 
> Tony: Or have you agreed with TI that these [OMAPZOOM] patches that
> don't apply on top of l-o are ok here?

Well as long as they're clearly tagged as OMAPZOOM, things don't get
too confusing, so I'm OK with that.

But in general I'm worried as it looks like the zoom tree is just
piling up more and more hacks and ifdefs with no serious attempt to
merge that code upstream.

Everybody, we need to get the infrastructure pieces done properly
and into the mainline tree so we can use that for all our omap needs.

Sure some board specific hacks will be still needed here and there,
and tons of the omap and driver patches already apply against the
mainline kernel code.

It's up to each developer to submit their patches through the right
mailing lists to the mainline kernel. Piling up code into some other
trees only increases the diff against the mainline tree. 

Everybody, when you see a piece of omap code that's not in the
mainline kernel yet, whine and complain until the code gets
integrated.

Tony
