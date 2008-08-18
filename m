From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in
	linux-omap
Date: Mon, 18 Aug 2008 16:06:25 +0300
Message-ID: <20080818130624.GH17827@atomide.com>
References: <94a0d4530808151409p309cf9e2sf1ab3274baac32fb@mail.gmail.com> <EBA93F3E4CB46947A4C5275F6308CF3E03434E08@dlee15.ent.ti.com> <94a0d4530808160257r77341fafn5f2b8404a8510203@mail.gmail.com> <20080818075624.GB12243@atomide.com> <5d5443650808180126n2dbadac6ma9fa63fc380e5d97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54574 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbYHRNGu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 09:06:50 -0400
Content-Disposition: inline
In-Reply-To: <5d5443650808180126n2dbadac6ma9fa63fc380e5d97@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, felipe.contreras@nokia.com

* Trilok Soni <soni.trilok@gmail.com> [080818 11:27]:
> Hi Tony,
> 
> On Mon, Aug 18, 2008 at 1:26 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > * Felipe Contreras <felipe.contreras@gmail.com> [080816 12:58]:
> >> Hi Vijay,
> >>
> >> On Sat, Aug 16, 2008 at 12:59 AM, Pasam, Vijay <vpasam@ti.com> wrote:
> >> >> I'm not familiar with checkpatch, but I guess the purpose is
> >> >> not to highlight functional issues.
> >> >>
> >> >> However, there are functional issues, but it makes sense to
> >> >> cleanup the code first: there's no point in analyzing code
> >> >> that is never used.
> >> >
> >> > There are about 9 errors with the latest set of patches. These are all
> >> > false positives - not really errors. Majority of warnings also fall
> >> > under this category.
> >>
> >> I'm not talking about issues returned by checkpatch, but issues
> >> visible to the human observer.
> >
> > And the two pieces of code that need to be fixed for Linux ASAP
> > for DSP are:
> >
> > - External device MMU hardware
> > - Mailbox handling
> >
> > This code needs to be shared for dsp[bios|bridge|gateway|link].
> > And it can be also used for any other devices and coprocessors
> > needing MMU handling.
> >
> 
> This task was pointed out on todo checklist created offline by
> Doyu-San during early discussion.

Good, can you guys post the checklist here for others too? At least
that could be discussed while everybody is trying to figure out
how/where/who to maintain the dsp stuff.

Tony
