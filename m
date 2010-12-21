From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/6] Add infrastructure for conditional code and data
 sections
Date: Tue, 21 Dec 2010 23:00:28 +0100
Message-ID: <20101221230028.7d7d5e01@surf>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1292955604-8809-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<20101221192735.GG5829@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44792 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab0LUWAg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 17:00:36 -0500
In-Reply-To: <20101221192735.GG5829@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <t-petazzoni@ti.com>

On Tue, 21 Dec 2010 11:27:35 -0800
Tony Lindgren <tony@atomide.com> wrote:

> > Therefore, we introduce an infrastructure that allows to put code
> > and data into specific sections, called "conditional sections". All
> > those sections are compiled into the final kernel image, but at
> > runtime, by calling a function, we can get rid of the unused
> > sections.
> 
> Great, something is certainly needed to free the unused memory.

Nice to see that the idea is welcome. Did you had a look at the
implementation in patch 1/6 ?

> > For example, on OMAP, you can declare data as being omap2 specific
> > this way:
> > 
> >    static int __omap2_data foobar;
> > 
> > Then, in the board code of an OMAP3 or OMAP4 platform, you can call:
> > 
> >    free_unused_cond_section("omap2");
> 
> Sounds like this could be done after the cpu detection automatically?

Yes, it definitely should.

> I don't know what the section limitations are, but it would be nice
> to have a separate section for each machine.. Then we could just
> "free_unused_machines()" during the init.. :)

I don't think there are any specific limitations, so we can just create
as many section as we want.

However, in order to be able to free each section independently from
another, I have to page align all those conditional sections. This
means that having one section for only a tiny amount of data is going
to waste space instead of saving space. So the conditional section
should gather a sufficiently large amount of data (> 4 KB) to actually
be valuable.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
