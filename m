From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 0/5] DSPBRIDGE: patches.
Date: Thu, 5 Mar 2009 07:56:00 -0600
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E22FE71DF@dlee03.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287B84DB4@dlee06.ent.ti.com>
	 <269694c00903050226q5c9328b6t94545fc8897f0c8f@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E22FE718B@dlee03.ent.ti.com>
 <94a0d4530903050542r39af0220l1b7a4117089e37df@mail.gmail.com>
 <7A436F7769CA33409C6B44B358BFFF0CFF3500FA@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51451 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbZCEN5g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 08:57:36 -0500
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF3500FA@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>
Cc: Ameya Palande <2ameya@gmail.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishant,

> Yeah it gets real confusing. How about following the same 
> rules for the OMAPZOOM kernel here too: any patch w.r.t 
> OMAPZOOM comes:
> Subj: RE: [OMAPZOOM PATCH 0/5] DSPBRIDGE: blah blah blah.
> 

-- I agree with your suggestion. The subject should have OMAPZOOM to differentiate.



Thank you,
Best regards,
Hari
 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Thursday, March 05, 2009 7:52 AM
> To: Felipe Contreras; Kanigeri, Hari
> Cc: Ameya Palande; Guzman Lugo, Fernando; Hiroshi DOYU; 
> linux-omap@vger.kernel.org
> Subject: RE: [PATCH 0/5] DSPBRIDGE: patches.
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap- 
> > owner@vger.kernel.org] On Behalf Of Felipe Contreras
> > Sent: Thursday, March 05, 2009 3:42 PM
> > To: Kanigeri, Hari
> > Cc: Ameya Palande; Guzman Lugo, Fernando; Hiroshi DOYU; linux- 
> > omap@vger.kernel.org
> > Subject: Re: [PATCH 0/5] DSPBRIDGE: patches.
> > 
> > On Thu, Mar 5, 2009 at 3:18 PM, Kanigeri, Hari 
> <h-kanigeri2@ti.com> wrote:
> > > Hi Ameya,
> > >
> > >> Hi Fernando,
> > >>
> > >> Are you using tidspbridge-pm branch from 
> > >> http://gitorious.org/projects/lk/repos/mainline ?
> > >>
> > >> Cheers,
> > >> Ameya.
> > >
> > > -- The Bridge patches will be based on omapzoom tree.
> > 
> > We are in linux-omap, not omapzoom, and this is the 
> tidspbridge branch 
> > in linux-omap:
> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
> > 2.6.git;a=shortlog;h=tidspbridge
> > 
> > I'm sure you don't want to increase the discrepancy between 
> linux-omap 
> > and omapzoom, so the patches sent to l-o should apply on top of the 
> > l-o tidspbridge in order to be merged.
> Yeah it gets real confusing. How about following the same 
> rules for the OMAPZOOM kernel here too: any patch w.r.t 
> OMAPZOOM comes:
> Subj: RE: [OMAPZOOM PATCH 0/5] DSPBRIDGE: blah blah blah.
> 
> Helps to keep things in perspective..
> Regards,
> Nishanth Menon
> 
> 