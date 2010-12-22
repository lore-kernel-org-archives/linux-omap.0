From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] Add infrastructure for conditional code and data
 sections
Date: Wed, 22 Dec 2010 11:02:56 -0800
Message-ID: <20101222190256.GD7771@atomide.com>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1292955604-8809-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20101221192735.GG5829@atomide.com>
 <20101221230028.7d7d5e01@surf>
 <20101222182841.GS5829@atomide.com>
 <20101222194247.35b571fc@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:42670 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab0LVTDB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 14:03:01 -0500
Content-Disposition: inline
In-Reply-To: <20101222194247.35b571fc@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <t-petazzoni@ti.com>

* Thomas Petazzoni <thomas.petazzoni@free-electrons.com> [101222 10:55]:
> On Wed, 22 Dec 2010 10:28:41 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > > Nice to see that the idea is welcome. Did you had a look at the
> > > implementation in patch 1/6 ?
> > 
> > No not yet, will take a look after we're done with this upcoming
> > merge window..
> 
> Great, thanks.
> 
> > Ideally the new sections would be arch/arm generic sections and not
> > omap specific. I could see ARMv6 and ARMv7 sections being one way
> > to group them, but that does not help to drop omap3 specific data
> > on omap4.
> 
> The mechanism is architecture independent, not OMAP-specific or even
> ARM-specific (the only architecture-dependent part is the modification
> of the kernel linker script, but it's trivial to adapt to other arches).
> You can put as many sections as you want, you just need to declare some
> macros:
> 
> #define __something_data cond_data_section(something)
> #define __something_text cond_text_section(something)
> 
> and then mark whatever you want with __something_data or
> __something_text. It will then be part of separate sections, that are
> page-aligned so that they can independently be freed.

OK sounds like you've already made it generic :)
 
> For the moment, the API allows to tell which sections you want to
> *free*, but I think I should turn it into an API that allows to tell
> which sections you want to *keep*. This way, if you have sections for
> 100 machines and you boot on a given machine, you only need to say "I'm
> using this section". At the end of the kernel boot process, all
> sections that have not been marked as useful would be removed.

Yeah keeping only the code for the current machine might be easier.

Regards,

Tony
