From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] Add infrastructure for conditional code and data
 sections
Date: Wed, 22 Dec 2010 10:28:41 -0800
Message-ID: <20101222182841.GS5829@atomide.com>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1292955604-8809-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20101221192735.GG5829@atomide.com>
 <20101221230028.7d7d5e01@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63363 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab0LVS2p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 13:28:45 -0500
Content-Disposition: inline
In-Reply-To: <20101221230028.7d7d5e01@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <t-petazzoni@ti.com>

* Thomas Petazzoni <thomas.petazzoni@free-electrons.com> [101221 14:00]:
> On Tue, 21 Dec 2010 11:27:35 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > > Therefore, we introduce an infrastructure that allows to put code
> > > and data into specific sections, called "conditional sections". All
> > > those sections are compiled into the final kernel image, but at
> > > runtime, by calling a function, we can get rid of the unused
> > > sections.
> > 
> > Great, something is certainly needed to free the unused memory.
> 
> Nice to see that the idea is welcome. Did you had a look at the
> implementation in patch 1/6 ?

No not yet, will take a look after we're done with this upcoming
merge window..
 
> > > For example, on OMAP, you can declare data as being omap2 specific
> > > this way:
> > > 
> > >    static int __omap2_data foobar;
> > > 
> > > Then, in the board code of an OMAP3 or OMAP4 platform, you can call:
> > > 
> > >    free_unused_cond_section("omap2");
> > 
> > Sounds like this could be done after the cpu detection automatically?
> 
> Yes, it definitely should.
> 
> > I don't know what the section limitations are, but it would be nice
> > to have a separate section for each machine.. Then we could just
> > "free_unused_machines()" during the init.. :)
> 
> I don't think there are any specific limitations, so we can just create
> as many section as we want.
> 
> However, in order to be able to free each section independently from
> another, I have to page align all those conditional sections. This
> means that having one section for only a tiny amount of data is going
> to waste space instead of saving space. So the conditional section
> should gather a sufficiently large amount of data (> 4 KB) to actually
> be valuable.

Yeah I don't know how much non-init data we have for each board-*.c
file. Maybe there is not much for each machine.

Ideally the new sections would be arch/arm generic sections and not
omap specific. I could see ARMv6 and ARMv7 sections being one way
to group them, but that does not help to drop omap3 specific data
on omap4.

Regards,

Tony
