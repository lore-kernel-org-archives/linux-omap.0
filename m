From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in
 linux-omap
Date: Mon, 18 Aug 2008 13:15:43 +0300 (EEST)
Message-ID: <20080818.131543.163155072.Hiroshi.DOYU@nokia.com>
References: <94a0d4530808160257r77341fafn5f2b8404a8510203@mail.gmail.com>
	<20080818075624.GB12243@atomide.com>
	<5d5443650808180126n2dbadac6ma9fa63fc380e5d97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17812 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbYHRSLC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 14:11:02 -0400
In-Reply-To: <5d5443650808180126n2dbadac6ma9fa63fc380e5d97@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: soni.trilok@gmail.com
Cc: tony@atomide.com, felipe.contreras@gmail.com, vpasam@ti.com, r-woodruff2@ti.com, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, x00omar@ti.com, grgupta@ti.com, felipe.contreras@nokia.com

From: "ext Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Mon, 18 Aug 2008 13:56:59 +0530

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

I think that it would be better to summarize the list which has been
pointed out as a TODO list at first for review.

I will post it later as a starter for discussion.

  Hiroshi DOYU

