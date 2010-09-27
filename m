From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [GIT PULL] omap2 sparse fixes
Date: Mon, 27 Sep 2010 20:30:42 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F8D7A@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
 <20100923225851.GR4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F859E@dbde02.ent.ti.com>
 <20100925001914.GO4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F8D00@dbde02.ent.ti.com>
 <20100927140747.GA13143@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53189 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab0I0PBA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 11:01:00 -0400
In-Reply-To: <20100927140747.GA13143@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Hi Russell,

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Monday, September 27, 2010 7:38 PM
> To: G, Manjunath Kondaiah
> Cc: Tony Lindgren; linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [GIT PULL] omap2 sparse fixes
> 
> On Mon, Sep 27, 2010 at 07:11:37PM +0530, G, Manjunath Kondaiah wrote:
> > > Can you please check that? Will not merge for now until we figure 
> > > out what changes with these patches.
> > > 
> > > Then, I also noticed the following exports getting added:
> > > 
> > > +EXPORT_SYMBOL(omap2_gp_clockevent_set_gptimer);
> > > +EXPORT_SYMBOL(omapfb_reserve_sram);
> > > +EXPORT_SYMBOL(omap_sram_init);
> > > 
> > > These should not be exported, they are only intended to be called 
> > > from the low-level platform init code. So exporting them 
> is not the 
> > > right fix for these.
> > 
> > I have declared these API's as extern functions in 
> respective header 
> > files.
> 
> It's hard to tell whether you're justifying having the 
> EXPORT_SYMBOLs there or not from your reply.

I tried following approches in order to fix these warnings:

1. Having these defines in .c files as extern functions.
It will generate checkpatch error if it is declared as 
extern in .c file.

2. Moving/creating header file to source code location.
This will resolve only "omap2_gp_clockevent_set_gptimer" function
since other functions are used in source files in different directories.

Only option came to my mind is, having it in header file either 
in plat or mach headers. As you said, even though it is not explicitely
declared as "EXPORT", the functions are available for all other files.

-Manjunath
