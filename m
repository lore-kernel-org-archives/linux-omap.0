From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in
	linux-omap
Date: Fri, 15 Aug 2008 14:21:13 +0300
Message-ID: <20080815112112.GB16840@atomide.com>
References: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com> <5d5443650808150052l29bf0830u60ff256b51d53066@mail.gmail.com> <94a0d4530808150247g52c1e258v5b922e01fb5154bc@mail.gmail.com> <20080815.133409.81509340.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54112 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbYHOLWC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 07:22:02 -0400
Content-Disposition: inline
In-Reply-To: <20080815.133409.81509340.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, soni.trilok@gmail.com, h-kanigeri2@ti.com, x00omar@ti.com, x0023949@ti.com, felipe.contreras@nokia.com, felipe.contreras@gmail.com

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080815 13:34]:
> Thank you guys for your comments,
> 
> It seems that some of the patches couldn't be sent to ML because of
> the size limitation of vger.kernel.org ML. Now Tony is finding the
> place to put the rest up on somewhere for review. I don't know if
> reviwing these base code makes so much sense at this momenent,
> though..which doesn't mean "no probelm";p

I've copied your patches to:

http://www.muru.com/linux/tidspbridge/

> I hope that everyone could work together on this branch without any
> problems eventually.

We need to also figure out who's going to maintain the dspbridge
branch. Ideally somebody with experience with dsp and linux..

Regards,

Tony

> 
>      Hiroshi DOYU
> 
> From: "ext Felipe Contreras" <felipe.contreras@gmail.com>
> Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
> Date: Fri, 15 Aug 2008 12:47:39 +0300
> 
> > On Fri, Aug 15, 2008 at 10:52 AM, Trilok Soni <soni.trilok@gmail.com> wrote:
> > > Hi Doyu-San,
> > >
> > > On Fri, Aug 15, 2008 at 12:16 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> > >> Hello all,
> > >>
> > >> I have ported the latest TI DSP BRIDGE from "omapzoom" to linux
> > >> omap. The purpose of this port is to get this code kept in a new
> > >> dedicated branch(ex: "dspbridge") in l-o, not intended to be merged
> > >> into master or some other existing branches for now, but to provide
> > >> an efficient development space to collaborate.
> > >
> > > Thanks for starting this discussion and cleanup. I vote for this
> > > approach. It is better to have branch in linux-omap-git tree instead
> > > of separate GIT tree for better collaboration between TI and
> > > linux-omap-dsp community.
> > >
> > > Let's wait for Tony to put some inputs here, because someone has to
> > > maintain this branch and needs write access or else Tony has to do all
> > > the work of pushing/rebasing the patches in to ti-dspbridge branch :)
> > 
> > I also agree.
> > 
> > This code needs to be cleaned up first, and a separate official branch
> > will help the collaboration efforts.
> > 
> > Best regards.
> > 
> > -- 
> > Felipe Contreras
